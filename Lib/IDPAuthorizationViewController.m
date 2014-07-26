//
//  IntroductionViewController.m
//  IntroductionAndAccept
//
//  Created by 能登 要 on 2014/04/20.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import "IDPAuthorizationViewController.h"
@import AssetsLibrary;
@import Social;
#import "UIImage+ImageEffects.h"
@import Accounts;

static BOOL s_visibleAuthorization = NO;
static UIView *s_authorizationView = nil;
static UIViewController *s_authorizationViewController = nil;
static BOOL s_acceptTwitterPost = NO;
static BOOL s_acceptFacebookPost = NO;
static BOOL s_acceptPushNotification = NO;
static NSDate *s_pushNotificationTimeBeforeReminding = nil;

@interface IDPAuthorizationViewController ()
{
    IDPAuthorizationViewControllerAuthorizationType _authorizationType;
    NSDictionary *_option;
}
@end

@implementation IDPAuthorizationViewController

+ (UIImageView *)backgroundViewWithViewController:(id)viewController
{
    UIImageView *backgroundView = nil;
    @autoreleasepool {
        CGRect drawRect = (CGRect){CGPointZero,[viewController view].frame.size};
        UIGraphicsBeginImageContextWithOptions(drawRect.size, NO, [UIScreen mainScreen].scale);
        
        [[viewController view] drawViewHierarchyInRect:drawRect afterScreenUpdates:YES];
        
        
        UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
        image = [image applyExtraLightEffect];
        /*UIImageView **/backgroundView = [[UIImageView alloc] initWithImage:image];
        backgroundView.contentMode = UIViewContentModeScaleAspectFit;
        
        UIGraphicsEndImageContext();
    }
    return backgroundView;
}

+ (void) authorizationWithAuthorizationType:(IDPAuthorizationViewControllerAuthorizationType)authorizationType  option:(NSDictionary *)option viewController:(id)viewController completion:(IDPAuthorizationViewControllerCompletionBlock)completion
{
    __weak UINavigationController *navigationController = [viewController navigationController];
    BOOL navigationBarHidden = navigationController != nil ? navigationController.navigationBarHidden : YES;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [IDPAuthorizationViewController updateRepositoryWithUpdate:YES];
            // レポジトリを読み込み
    });
    
    switch (authorizationType) {
#pragma mark - PushNotification 
        case IDPAuthorizationViewControllerAuthorizationTypePushNotification:
        {
            dispatch_block_t blockNotificationAuthorize = ^{
                UIImageView *backgroundView = [IDPAuthorizationViewController backgroundViewWithViewController:viewController];
                // 背景画像を生成
                
                CGRect frame = (CGRect){CGPointZero,[viewController view].frame.size};
                UIViewAutoresizing autoresizingMask = [viewController view].autoresizingMask;
                
                IDPAuthorizationViewController* asstsLibraryAuthorizationViewController = [[IDPAuthorizationViewController alloc] initWithAuthorizationType:IDPAuthorizationViewControllerAuthorizationTypePushNotification option:option];
                
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:asstsLibraryAuthorizationViewController];
                navigationController.navigationBarHidden = YES;
                
                id newViewController = navigationController;
                id asstsLibraryAuthorizationController = asstsLibraryAuthorizationViewController;
                
                [asstsLibraryAuthorizationController setBackgroundView:backgroundView];
                [asstsLibraryAuthorizationController setCompletion:completion];
                [asstsLibraryAuthorizationController setBoardOffset:navigationBarHidden ? CGPointZero : CGPointMake(.0f, 44.0f)];
                
                s_authorizationViewController = newViewController;
                s_authorizationView = [newViewController view];
                s_authorizationView.frame = frame;
                s_authorizationView.autoresizingMask = autoresizingMask;
                
                [viewController addChildViewController:newViewController];
                [[viewController view] addSubview:s_authorizationView];
            };
            
            if( s_visibleAuthorization != YES && s_acceptPushNotification != YES ){
                if( s_pushNotificationTimeBeforeReminding == nil ){
                    blockNotificationAuthorize();
                }else{
                    NSTimeInterval pastTime = [s_pushNotificationTimeBeforeReminding timeIntervalSinceNow];
                    if( pastTime < 0 ){
                        blockNotificationAuthorize();
                        s_pushNotificationTimeBeforeReminding = nil;
                        [IDPAuthorizationViewController updateRepositoryWithUpdate:NO];
                    }else{
                        completion(nil,IDPAuthorizationViewControllerAuthorizationStatusReminding);
                            // リマインド中
                    }
                }
            }else{
                completion(nil,IDPAuthorizationViewControllerAuthorizationStatusContinuePushNotificationRegistration);
                // ユーザー登録を許可
            }
        }
            break;
#pragma mark - Twitter authorization
        case IDPAuthorizationViewControllerAuthorizationTypeTwitter:
        {
            // メッセージを表示する
            if( s_visibleAuthorization != YES && s_acceptTwitterPost != YES ){
                UIImageView *backgroundView = [IDPAuthorizationViewController backgroundViewWithViewController:viewController];
                    // 背景画像を生成
                
                CGRect frame = (CGRect){CGPointZero,[viewController view].frame.size};
                UIViewAutoresizing autoresizingMask = [viewController view].autoresizingMask;
                
                IDPAuthorizationViewController* asstsLibraryAuthorizationViewController = [[IDPAuthorizationViewController alloc] initWithAuthorizationType:IDPAuthorizationViewControllerAuthorizationTypeTwitter option:option];
                
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:asstsLibraryAuthorizationViewController];
                navigationController.navigationBarHidden = YES;
                
                id newViewController = navigationController;
                id asstsLibraryAuthorizationController = asstsLibraryAuthorizationViewController;
                
                [asstsLibraryAuthorizationController setBackgroundView:backgroundView];
                [asstsLibraryAuthorizationController setCompletion:completion];
                [asstsLibraryAuthorizationController setBoardOffset:navigationBarHidden ? CGPointZero : CGPointMake(.0f, 44.0f)];
                
                s_authorizationViewController = newViewController;
                s_authorizationView = [newViewController view];
                s_authorizationView.frame = frame;
                s_authorizationView.autoresizingMask = autoresizingMask;
                
                [viewController addChildViewController:newViewController];
                [[viewController view] addSubview:s_authorizationView];
            }else{
                BOOL isAvailable = [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
                if( isAvailable ){
                    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
                    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
                    [accountStore requestAccessToAccountsWithType:accountType options:nil
                       completion:^(BOOL granted, NSError *error) {
                           dispatch_async(dispatch_get_main_queue(), ^{
                               s_acceptTwitterPost = YES;
                               [IDPAuthorizationViewController updateRepositoryWithUpdate:NO];
                               
                               if (granted) {
                                   completion(nil,IDPAuthorizationViewControllerAuthorizationStatusAuthorized);
                               }else{
                                   completion(nil,IDPAuthorizationViewControllerAuthorizationStatusDenied);
                               }
                           });
                       }];
                }else{
                    completion(nil,IDPAuthorizationViewControllerAuthorizationStatusNoAvailable);
                }
            }
        }
            break;
#pragma mark - Facebook authorization
        case IDPAuthorizationViewControllerAuthorizationTypeFacebook:
        {
            if( s_visibleAuthorization != YES && s_acceptFacebookPost != YES ){
                UIImageView *backgroundView = [IDPAuthorizationViewController backgroundViewWithViewController:viewController];
                // 背景画像を生成
                
                CGRect frame = (CGRect){CGPointZero,[viewController view].frame.size};
                UIViewAutoresizing autoresizingMask = [viewController view].autoresizingMask;
                
                IDPAuthorizationViewController* asstsLibraryAuthorizationViewController = [[IDPAuthorizationViewController alloc] initWithAuthorizationType:IDPAuthorizationViewControllerAuthorizationTypeFacebook option:option];
                
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:asstsLibraryAuthorizationViewController];
                navigationController.navigationBarHidden = YES;
                
                id newViewController = navigationController;
                id asstsLibraryAuthorizationController = asstsLibraryAuthorizationViewController;
                
                [asstsLibraryAuthorizationController setBackgroundView:backgroundView];
                [asstsLibraryAuthorizationController setCompletion:completion];
                [asstsLibraryAuthorizationController setBoardOffset:navigationBarHidden ? CGPointZero : CGPointMake(.0f, 44.0f)];
                
                s_authorizationViewController = newViewController;
                s_authorizationView = [newViewController view];
                s_authorizationView.frame = frame;
                s_authorizationView.autoresizingMask = autoresizingMask;
                
                [viewController addChildViewController:newViewController];
                [[viewController view] addSubview:s_authorizationView];

                [navigationController setNavigationBarHidden:YES animated:YES];
                    // ナビゲーションを非表示とする
            }else{
                // ここで拒否されていないかのチェックを行う事
                if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
                    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];

                    NSString *facebookAppID = option[kIDPAuthorizationViewControllerOptionFacebookAppID];
                    
                    if (facebookAppID.length > 0) {
                        NSDictionary *options = @{
                                                  ACFacebookAppIdKey:facebookAppID
                                                  ,ACFacebookPermissionsKey:@[@"email", @"basic_info"]
                                                  ,ACFacebookAudienceKey:ACFacebookAudienceFriends
                                                  };
                        
                        [accountStore requestAccessToAccountsWithType:accountType
                                                              options:options
                               completion:^(BOOL granted, NSError *error) {
                                   
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       if( granted ){
                                           completion(error,IDPAuthorizationViewControllerAuthorizationStatusAuthorized);
                                       }else{
                                           completion(error,IDPAuthorizationViewControllerAuthorizationStatusDenied);
                                       }
                                   });
                               }
                         ];
                    }else{
                        completion(nil,IDPAuthorizationViewControllerAuthorizationStatusNottingApplicationID);
                    }
                }else{
                    completion(nil,IDPAuthorizationViewControllerAuthorizationStatusNoAvailable);
                }
            }
            
        }
            break;
#pragma mark - CameraRoll authorization
        case IDPAuthorizationViewControllerAuthorizationTypeAssetsLibrary:
        {
            ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
            //    NSString *labelText = nil;
            if (status == ALAuthorizationStatusNotDetermined){
                //        labelText = @"まだ許可ダイアログ出たことない";
            } else if (status == ALAuthorizationStatusRestricted){
                //        labelText = @"機能制限(ペアレンタルコントロール)で許可されてない";
            } else if (status == ALAuthorizationStatusDenied){
                //        labelText = @"許可ダイアログで\"いいえ\"が押されています\n"
                //        "設定アプリ -&gt; プライバシー &gt; 写真 -&gt; 該当アプリを\"オン\"する必要があります";
            } else if (status == ALAuthorizationStatusAuthorized){
                //        labelText = @"写真へのアクセスが許可されています";
            }
            
            if( s_visibleAuthorization != YES && status == ALAuthorizationStatusNotDetermined){
                s_visibleAuthorization = YES;
                
                UIImageView *backgroundView = [IDPAuthorizationViewController backgroundViewWithViewController:viewController];
                    // 背景画像を生成

                CGRect frame = (CGRect){CGPointZero,[viewController view].frame.size};
                UIViewAutoresizing autoresizingMask = [viewController view].autoresizingMask;
                
                IDPAuthorizationViewController* asstsLibraryAuthorizationViewController = [[IDPAuthorizationViewController alloc] initWithAuthorizationType:IDPAuthorizationViewControllerAuthorizationTypeAssetsLibrary option:option];
                
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:asstsLibraryAuthorizationViewController];
                navigationController.navigationBarHidden = YES;
                
                id newViewController = navigationController;
                id asstsLibraryAuthorizationController = asstsLibraryAuthorizationViewController;
                
                [asstsLibraryAuthorizationController setBackgroundView:backgroundView];
                [asstsLibraryAuthorizationController setCompletion:completion];
                [asstsLibraryAuthorizationController setBoardOffset:navigationBarHidden ? CGPointZero : CGPointMake(.0f, 44.0f)];
                
                s_authorizationViewController = newViewController;
                s_authorizationView = [newViewController view];
                s_authorizationView.frame = frame;
                s_authorizationView.autoresizingMask = autoresizingMask;
                
                [viewController addChildViewController:newViewController];
                [[viewController view] addSubview:[newViewController view]];
                
                [navigationController setNavigationBarHidden:YES animated:YES];
                    // ナビゲーションを非表示とする
            }else if( status == ALAuthorizationStatusAuthorized ){
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil,IDPAuthorizationViewControllerAuthorizationStatusAuthorized);
                });
            }else if( status == ALAuthorizationStatusDenied ){ //  or ALAuthorizationStatusRestricted
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil,IDPAuthorizationViewControllerAuthorizationStatusDenied);
                });
            }else if( status == ALAuthorizationStatusRestricted ){
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(nil,IDPAuthorizationViewControllerAuthorizationStatusRestricted);
                });
            }
        }
            break;
        default:
            break;
    }
    
}

+ (void) showDenyAlertWithAuthorizationType:(IDPAuthorizationViewControllerAuthorizationType)authorizationType
{
    [IDPAuthorizationViewController showDenyAlertWithAuthorizationType:(IDPAuthorizationViewControllerAuthorizationType)authorizationType delegate:nil tag:0];
}

+ (void) showDenyAlertWithAuthorizationType:(IDPAuthorizationViewControllerAuthorizationType)authorizationType delegate:(id<UIAlertViewDelegate>)delegate tag:(NSInteger)tag;
{
    NSString *localizedAppName = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"];
    NSString* applicationName = localizedAppName ? localizedAppName : [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    
    
    switch (authorizationType) {
        case IDPAuthorizationViewControllerAuthorizationTypeTwitter:
        {
            BOOL isAvailable = [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
            if( isAvailable != YES ){
                NSString *message = [NSString stringWithFormat:@"ホーム画面から設定 > Twitter >  をタップし、%@ へのアクセスを有効にしてください。",applicationName];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Twitterのアクセス" message:message delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alertView.tag = tag;
                [alertView show];
            }
        }
            break;
        case IDPAuthorizationViewControllerAuthorizationTypeFacebook:
        {
            BOOL isAvailable = [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook];
            if( isAvailable != YES ){
                NSString *message = [NSString stringWithFormat:@"ホーム画面から設定 > Facebook >  をタップし、%@ へのアクセスを有効にしてください。",applicationName];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Twitterのアクセス" message:message delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alertView.tag = tag;
                [alertView show];
            }
        }
            break;
        case IDPAuthorizationViewControllerAuthorizationTypeAssetsLibrary:
        {
            ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
            //    NSString *labelText = nil;
            if (status == ALAuthorizationStatusRestricted){
                NSString *message = [NSString stringWithFormat:@"ホーム画面から設定 > プライバシー > 写真 をタップし、%@ へのアクセスを有効にしてください。",applicationName];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"写真アルバムへのアクセス" message:message delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alertView.tag = tag;
                [alertView show];
            }else if (status == ALAuthorizationStatusDenied){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"写真アルバムへのアクセス" message:@"写真アルバムへのアクセスが制限されています。" delegate:delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
                alertView.tag = tag;
                [alertView show];
            }
        }
            break;
        default:
            break;
    };
}

+ (void) closeIntroduction
{
    [UIView animateWithDuration:.25f animations:^{
        s_authorizationView.alpha = .0f;
    } completion:^(BOOL finished) {
        [s_authorizationView removeFromSuperview];
        [s_authorizationViewController removeFromParentViewController];
        
        s_authorizationView = nil;
        s_authorizationViewController = nil;
        s_visibleAuthorization = NO;
    }];
}

+ (void) updateRepositoryWithUpdate:(BOOL)update
{
	NSString *repositoryFileName = @"simpleAuthorization.dat";
    NSString *repositoryAcceptTwitterPost = @"AcceptTwitterPost";
    NSString *repositoryAcceptFacebookPost = @"AcceptFacebookPost";
    NSString *repositoryPushNotification = @"PushNotification";
    NSString *repositoryPushNotificationTimeBeforeReminding = @"PushNotificationTimeBeforeReminding";
        // AssetLibrary,Facebook は都度確認を行うので必用無し
        // Twitter,Facebook は初回確認有り
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDirectory = [paths objectAtIndex:0];
	NSString *dataFilepath = /*[*/[documentDirectory stringByAppendingPathComponent:repositoryFileName]/*autorelease]*/;
	//	self.dataFilePath = path;
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if( update == YES ){ // 更新
		if ([fileManager fileExistsAtPath:dataFilepath]) {
			NSMutableData *theData  = [NSMutableData dataWithContentsOfFile:dataFilepath];
			NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:theData];
			
            s_acceptTwitterPost = [decoder decodeBoolForKey:repositoryAcceptTwitterPost];
            s_acceptFacebookPost = [decoder decodeBoolForKey:repositoryAcceptFacebookPost];
            s_acceptPushNotification =  [decoder decodeBoolForKey:repositoryPushNotification];
            s_pushNotificationTimeBeforeReminding = [decoder decodeObjectForKey:repositoryPushNotificationTimeBeforeReminding];
            
			[decoder finishDecoding];
		}
	}else{ // 反映
		NSMutableData *theData = [NSMutableData data];
		NSKeyedArchiver *encoder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:theData];
		
        [encoder encodeBool:s_acceptTwitterPost forKey:repositoryAcceptTwitterPost];
        [encoder encodeBool:s_acceptFacebookPost forKey:repositoryAcceptFacebookPost];
        [encoder encodeBool:s_acceptPushNotification forKey:repositoryPushNotification];
        [encoder encodeObject:s_pushNotificationTimeBeforeReminding forKey:repositoryPushNotificationTimeBeforeReminding];

        [encoder finishEncoding];
		[theData writeToFile:dataFilepath atomically:YES];
	}
}

- (instancetype) initWithAuthorizationType:(IDPAuthorizationViewControllerAuthorizationType)authorizationType option:(NSDictionary *)option
{
    self = [super init];
    if (self) {
        _authorizationType = authorizationType;
        _option = option;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) constructContentWithBoardView:(UIView *)boardView
{
    void (^blockDefaultCancel)() = ^{
        UIButton *laterButton = (UIButton *)[boardView viewWithTag:IDPAuthorizationLaterAuthorizeButtonTag];
        laterButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [laterButton setAttributedTitle:[[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_LATER
                                                                        attributes:@{
                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:14.0f]
                                                                                     ,NSForegroundColorAttributeName:[UIColor colorWithRed: 0 green: 0.424 blue: 0.941 alpha: 1]
                                                                                     }
                                         ] forState:UIControlStateNormal];
        [laterButton setAttributedTitle:[[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_LATER
                                                                        attributes:@{
                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:14.0f]
                                                                                     ,NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                     }
                                         ] forState:UIControlStateHighlighted];
    };

    void (^blockDefaultAccept)() = ^{
        UIButton *authorizedButton = (UIButton *)[boardView viewWithTag:IDPAuthorizationAuthorizedButtonTag];
        authorizedButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [authorizedButton setAttributedTitle:[[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_ACCEPT
                                                                             attributes:@{
                                                                                          NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f]
                                                                                          ,NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                          }
                                              ] forState:UIControlStateNormal];
        [authorizedButton setAttributedTitle:[[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_ACCEPT
                                                                             attributes:@{
                                                                                          NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f]
                                                                                          ,NSForegroundColorAttributeName:[UIColor colorWithRed: 0 green: 0.424 blue: 0.941 alpha: 1]
                                                                                          }
                                              ] forState:UIControlStateHighlighted];
    };

    
    switch (_authorizationType) {
        case IDPAuthorizationViewControllerAuthorizationTypePushNotification:
        {
            UILabel *label = (UILabel *)[boardView viewWithTag:IDPAuthorizationLabelTag];
            label.attributedText = [[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_NOTIFICATION_TITLE attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19.0f],NSForegroundColorAttributeName:[UIColor colorWithRed:.02f green:.02f blue:.02f alpha:1.0f]}];
            
            UITextView *textView = (UITextView *)[boardView viewWithTag:IDPAuthorizationTextViewTag];
            textView.attributedText = [[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_NOTIFICATION_MESSAGE attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
            
            blockDefaultCancel();
            
            UIButton *buttonAccept = (UIButton *)[boardView viewWithTag:IDPAuthorizationAuthorizedButtonTag];
            [buttonAccept setAttributedTitle:[[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_NOTIFICATION_ACCEPT
                                                                             attributes:@{
                                                                                          NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f]
                                                                                          ,NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                          }
                                              ] forState:UIControlStateNormal];
            
            [buttonAccept setAttributedTitle:[[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_NOTIFICATION_ACCEPT
                                                                             attributes:@{
                                                                                           NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f]
                                                                                          ,NSForegroundColorAttributeName:[UIColor colorWithRed: 0 green: 0.424 blue: 0.941 alpha: 1]
                                                                                          }
                                              ] forState:UIControlStateHighlighted];
            
        }
            break;
        case IDPAuthorizationViewControllerAuthorizationTypeAssetsLibrary:
        {
            UILabel *label = (UILabel *)[boardView viewWithTag:IDPAuthorizationLabelTag];
            label.attributedText = [[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_ASSETS_LIBRARY_TITLE attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19.0f],NSForegroundColorAttributeName:[UIColor colorWithRed:.02f green:.02f blue:.02f alpha:1.0f]}];
            
            UITextView *textView = (UITextView *)[boardView viewWithTag:IDPAuthorizationTextViewTag];
            textView.attributedText = [[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_ASSETS_LIBRARY_MESSAGE attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
            
            blockDefaultCancel();
            
            blockDefaultAccept();
            
        }
            break;
        case IDPAuthorizationViewControllerAuthorizationTypeFacebook:
        {
            UILabel *label = (UILabel *)[boardView viewWithTag:IDPAuthorizationLabelTag];
            label.attributedText = [[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_FACEBOOK_POST_TITLE attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0f],NSForegroundColorAttributeName:[UIColor colorWithRed:.02f green:.02f blue:.02f alpha:1.0f]}];
            
            UITextView *textView = (UITextView *)[boardView viewWithTag:IDPAuthorizationTextViewTag];
            textView.attributedText = [[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_FACEBOOK_POST_MESSAGE attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
            
            blockDefaultCancel();
            
            UIButton *buttonAccept = (UIButton *)[boardView viewWithTag:IDPAuthorizationAuthorizedButtonTag];
            [buttonAccept setAttributedTitle:[[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_CONTINUE
                                                                             attributes:@{
                                                                                          NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f]
                                                                                          ,NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                          }
                                              ] forState:UIControlStateNormal];
            [buttonAccept setAttributedTitle:[[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_CONTINUE
                                                                             attributes:@{
                                                                                          NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f]
                                                                                          ,NSForegroundColorAttributeName:[UIColor colorWithRed: 0 green: 0.424 blue: 0.941 alpha: 1]
                                                                                          }
                                              ] forState:UIControlStateHighlighted];
        }
            break;
        case IDPAuthorizationViewControllerAuthorizationTypeTwitter:
        {
            UILabel *label = (UILabel *)[boardView viewWithTag:IDPAuthorizationLabelTag];
            label.attributedText = [[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_TWITTER_POST_TITLE attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19.0f],NSForegroundColorAttributeName:[UIColor colorWithRed:.02f green:.02f blue:.02f alpha:1.0f]}];
            
            UITextView *textView = (UITextView *)[boardView viewWithTag:IDPAuthorizationTextViewTag];
            textView.attributedText = [[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_TWITTER_POST_MESSAGE attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
            
            blockDefaultCancel();
            
            UIButton *buttonAccept = (UIButton *)[boardView viewWithTag:IDPAuthorizationAuthorizedButtonTag];
            [buttonAccept setAttributedTitle:[[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_CONTINUE
                                                                                 attributes:@{
                                                                                              NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f]
                                                                                              ,NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                              }
                                                  ] forState:UIControlStateNormal];
            [buttonAccept setAttributedTitle:[[NSAttributedString alloc] initWithString:IDP_AUTHORIZATION_CONTINUE
                                                                             attributes:@{
                                                                                          NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f]
                                                                                          ,NSForegroundColorAttributeName:[UIColor colorWithRed: 0 green: 0.424 blue: 0.941 alpha: 1]
                                                                                          }
                                              ] forState:UIControlStateHighlighted];
        }
            break;
        default:
            break;
    }
    
}

- (void) laterAuthorize
{
    switch (_authorizationType) {
        case IDPAuthorizationViewControllerAuthorizationTypePushNotification:
        {
            s_pushNotificationTimeBeforeReminding = [NSDate dateWithTimeIntervalSinceNow:60.0f /** 60.0f * 24.0f * 1.0f*/];
            [IDPAuthorizationViewController updateRepositoryWithUpdate:NO];
        }
            break;
        default:
            break;
    }
    
    _completion(nil,IDPAuthorizationViewControllerAuthorizationStatusCancel);
    _completion = nil;
    [IDPAuthorizationViewController closeIntroduction];
}

- (void) authorized
{
    switch (_authorizationType) {
        case IDPAuthorizationViewControllerAuthorizationTypePushNotification:
        {
            s_acceptPushNotification = YES;
            [IDPAuthorizationViewController updateRepositoryWithUpdate:NO];
                // レポジトリを更新
            
            _completion(nil,IDPAuthorizationViewControllerAuthorizationStatusContinuePushNotificationRegistration);
            _completion = nil;
            [IDPAuthorizationViewController closeIntroduction];
        }
            break;
        case IDPAuthorizationViewControllerAuthorizationTypeAssetsLibrary:
        {
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            [library enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                _completion(nil,IDPAuthorizationViewControllerAuthorizationStatusAuthorized);
                _completion = nil;
                [IDPAuthorizationViewController closeIntroduction];
            } failureBlock:^(NSError *error) {
                _completion(nil,IDPAuthorizationViewControllerAuthorizationStatusAuthorized);
                _completion = nil;
                [IDPAuthorizationViewController closeIntroduction];
            }];
        }
            break;
        case IDPAuthorizationViewControllerAuthorizationTypeFacebook:
        {
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                ACAccountStore *accountStore = [[ACAccountStore alloc] init];
                ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
                
                NSString* facebookAppID = _option[kIDPAuthorizationViewControllerOptionFacebookAppID];
                NSMutableDictionary *options = [NSMutableDictionary dictionaryWithDictionary:@{
                                                    ACFacebookPermissionsKey:@[@"email", @"basic_info"]
                                                   ,ACFacebookAudienceKey:ACFacebookAudienceFriends
                                                   }];
                if( facebookAppID.length > 0 ){
                    options[ACFacebookAppIdKey] = facebookAppID;
                }
                
                [accountStore requestAccessToAccountsWithType:accountType
                                                      options:options
                                                   completion:^(BOOL granted, NSError *error) {
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           s_acceptFacebookPost = YES;
                                                           [IDPAuthorizationViewController updateRepositoryWithUpdate:NO];
                                                           
                                                           if( granted ){
                                                               _completion(error,IDPAuthorizationViewControllerAuthorizationStatusAuthorized);
                                                               _completion = nil;
                                                               [IDPAuthorizationViewController closeIntroduction];
                                                           }else{
                                                               _completion(error,IDPAuthorizationViewControllerAuthorizationStatusDenied);
                                                               _completion = nil;
                                                               [IDPAuthorizationViewController closeIntroduction];
                                                           }
                                                       });
                                                   }
                 ];
            }else{
                
            }
        }
            break;
        case IDPAuthorizationViewControllerAuthorizationTypeTwitter:
        {
            ACAccountStore *accountStore = [[ACAccountStore alloc] init];
            ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
            [accountStore requestAccessToAccountsWithType:accountType options:nil
               completion:^(BOOL granted, NSError *error) {
                   dispatch_async(dispatch_get_main_queue(), ^{
                       s_acceptTwitterPost = YES;
                       [IDPAuthorizationViewController updateRepositoryWithUpdate:NO];
                       
                     if (granted) {
                         _completion(nil,IDPAuthorizationViewControllerAuthorizationStatusAuthorized);
                         _completion = nil;
                         [IDPAuthorizationViewController closeIntroduction];
                     }else{
                         _completion(nil,IDPAuthorizationViewControllerAuthorizationStatusDenied);
                         _completion = nil;
                         [IDPAuthorizationViewController closeIntroduction];
                     }
                   });
             }];
            
            
        }
            break;
        default:
            break;
    }
}

@end
