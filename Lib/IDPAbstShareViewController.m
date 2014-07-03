//
//  IDPAbstShareViewController.m
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/26.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import "IDPAbstShareViewController.h"
#import "IDPSimpleShareManagaer.h"
#import "IDPSimpleShareViewController.h"
#import "IDPShareBackgroundView.h"
@import MessageUI;
@import MobileCoreServices;
#import "Line.h"
#import "IDPAuthorizationViewController.h"

#define DOCUMENT_INTERACTION_IMAGE_FILE_NAME @"temporary.jpg"
#define DOCUMENT_INTERACTION_INSTAGRAM_FILE_NAME @"temporary.igo"

@interface IDPAbstShareViewController () <UIDocumentInteractionControllerDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UIAlertViewDelegate>
{
    UIDocumentInteractionController *_interactionController;
    BOOL _enterWork;
    dispatch_group_t _groupDenyAlert;
}
@end

@implementation IDPAbstShareViewController

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
    
    NSArray *iconTypes = [self initializedButtonWithIconTypes];
    if( iconTypes.count != 0 ){
        NSArray *iconViews = @[self.iconView,self.icon2View,self.icon3View,self.icon4View,self.icon5View,self.icon6View,self.icon7View,self.icon8View,self.icon9View];
        NSArray *labelViews = @[self.label,self.label2,self.label3,self.label4,self.label5,self.label6,self.label7,self.label8,self.label9];
        
        NSDictionary *dictCaption = [[IDPSimpleShareManagaer sharedManager] captionsByIconType];
        
        for( IDPShareBackgroundView *iconView in iconViews){
            NSInteger index = [iconViews indexOfObject:iconView];
            index = index % iconTypes.count;
            
            NSString* caption = dictCaption[iconTypes[index]];
            UILabel *label = labelViews[index];
            label.text = caption;
            
            iconView.iconType = [iconTypes[index] integerValue];
            [iconView setNeedsDisplay];
            
            if( iconView.iconType == IDPShareBackgroundViewIconTypeEmpty ){
                while (iconView.gestureRecognizers.count > 0) {
                    [iconView removeGestureRecognizer:iconView.gestureRecognizers[0]];
                }
            }
        }
    }
}

- (NSArray *) initializedButtonWithIconTypes
{
    return nil;
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

- (BOOL) isEnterWorking
{
    return _enterWork;
}

- (void) setEnterWorking:(BOOL)enterWorking
{
    _enterWork = enterWorking;
}

- (void) firedShowWaiting:(id)sender
{
    [[UINib nibWithNibName:@"IDPWaitingView" bundle:nil] instantiateWithOwner:self options:nil];
    _waitingView.frame = (CGRect){CGPointZero,self.view.frame.size};
    [self.view addSubview:_waitingView];
}

- (void) setWaiting
{
    [self performSelector:@selector(firedShowWaiting:) withObject:nil afterDelay:1.0f];
}

- (void) resetWaiting
{
    if (_waitingView != nil ) {
        // 待ち受け画面を削除
        [_waitingView removeFromSuperview];
        _waitingView = nil;
        self.navigationItem.leftBarButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.navigationItem.hidesBackButton = NO;
        
    }else{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(firedShowWaiting:) object:nil];
    }
}

- (void) updateUserInterfaceWithEnable:(BOOL)enable
{
    if( enable ){
        self.navigationItem.leftBarButtonItem.enabled = YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.navigationItem.hidesBackButton = NO;
    }else{
        self.navigationItem.leftBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem.enabled = NO;
        self.navigationItem.hidesBackButton = YES;
    }
    
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
#define IDP_SIMPLE_SHARE_DENIED_ALERT_TAG 100
    if( alertView.tag == IDP_SIMPLE_SHARE_DENIED_ALERT_TAG ){
        dispatch_group_leave(_groupDenyAlert);
    }
}

- (void) exportImageWithExportType:(IDPSimpleShareViewControllerExportType) exportType requireImageType:(SimpleShareRequireImageType)requireImageType simpleShareViewController:(IDPSimpleShareViewController *)simpleShareViewController delegate:(id<IDPSimpleShareViewControllerDelegate>)delegate
{
    [self updateUserInterfaceWithEnable:NO];
    
    dispatch_block_t block = ^{
        [self setWaiting];
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero,self.view.frame.size}];
        backgroundView.opaque = NO;
        backgroundView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.5f];
        [self.view addSubview:backgroundView];
        
        NSURL* URL = [[IDPSimpleShareManagaer sharedManager].documentsDirectory URLByAppendingPathComponent:exportType == IDPSimpleShareViewControllerExportTypeInstagram ? DOCUMENT_INTERACTION_INSTAGRAM_FILE_NAME : DOCUMENT_INTERACTION_IMAGE_FILE_NAME];
        if( [[NSFileManager defaultManager] fileExistsAtPath:URL.path] ){
            NSError *error = nil;
            [[NSFileManager defaultManager] removeItemAtURL:URL error:&error];
            // ファイルを削除
        }
        
        NSDictionary *metadata = [delegate simpleShareViewControllerMessageMetadata:simpleShareViewController];
        // metadataを取得
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
            @autoreleasepool {
                UIImage *image = [delegate simpleShareViewController:simpleShareViewController imageType:SimpleShareRequireImageTypeOriginal];
                
                NSString *albumName = [delegate simpleShareViewControllerAlbumName:simpleShareViewController];
                // アルバム名を取得
                // 保存
                [[IDPSimpleShareManagaer sharedManager] saveImage:image withAlbumName:albumName metadata:nil completion:^(BOOL finished) {
                    [self updateUserInterfaceWithEnable:YES];
                    [self resetWaiting];
                    
                    switch (exportType) {
                        case IDPSimpleShareViewControllerExportTypeCopyPasteboard:
                        {
                            [backgroundView removeFromSuperview];
                            // 背景を削除
                            
                            [UIPasteboard generalPasteboard].image = image;
                            
                            [delegate simpleShareViewControllerDidDone:simpleShareViewController];
                        }
                            break;
                        case IDPSimpleShareViewControllerExportTypeCameraRollOnly:
                        {
                            [backgroundView removeFromSuperview];
                            // 背景を削除
                            
                            if( finished ){
                                [delegate simpleShareViewControllerDidDone:simpleShareViewController];
                            }else{
                                // 致命的な不具合
                                [delegate simpleShareViewControllerDidDone:simpleShareViewController];
                            }
                        }
                            break;
                        case IDPSimpleShareViewControllerExportTypeMessage:
                        {
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                NSData *data = UIImageJPEGRepresentation(image, .8f);
                                [data writeToURL:URL atomically:YES];
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    MFMessageComposeViewController *viewController = [[MFMessageComposeViewController alloc] init];
                                    viewController.subject = [metadata[@"subject"] description];
                                    viewController.body = [metadata[@"body"] description];
                                    
                                    BOOL attached = [viewController addAttachmentData:data typeIdentifier:(NSString*)kUTTypeJPEG filename:@"image.jpg"];
                                    if (attached) {
                                        //                                    NSLog(@"Attached (:");
                                    }
                                    else {
                                        //                                    NSLog(@"Not attached ):");
                                    }
                                    
                                    [self presentViewController:viewController animated:YES completion:^{
                                        [backgroundView removeFromSuperview];
                                        // 背景を削除
                                    }];
                                    
                                });
                            });
                        }
                            break;
                        case IDPSimpleShareViewControllerExportTypeLine:
                        {
                            [backgroundView removeFromSuperview];
                            // 背景を削除
                            
                            [Line shareImage:image];
                            
                            [delegate simpleShareViewControllerDidDone:simpleShareViewController];
                        }
                            break;
                        case IDPSimpleShareViewControllerExportTypeMail:
                        {
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                NSData *data = UIImageJPEGRepresentation(image, .8f);
                                [data writeToURL:URL atomically:YES];
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    MFMailComposeViewController *viewController = [[MFMailComposeViewController alloc] init];
                                    viewController.subject = [metadata[@"subject"] description];
                                    [viewController setMessageBody:[metadata[@"body"] description] isHTML:NO];
                                    
                                    [viewController addAttachmentData:data mimeType:(NSString*)kUTTypeJPEG fileName:@"image.jpg"];
                                    
                                    [self presentViewController:viewController animated:YES completion:^{
                                        [backgroundView removeFromSuperview];
                                        // 背景を削除
                                    }];
                                    
                                });
                                
                            });
                        }
                            break;
                        case IDPSimpleShareViewControllerExportTypeDocumentInteraction:
                        case IDPSimpleShareViewControllerExportTypeInstagram:
                        {
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                NSData *data = UIImageJPEGRepresentation(image, .8f);
                                [data writeToURL:URL atomically:YES];
                                // ファイルを書き込み
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    if( exportType == IDPSimpleShareViewControllerExportTypeDocumentInteraction ){
                                        UIDocumentInteractionController* interactionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
                                        _interactionController = interactionController;
                                        _enterWork = NO;
                                        // ここで無効
                                        
                                        interactionController.delegate = self;
                                        
                                        NSArray *hashTags = [delegate simpleShareViewControllerHashTags:simpleShareViewController];
                                        NSString *hashTagsString = [hashTags componentsJoinedByString:@" "];
                                        interactionController.annotation = [NSDictionary dictionaryWithObject:hashTagsString forKey:@"InstagramCaption"];
                                        // アノテーションを設定
                                        
                                        BOOL present = [interactionController presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
                                        if (!present) {
                                            //                                        NSLog(@"このファイルを開けるアプリが存在しない。");
                                        }
                                        [backgroundView removeFromSuperview];
                                        // 背景を削除
                                    }else{
                                        UIDocumentInteractionController* interactionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
                                        _interactionController = interactionController;
                                        _enterWork = NO;
                                        // ここで無効
                                        
                                        interactionController.delegate = self;
                                        interactionController.UTI = @"com.instagram.exclusivegram";
                                        interactionController.annotation = [NSDictionary dictionaryWithObject:@"入力済みのキャプション" forKey:@"InstagramCaption"];
                                        
                                        NSArray *hashTags = [delegate simpleShareViewControllerHashTags:simpleShareViewController];
                                        NSString *hashTagsString = [hashTags componentsJoinedByString:@" "];
                                        interactionController.annotation = [NSDictionary dictionaryWithObject:hashTagsString forKey:@"InstagramCaption"];
                                        // アノテーションを設定
                                        
                                        BOOL present = [interactionController presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
                                        if (!present) {
                                            //                                        NSLog(@"このファイルを開けるアプリが存在しない。");
                                        }
                                        [backgroundView removeFromSuperview];
                                        // 背景を削除
                                        
                                    }
                                });
                            });
                        }
                            break;
                        default:
                            break;
                    }
                }];
                
            }
        });
    };

    
    [IDPAuthorizationViewController authorizationWithAuthorizationType:IDPAuthorizationViewControllerAuthorizationTypeAssetsLibrary option:nil viewController:self completion:^(NSError *error, IDPAuthorizationViewControllerAuthorizationStatus authorizationStatus) {
        
        if( authorizationStatus == IDPAuthorizationViewControllerAuthorizationStatusAuthorized ){
            block();
        }else{
            _groupDenyAlert = dispatch_group_create();
            dispatch_group_enter(_groupDenyAlert);
            [IDPAuthorizationViewController showDenyAlertWithAuthorizationType:IDPAuthorizationViewControllerAuthorizationTypeAssetsLibrary delegate:self tag:IDP_SIMPLE_SHARE_DENIED_ALERT_TAG];
            
            dispatch_group_notify(_groupDenyAlert, dispatch_get_main_queue(), block);
        }
    }];

}

#pragma mark -
#pragma mark UIDocumentInteractionController

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

- (void)documentInteractionControllerWillBeginPreview:(UIDocumentInteractionController *)controller
{
    
}

- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller
{
    
}

- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller
{
    
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller willBeginSendingToApplication:(NSString *)application
{

}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application
{
    _interactionController = nil;
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    _enterWork = NO;
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    _enterWork = NO;
}

@end
