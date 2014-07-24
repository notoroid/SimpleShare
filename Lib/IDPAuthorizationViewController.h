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
    ,IDPAuthorizationViewControllerAuthorizationNoAvailable // Twitter
    ,IDPAuthorizationViewControllerAuthorizationStatusFailure // fail Facebook
    ,IDPAuthorizationViewControllerAuthorizationNottingApplicationID // fail facebook
    ,IDPAuthorizationViewControllerAuthorizationContinuePushNotificationRegistration // PushuNotification continue Registration
};

#define kIDPAuthorizationViewControllerOptionFacebookAppID @"FacebookAppID"
    // initWithAuthorizationType: option: method option

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

