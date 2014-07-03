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
                                 @(IDPShareBackgroundViewIconTypeInstagram):@"Instagram"
                                 ,@(IDPShareBackgroundViewIconTypeTwitter):@"Twitter"
                                 ,@(IDPShareBackgroundViewIconTypeFacebook):@"Facebook"
                                 ,@(IDPShareBackgroundViewIconTypeLINE):@"LINE"
                                 ,@(IDPShareBackgroundViewIconTypeMessage):@"メッセージ"
                                 ,@(IDPShareBackgroundViewIconTypeMail):@"メール"
                                 ,@(IDPShareBackgroundViewIconTypePasteboard):@"コピー"
                                 ,@(IDPShareBackgroundViewIconTypeOther):@"その他"
                                 ,@(IDPShareBackgroundViewIconTypeDocumentInteraction):@"アプリで開く"
                                 ,@(IDPShareBackgroundViewIconTypeResolution):@"解像度を指定"
                                 ,@(IDPShareBackgroundViewIconTypeSmall):@"コンパクト"
                                 ,@(IDPShareBackgroundViewIconTypeNormal):@"高精細度"
                                 ,@(IDPShareBackgroundViewIconTypeLarge):@"大きい"
                                 ,@(IDPShareBackgroundViewIconTypeCameraRoll):@"あとで投稿"
                                 ,@(IDPShareBackgroundViewIconTypeBack):@"戻る"
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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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
                                                                
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                    completion(YES);
                                                                });
                                                                
                                                                undiscoveredGroup = NO;
                                                                *stop = YES;
                                                            }
                                                        }else{
                                                            if( undiscoveredGroup == YES ){
                                                                [self.library addAssetsGroupAlbumWithName:albumName resultBlock:^(ALAssetsGroup *group) {
                                                                    // このassetGroup にassetを追加
                                                                    [group addAsset:asset];
                                                                    
                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        completion(YES);
                                                                    });
                                                                    
                                                                } failureBlock:^(NSError *error) {
                                                                    // 致命的なエラーなのでキャンセルを呼び出しておく
                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        completion(NO);
                                                                    });
                                                                }];
                                                            }
                                                            
                                                        }
                                                    }
                                                  failureBlock:^(NSError *error) {
                                                      //                                      NSLog(@"保存失敗");
                                                      //                                      NSLog(@"Error %@, %@", error, [error userInfo]);
                                                      
                                                      // 致命的なエラーなのでキャンセルを呼び出しておく
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          completion(NO);
                                                      });
                                                  }
                         ];
                    } failureBlock:^(NSError *error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            completion(NO);
                        });
                    }];
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(YES);
                    });
                }
            }
        }];
    });
    
    
}



@end
