//
//  IDPSimpleShareViewController.h
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/23.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDPAbstShareViewController.h"

@protocol IDPSimpleShareViewControllerDelegate;


#define kIDPSimpleShareViewControllerMetadataSubject @"subject"
#define kIDPSimpleShareViewControllerMetadataBody @"body"
#define kIDPSimpleShareViewControllerMetadataMessage @"message"
#define kIDPSimpleShareViewControllerMetadataTweet @"tweet"

#define kIDPSimpleShareViewControllerIgnoreFacebookAppID @"YOUR_FACEBOOK_APP_ID"


#define IDP_SIMPLESHARE_LOCALIZED_SHARE_TITLE              NSLocalizedStringFromTable(@"共有", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_OTHER_TITLE              NSLocalizedStringFromTable(@"その他", @"SimpleShareLocalizable", nil)

#define IDP_SIMPLESHARE_LOCALIZED_INSTAGRAM_TITLE            NSLocalizedStringFromTable(@"Instagram", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_TWITTER_TITLE            NSLocalizedStringFromTable(@"Twitter", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_FACEBOOK_TITLE            NSLocalizedStringFromTable(@"Facebook", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_LINE_TITLE            NSLocalizedStringFromTable(@"LINE", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_MESSAGE_TITLE            NSLocalizedStringFromTable(@"メッセージ", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_MAIL_TITLE               NSLocalizedStringFromTable(@"メール", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_COPY_TITLE               NSLocalizedStringFromTable(@"コピー", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_OPEN_IN_TITLE            NSLocalizedStringFromTable(@"アプリで開く", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_SELECT_RESOLUTION_TITLE  NSLocalizedStringFromTable(@"解像度を指定", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_SMALL_TITLE              NSLocalizedStringFromTable(@"コンパクト", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_NORMAL_TITLE             NSLocalizedStringFromTable(@"高精細度", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_LARGE_TITLE              NSLocalizedStringFromTable(@"大きい", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_POST_AFTER_TITLE         NSLocalizedStringFromTable(@"あとで投稿", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_BACK_TITLE               NSLocalizedStringFromTable(@"戻る", @"SimpleShareLocalizable", nil)

#define IDP_SIMPLESHARE_LOCALIZED_SHARE_ON_FACEBOOK_TITLE  NSLocalizedStringFromTable(@"Facebookで共有", @"SimpleShareLocalizable", nil)
#define IDP_SIMPLESHARE_LOCALIZED_EXECUTE_SHARE_TITLE      NSLocalizedStringFromTable(@"シェア", @"SimpleShareLocalizable", nil)

@interface IDPSimpleShareViewController : IDPAbstShareViewController
+ (instancetype) simpleShareViewController;
@property (weak,nonatomic) id<IDPSimpleShareViewControllerDelegate> delegate;
@end

@protocol IDPSimpleShareViewControllerDelegate <NSObject>

- (UIImage *)simpleShareViewController:(IDPSimpleShareViewController *)simpleShareViewController imageType:(SimpleShareRequireImageType)imageType;
- (NSString *)simpleShareViewControllerAlbumName:(IDPSimpleShareViewController *)simpleShareViewController;
- (NSArray *)simpleShareViewControllerHashTags:(IDPSimpleShareViewController *)simpleShareViewController;
- (BOOL) simpleShareViewControllerAlwaysSaveCameraRoll:(IDPSimpleShareViewController *)simpleShareViewController;

- (NSString *)simpleShareViewControllerFacebookAppID:(IDPSimpleShareViewController *)simpleShareViewController;

- (NSDictionary *)simpleShareViewControllerMessageMetadata:(IDPSimpleShareViewController *)simpleShareViewController;

- (void) simpleShareViewControllerDidDone:(IDPSimpleShareViewController *)simpleShareViewController;

- (void) simpleShareViewControllerDidCancel:(IDPSimpleShareViewController *)simpleShareViewController;



@end
