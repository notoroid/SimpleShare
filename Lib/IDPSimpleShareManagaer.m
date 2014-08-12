//
//  IDPSimpleShareManagaer.m
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/24.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import "IDPSimpleShareManagaer.h"
#import "IDPShareBackgroundView.h"
#import "IDPSimpleShareViewController.h"
@import MessageUI;

@import AssetsLibrary;

static IDPSimpleShareManagaer *s_simpleShareManagaer;

@interface IDPSimpleShareManagaer ()
{
    ALAssetsLibrary *_library;
    NSDictionary *_captionsByIconType;
    dispatch_group_t _groupSave;
}
@property(readonly,nonatomic) ALAssetsLibrary *library;
@end

@implementation IDPSimpleShareManagaer

- (ALAssetsLibrary *)library
{
    if( _library == nil ){
        _library = [[ALAssetsLibrary alloc] init];
    }
    return _library;
}

+ (IDPSimpleShareManagaer *) sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_simpleShareManagaer = [[IDPSimpleShareManagaer alloc] init];
    });
    return s_simpleShareManagaer;
}

// Returns the URL to the application's Documents directory.
- (NSURL *)documentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSDictionary *) captionsByIconType
{
    if( _captionsByIconType == nil ){
        _captionsByIconType = @{
                                 @(IDPShareBackgroundViewIconTypeInstagram):IDP_SIMPLESHARE_LOCALIZED_INSTAGRAM_TITLE
                                 ,@(IDPShareBackgroundViewIconTypeTwitter):IDP_SIMPLESHARE_LOCALIZED_TWITTER_TITLE
                                 ,@(IDPShareBackgroundViewIconTypeFacebook):IDP_SIMPLESHARE_LOCALIZED_FACEBOOK_TITLE
                                 ,@(IDPShareBackgroundViewIconTypeLINE):IDP_SIMPLESHARE_LOCALIZED_LINE_TITLE
                                 ,@(IDPShareBackgroundViewIconTypeMessage):IDP_SIMPLESHARE_LOCALIZED_MESSAGE_TITLE
                                 ,@(IDPShareBackgroundViewIconTypeMail):IDP_SIMPLESHARE_LOCALIZED_MAIL_TITLE
                                 ,@(IDPShareBackgroundViewIconTypePasteboard):IDP_SIMPLESHARE_LOCALIZED_COPY_TITLE
                                 ,@(IDPShareBackgroundViewIconTypeOther):IDP_SIMPLESHARE_LOCALIZED_OTHER_TITLE
                                 ,@(IDPShareBackgroundViewIconTypeDocumentInteraction):IDP_SIMPLESHARE_LOCALIZED_OPEN_IN_TITLE
                                 ,@(IDPShareBackgroundViewIconTypeResolution):IDP_SIMPLESHARE_LOCALIZED_SELECT_RESOLUTION_TITLE
                                 ,@(IDPShareBackgroundViewIconTypeSmall):IDP_SIMPLESHARE_LOCALIZED_SMALL_TITLE
                                 ,@(IDPShareBackgroundViewIconTypeNormal):IDP_SIMPLESHARE_LOCALIZED_NORMAL_TITLE
                                 ,@(IDPShareBackgroundViewIconTypeLarge):IDP_SIMPLESHARE_LOCALIZED_LARGE_TITLE
                                 ,@(IDPShareBackgroundViewIconTypeCameraRoll):IDP_SIMPLESHARE_LOCALIZED_POST_AFTER_TITLE
                                 ,@(IDPShareBackgroundViewIconTypeBack):IDP_SIMPLESHARE_LOCALIZED_BACK_TITLE
                                 };
    }
    
    return _captionsByIconType;
}

- (void) saveImage:(UIImage *)image withAlbumName:(NSString *)albumName metadata:(NSDictionary *)metadata completion:(void (^)(BOOL finished))completion
{
    if( image == nil ){
//        NSLog(@"保存するイメージが見つからない。");
        completion(NO);
    }
    
    __block BOOL finished = NO;
    
    _groupSave = dispatch_group_create();
    dispatch_group_async(_groupSave, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) , ^{
        // 写真を保存
        __block BOOL undiscoveredGroup = YES;
        [self.library writeImageToSavedPhotosAlbum:image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
            if( assetURL != nil ){
                if( albumName.length > 0 ){
                    [self.library assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                        [self.library enumerateGroupsWithTypes:ALAssetsGroupAlbum
                                                    usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                                        if( group != nil ){
                                                            NSString* name = [group valueForProperty:ALAssetsGroupPropertyName];
                                                            if( [name compare:albumName] == NSOrderedSame ){
                                                                // このassetGroup にassetを追加
                                                                [group addAsset:asset];
                                                                
                                                                finished = YES;
                                                                
                                                                undiscoveredGroup = NO;
                                                                *stop = YES;
                                                            }
                                                        }else{
                                                            if( undiscoveredGroup == YES ){
                                                                [self.library addAssetsGroupAlbumWithName:albumName resultBlock:^(ALAssetsGroup *group) {
                                                                    // このassetGroup にassetを追加
                                                                    [group addAsset:asset];
                                                                    
                                                                    finished = YES;
                                                                    
                                                                } failureBlock:^(NSError *error) {
                                                                    finished = NO;
                                                                        // 致命的なエラー
                                                                }];
                                                            }
                                                            
                                                        }
                                                    }
                                                  failureBlock:^(NSError *error) {
                                                      //                                      NSLog(@"保存失敗");
                                                      //                                      NSLog(@"Error %@, %@", error, [error userInfo]);
                                                      
                                                      // 致命的なエラーなのでキャンセルを呼び出しておく
                                                      finished = NO;
                                                  }
                         ];
                    } failureBlock:^(NSError *error) {
                        finished = NO;
                    }];
                }else{
                    finished = YES;
                }
            }
        }];
    });
    
    dispatch_group_notify(_groupSave, dispatch_get_main_queue(), ^{
        completion(finished);
    });
    
    
    
}



@end
