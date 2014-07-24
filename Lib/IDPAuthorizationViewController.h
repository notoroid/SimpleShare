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

