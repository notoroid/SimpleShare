//
//  IDPSimpleShareViewController.m
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/23.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import "IDPSimpleShareViewController.h"
#import "IDPShareBackgroundView.h"
#import "TransitionManager.h"
#import "IDPSimpleShareManagaer.h"
#import "IDPSimpleShareFigureRenderer.h"
#import "IDPActionViewController.h"
#import "IDPFacebookPostViewController.h"
#import "IDPSimpleShareSlideAndFadeTransition.h"
#import "Line.h"

@import Social;

@interface IDPSimpleShareViewController () <UIDocumentInteractionControllerDelegate,IDPFacebookPostViewControllerDelegate,UIViewControllerTransitioningDelegate>
{

}
@end

@implementation IDPSimpleShareViewController

+ (instancetype) simpleShareViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"IDPSimpleShare" bundle:nil];
    id viewController = [storyboard instantiateViewControllerWithIdentifier:@"simpleShareViewController"];
    return viewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage *imageCloseButton = [IDPSimpleShareFigureRenderer createImageWithFigureType:IDPSimpleShareFigureRendererTypeCloseButton options:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:imageCloseButton landscapeImagePhone:nil style:UIBarButtonItemStyleBordered target:self action:@selector(firedCancel:)];
    
    self.navigationController.delegate = [TransitionManager sharedManager];
    
}

- (NSArray *) initializedButtonWithIconTypes
{
    NSMutableArray *iconTypes = [NSMutableArray arrayWithArray:@[
                             @(IDPShareBackgroundViewIconTypeInstagram)
                            ,@(IDPShareBackgroundViewIconTypeResolution)
                            ,@(IDPShareBackgroundViewIconTypeEmpty)
                            ,@(IDPShareBackgroundViewIconTypeTwitter)
                            ,@(IDPShareBackgroundViewIconTypeFacebook)
                            ,@(IDPShareBackgroundViewIconTypeLINE)
                            ,@(IDPShareBackgroundViewIconTypeOther)
                            ,@(IDPShareBackgroundViewIconTypeEmpty)
                            ,@(IDPShareBackgroundViewIconTypeCameraRoll)
                           ]];

    // LINE check
    if( [Line isLineInstalled] != YES ){
        __block NSUInteger lineIndex = NSUIntegerMax;
        [iconTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if( [obj integerValue] == IDPShareBackgroundViewIconTypeLINE ){
                lineIndex = idx;
                *stop = YES;
            }
        }];
        if( lineIndex != NSUIntegerMax ){
            iconTypes[lineIndex] = @(IDPShareBackgroundViewIconTypeEmpty);
        }
    }

    // Instagram Check
    NSURL *checkURL = [NSURL URLWithString:@"instagram://app"];
    if([[UIApplication sharedApplication] canOpenURL:checkURL] != YES ){

        __block NSUInteger instagramIndex = NSUIntegerMax;
        [iconTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if( [obj integerValue] == IDPShareBackgroundViewIconTypeInstagram ){
                instagramIndex = idx;
                *stop = YES;
            }
        }];
        if( instagramIndex != NSUIntegerMax ){
            iconTypes[instagramIndex] = @(IDPShareBackgroundViewIconTypeEmpty);
        }
        
        
        __block NSUInteger resolutionIndex = NSUIntegerMax;
        [iconTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if( [obj integerValue] == IDPShareBackgroundViewIconTypeResolution ){
                resolutionIndex = idx;
                *stop = YES;
            }
        }];
        if( resolutionIndex != NSUIntegerMax ){
            iconTypes[resolutionIndex] = @(IDPShareBackgroundViewIconTypeEmpty);
        }
    }
    
    
    return iconTypes;
}

- (void)firedCancel:(id)sender
{
    [_delegate simpleShareViewControllerDidCancel:self];
}

- (IBAction)firedCameraRoll:(id)sender
{
    if( [self isEnterWorking] != YES ){
        [self setEnterWorking:YES];
        
        [self setWaiting];
        [self exportImageWithExportType:IDPSimpleShareViewControllerExportTypeCameraRollOnly requireImageType:SimpleShareRequireImageTypeOriginal simpleShareViewController:self delegate:_delegate];
    }
}

- (IBAction)firedInstagram:(id)sender
{
    if( [self isEnterWorking] != YES ){
        [self setEnterWorking:YES];
        
        [self setWaiting];
        [self exportImageWithExportType:IDPSimpleShareViewControllerExportTypeInstagram requireImageType:SimpleShareRequireImageType1280x1280 simpleShareViewController:self delegate:_delegate];
    }
}

- (IBAction)firedTwitter:(id)sender
{
    if( [self isEnterWorking] != YES ){
        [self setEnterWorking:YES];
        
        self.navigationItem.leftBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem.enabled = NO;
        [self setWaiting];
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero,self.view.frame.size}];
        backgroundView.opaque = NO;
        backgroundView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.5f];
        [self.view addSubview:backgroundView];
        
        // 送信画像を設定
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
            @autoreleasepool {
                UIImage *image = [_delegate simpleShareViewController:self imageType:SimpleShareRequireImageTypeOriginal];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setEnterWorking:NO];
                    self.navigationItem.leftBarButtonItem.enabled = YES;
                    self.navigationItem.rightBarButtonItem.enabled = YES;
                    [self resetWaiting];
                    
                    // ビューコントローラの初期化
                    SLComposeViewController *viewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                    
                    NSArray *hashTags = [_delegate simpleShareViewControllerHashTags:self];
                    NSString *hashTagsString = [hashTags componentsJoinedByString:@" "];
                    
                    // 送信文字列を設定
                    [viewController setInitialText:hashTagsString];
                    [viewController addImage:image];
                        // イメージを追加
                    
                    // イベントハンドラ定義
                    viewController.completionHandler = ^(SLComposeViewControllerResult res) {
                        if (res == SLComposeViewControllerResultCancelled) {
                            // キャンセル
                        }else if (res == SLComposeViewControllerResultDone) {
                            NSString *albumName = [_delegate simpleShareViewControllerAlbumName:self];
                            // アルバム名を取得
                            
                            // カメラロールに保存
                            [[IDPSimpleShareManagaer sharedManager] saveImage:image withAlbumName:albumName metadata:nil completion:^(BOOL finished) {
                                if( finished ){
                                    [_delegate simpleShareViewControllerDidDone:self];
                                }else{
                                    // 致命的な不具合
                                    [_delegate simpleShareViewControllerDidDone:self];
                                }
                            }];
                        }
                        
                        [self dismissViewControllerAnimated:YES completion:^{
                            
                        }];
                    };
                    
                    // 送信View表示
                    [self presentViewController:viewController animated:YES completion:^{
                        [backgroundView removeFromSuperview];
                        // 背景を削除
                    }];
                    
                });
            }
        });
    }
}

- (IBAction)firedFacebook:(id)sender
{
    [IDPAuthorizationViewController authorizationWithAuthorizationType:IDPAuthorizationViewControllerAuthorizationTypeFacebook viewController:self completion:^(NSError *error, IDPAuthorizationViewControllerAuthorizationStatus authorizationStatus) {
    
        if( authorizationStatus == IDPAuthorizationViewControllerAuthorizationStatusAuthorized ){
            [self performSegueWithIdentifier:@"facebookPostSegue" sender:nil];
    
        }else{
            [IDPAuthorizationViewController showDenyAlertWithAuthorizationType:IDPAuthorizationViewControllerAuthorizationTypeFacebook];
        }
    }];
}

- (IBAction)firedLINE:(id)sender
{
    if( [self isEnterWorking] != YES ){
        [self setEnterWorking:YES];
    
        [self setWaiting];
        [self exportImageWithExportType:IDPSimpleShareViewControllerExportTypeLine requireImageType:SimpleShareRequireImageType1280x1280 simpleShareViewController:self delegate:_delegate];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"shareActionSegue"]){
        [segue.destinationViewController setDelegate:_delegate];
        [segue.destinationViewController setSimpleShareViewController:self];
        
    }else if([segue.identifier isEqualToString:@"resolutionSegue"]){
        [segue.destinationViewController setDelegate:_delegate];
        [segue.destinationViewController setSimpleShareViewController:self];
    }else if( [segue.identifier isEqual:@"facebookPostSegue"] ){
        UIView *backgroundView = [self.view snapshotViewAfterScreenUpdates:YES];
        [segue.destinationViewController setBackgroundView:backgroundView];
        [segue.destinationViewController setDelegate:self];
        
        NSString *facebookApplicationID = [_delegate simpleShareViewControllerFacebookAppID:self];
        [segue.destinationViewController setFacebookApplicationID:facebookApplicationID];
        [segue.destinationViewController setTransitioningDelegate:self];
    }

}

- (IBAction) returnFromActionSegue:(UIStoryboardSegue *)segue
{
    
}

- (IBAction) returnFromResolutionSegue:(UIStoryboardSegue *)segue
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) facebookPostViewControllerDidCancel:(IDPFacebookPostViewController *)facebookPostView
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) facebookPostViewControllerDidDone:(IDPFacebookPostViewController *)facebookPostView error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:^{
        [_delegate simpleShareViewControllerDidDone:self];
    }];
}

- (UIImage *)postImageInSimpleShareViewController:(IDPFacebookPostViewController *)simpleShareViewController
{
    UIImage *image = [_delegate simpleShareViewController:self imageType:SimpleShareRequireImageTypeOriginal];
    return image;
}

- (NSString *)postMessageInSimpleShareViewController:(IDPFacebookPostViewController *)simpleShareViewController
{
    NSDictionary *metadata = [_delegate simpleShareViewControllerMessageMetadata:self];
        // metadataを取得
    NSString *message = [metadata[kIDPSimpleShareViewControllerMetadataMessage] description];
    
    NSMutableArray  *messageComponent = [NSMutableArray array];
    if( message.length > 0 ){
        [messageComponent addObject:message];
    }
    NSArray *hashTags = [_delegate simpleShareViewControllerHashTags:self];
    if( hashTags.count > 0 ){
        [messageComponent addObjectsFromArray:hashTags];
    }
    
    NSString *hashTagsAndMessage = [messageComponent componentsJoinedByString:@" "];
    
    return hashTagsAndMessage;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    id<UIViewControllerAnimatedTransitioning> transitioning = nil;
    if( [presented isKindOfClass:[IDPFacebookPostViewController class]] ){
        IDPSimpleShareSlideAndFadeTransition* slideAndFadeTransition = [[IDPSimpleShareSlideAndFadeTransition alloc] init];
        slideAndFadeTransition.transitionType = IDPSimpleShareSlideAndFadeTransitionTypePush;
        
        transitioning = slideAndFadeTransition;
    }
    
    return transitioning;
}



@end
