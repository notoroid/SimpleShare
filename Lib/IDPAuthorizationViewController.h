//
//  IntroductionViewController.h
//  IntroductionAndAccept
//
//  Created by 能登 要 on 2014/04/20.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDPAbstRichModalViewController.h"

typedef NS_ENUM(NSInteger, IDPAuthorizationViewControllerAuthorizationType )
{
     IDPAuthorizationViewControllerAuthorizationTypeAssetsLibrary
    ,IDPAuthorizationViewControllerAuthorizationTypeTwitter
    ,IDPAuthorizationViewControllerAuthorizationTypeFacebook
    ,IDPAuthorizationViewControllerAuthorizationTypePushNotification
};

typedef NS_ENUM(NSInteger, IDPAuthorizationViewControllerAuthorizationStatus)
{
     IDPAuthorizationViewControllerAuthorizationStatusAuthorized // authorized(Assets Library,facebook)
    ,IDPAuthorizationViewControllerAuthorizationStatusDenied // denied(Assets Library,facebook)
    ,IDPAuthorizationViewControllerAuthorizationStatusCancel // later authorize(Assets Library,facebook) or later accept(twitter)
    ,IDPAuthorizationViewControllerAuthorizationStatusRestricted // AssetsLibrary
    ,IDPAuthorizationViewControllerAuthorizationNoAvailable // Twitter,Facebook
    ,IDPAuthorizationViewControllerAuthorizationStatusFailure // fail Facebook
    ,IDPAuthorizationViewControllerAuthorizationNottingApplicationID // fail facebook
    ,IDPAuthorizationViewControllerAuthorizationContinuePushNotificationRegistration // PushuNotification continue Registration
};

#define kIDPAuthorizationViewControllerOptionFacebookAppID @"FacebookAppID"
    // initWithAuthorizationType: option: method option

#define IDP_AUTHORIZATION_LOCALIZED_APP_NAME    [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"]
#define IDP_AUTHORIZATION_APP_NAME				IDP_AUTHORIZATION_LOCALIZED_APP_NAME ? IDP_AUTHORIZATION_LOCALIZED_APP_NAME : [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

#define IDP_AUTHORIZATION_LATER NSLocalizedStringFromTable(@"また後で", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_ACCEPT NSLocalizedStringFromTable(@"アクセスを許可", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_NOTIFICATION_TITLE NSLocalizedStringFromTable(@"通知の許可", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_NOTIFICATION_MESSAGE NSLocalizedStringFromTable(@"通知の許可をお願いします。", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_NOTIFICATION_ACCEPT NSLocalizedStringFromTable(@"通知を許可する", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_ASSETS_LIBRARY_TITLE NSLocalizedStringFromTable(@"写真へのアクセスを許可", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_ASSETS_LIBRARY_MESSAGE NSLocalizedStringFromTable(@"写真アルバムへアクセスを許可をお願いします。", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_FACEBOOK_POST_TITLE NSLocalizedStringFromTable(@"Facebookへのアクセスを許可", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_FACEBOOK_POST_MESSAGE NSLocalizedStringFromTable(@"Facebookへの写真投稿の許可をお願いします。", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_TWITTER_POST_TITLE NSLocalizedStringFromTable(@"Twitterへの投稿を許可", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_TWITTER_POST_MESSAGE NSLocalizedStringFromTable(@"Twitterへの投稿許可をお願いします。", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_CONTINUE NSLocalizedStringFromTable(@"了解", @"IDPAuthorizationLocalizable", nil)

#define IDP_AUTHORIZATION_ALERT_OK NSLocalizedStringFromTable(@"OK", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_ALERT_NOTIFICATION_TITLE NSLocalizedStringFromTable(@"プッシュ通知の許可", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_ALERT_NOTIFICATION_MESSAGE_FORMAT NSLocalizedStringFromTable(@"ホーム画面から設定 > 通知センター > %@ をタップし、通知のスタイルをバナーもしくはダイアログに、Appアイコンバッジ、サウンドを有効にしてください。", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_ALERT_NOTIFICATION_MESSAGE [NSString stringWithFormat:IDP_AUTHORIZATION_ALERT_NOTIFICATION_MESSAGE_FORMAT,IDP_AUTHORIZATION_APP_NAME]

#define IDP_AUTHORIZATION_ALERT_TWITTER_TITLE NSLocalizedStringFromTable(@"Twitterのアクセス", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_ALERT_TWITTER_MESSAGE_FORMAT NSLocalizedStringFromTable(@"ホーム画面から設定 > Twitter をタップし、%@ へのアクセスを有効にしてください。", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_ALERT_TWITTER_MESSAGE [NSString stringWithFormat:IDP_AUTHORIZATION_ALERT_TWITTER_MESSAGE_FORMAT,IDP_AUTHORIZATION_APP_NAME]

#define IDP_AUTHORIZATION_ALERT_FACEBOOK_TITLE NSLocalizedStringFromTable(@"Facebookへのアクセス", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_ALERT_FACEBOOK_MESSAGE_FORMAT NSLocalizedStringFromTable(@"ホーム画面から設定 > Facebook をタップし、%@ へのアクセスを有効にしてください。", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_ALERT_FACEBOOK_MESSAGE [NSString stringWithFormat:IDP_AUTHORIZATION_ALERT_FACEBOOK_MESSAGE_FORMAT,IDP_AUTHORIZATION_APP_NAME]

#define IDP_AUTHORIZATION_ALERT_ASSETS_TITLE NSLocalizedStringFromTable(@"写真アルバムへのアクセス", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_ALERT_ASSETS_MESSAGE_FORMAT NSLocalizedStringFromTable(@"ホーム画面から設定 > プライバシー > 写真 をタップし、%@ へのアクセスを有効にしてください。", @"IDPAuthorizationLocalizable", nil)
#define IDP_AUTHORIZATION_ALERT_ASSETS_MESSAGE [NSString stringWithFormat:IDP_AUTHORIZATION_ALERT_ASSETS_MESSAGE_FORMAT,IDP_AUTHORIZATION_APP_NAME]
#define IDP_AUTHORIZATION_ALERT_ASSETS_RESTRICT_MESSAGE NSLocalizedStringFromTable(@"お持ちの機器は写真アルバムへのアクセスが制限されています。", @"IDPAuthorizationLocalizable", nil)

typedef void (^IDPAuthorizationViewControllerCompletionBlock)(NSError *error,IDPAuthorizationViewControllerAuthorizationStatus authorizationStatus);

@interface IDPAuthorizationViewController : IDPAbstRichModalViewController

@property (readonly,nonatomic) IDPAuthorizationViewControllerAuthorizationType authorizationType;
@property (readonly,nonatomic) NSDictionary *option;

- (instancetype) initWithAuthorizationType:(IDPAuthorizationViewControllerAuthorizationType)authorizationType option:(NSDictionary *)option;

+ (void) authorizationWithAuthorizationType:(IDPAuthorizationViewControllerAuthorizationType)authorizationType option:(NSDictionary *)option viewController:(id)viewController completion:(IDPAuthorizationViewControllerCompletionBlock)completion;

+ (void) showDenyAlertWithAuthorizationType:(IDPAuthorizationViewControllerAuthorizationType)authorizationType;
+ (void) showDenyAlertWithAuthorizationType:(IDPAuthorizationViewControllerAuthorizationType)authorizationType delegate:(id<UIAlertViewDelegate>)delegate tag:(NSInteger)tag;

@property(strong,nonatomic) IDPAuthorizationViewControllerCompletionBlock completion;

@end

