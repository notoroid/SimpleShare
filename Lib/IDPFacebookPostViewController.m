//
//  IDPFacebookPostViewController.m
//  SimpleShare
//
//  Created by 能登 要 on 2014/06/30.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import "IDPFacebookPostViewController.h"
#import "IDPSimpleShareFigureRenderer.h"
#import "IDPSimpleShareViewController.h"
#import "IDPSimpleShareManagaer.h"
@import Social;
@import Accounts;

#define POST_FACEBOOK_FILE_NAME @"facebooktemporary.jpg"


@interface IDPFacebookPostViewController ()
{
    __weak IBOutlet UIButton *_closeButton;
    __weak IBOutlet UIButton *_shareButton;
    __weak IBOutlet UIImageView *_thumbnailView;
    __weak IBOutlet UITextView *_messageView;
    
    __weak IBOutlet UIActivityIndicatorView *_indicatorShareButton;
    __weak IBOutlet UIActivityIndicatorView *_indicaorThumbnail;
    
    BOOL _originInitialized;
    CGRect _originalMessageBaseFrame;
    __weak IBOutlet UIView *_messageBaseView;
    
    dispatch_group_t _groupPost;
    
    __weak IBOutlet UILabel *_titleLabel;
    
}
@end

@implementation IDPFacebookPostViewController

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
    
    _titleLabel.text = IDP_SIMPLESHARE_LOCALIZED_SHARE_ON_FACEBOOK_TITLE;
    [_shareButton setTitle:IDP_SIMPLESHARE_LOCALIZED_EXECUTE_SHARE_TITLE forState:UIControlStateNormal];
    
    _backgroundView.alpha = .7f;
    _backgroundView.opaque = NO;
    [self.view addSubview:_backgroundView];
    [self.view sendSubviewToBack:_backgroundView];
    _backgroundView = nil;
    
    _groupPost = dispatch_group_create();
        // 同期用オブジェクトを生成

    // ShareButton用にグループをに入る
    dispatch_group_enter(_groupPost);

    // ここに送信用処理を呼び出す
//    __weak IDPFacebookPostViewController *weakSelf = self;
    __weak UIActivityIndicatorView *weakShareIndicator = _indicatorShareButton;
//    __weak UIButton *weakShareButton = _shareButton;
    __weak UITextView *weakMessageView = _messageView;
    
    dispatch_group_notify(_groupPost,dispatch_get_main_queue(), ^{
       [weakShareIndicator stopAnimating];
        
        NSString *message = weakMessageView.text;
            // メッセージを取得
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            ACAccountStore *accountStore = [[ACAccountStore alloc] init];
            ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
            NSDictionary *options = @{ ACFacebookAppIdKey:_facebookApplicationID
                                       ,ACFacebookPermissionsKey:@[@"publish_actions"]
                                       ,ACFacebookAudienceKey:ACFacebookAudienceFriends
                                       };
            [accountStore requestAccessToAccountsWithType:accountType options:options
                                               completion:^(BOOL granted, NSError *error) {
                                                   NSArray *accountArray = [accountStore accountsWithAccountType:accountType];
                                                   for (ACAccount *account in accountArray) {
                                                       NSString *URLString = @"https://graph.facebook.com/me/photos";
                                                       NSURL* URL = [NSURL URLWithString:URLString];
                                                    
                                                       NSURL* URLSource = [[IDPSimpleShareManagaer sharedManager].documentsDirectory URLByAppendingPathComponent:POST_FACEBOOK_FILE_NAME];
                                                       NSData *source = [NSData dataWithContentsOfURL:URLSource];
                                                       
                                                       NSMutableDictionary* parametersPhotos = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                                                                               @"message":message
                                                                                                                                               }];
                                                       
                                                       SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                                                                               requestMethod:SLRequestMethodPOST
                                                                                                         URL:URL
                                                                                                  parameters:parametersPhotos];
                                                       [request setAccount:account];
                                                       [request addMultipartData:source withName:@"source" type:@"multipart/form-data" filename:@"img.jpg"];
                                                       
                                                       [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                                           
                                                           if( [NSThread isMainThread] ){
                                                               [_delegate facebookPostViewControllerDidDone:self error:nil];
                                                           }else{
                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                   [_delegate facebookPostViewControllerDidDone:self error:nil];
                                                               });
                                                           }
                                                       }];
                                                   }
                                               }];
        }

        
    });
    
    @autoreleasepool {
        UIImage *closeButtonImage = [IDPSimpleShareFigureRenderer createImageWithFigureType:IDPSimpleShareFigureRendererTypeFacebookPostCloseButton options:nil];
        [_closeButton setImage:closeButtonImage forState:UIControlStateNormal];
        
        UIImage *closeButtonHighlightedImage = [IDPSimpleShareFigureRenderer createImageWithFigureType:IDPSimpleShareFigureRendererTypeFacebookPostCloseButtonHighlighted options:nil];
        [_closeButton setImage:closeButtonHighlightedImage forState:UIControlStateHighlighted];
        
        UIImage *shareButtonArrow = [IDPSimpleShareFigureRenderer createImageWithFigureType:IDPSimpleShareFigureRendererTypeShareArrowButton options:nil];
        [_shareButton setImage:shareButtonArrow forState:UIControlStateNormal];
        
        UIImage *shareButtonArrowHighlighted = [IDPSimpleShareFigureRenderer createImageWithFigureType:IDPSimpleShareFigureRendererTypeShareArrowButtonHighlighted options:nil];
        [_shareButton setImage:shareButtonArrowHighlighted forState:UIControlStateHighlighted];
        
        UIImage *imageThumbailEmpty = [IDPSimpleShareFigureRenderer createImageWithFigureType:IDPSimpleShareFigureRendererTypeThumbnailEmpty options:nil];
        _thumbnailView.image = imageThumbailEmpty;
    }
    
    NSString *message = [_delegate postMessageInSimpleShareViewController:self];
    _messageView.text = message;
    
    NSURL* URL = [[IDPSimpleShareManagaer sharedManager].documentsDirectory URLByAppendingPathComponent:POST_FACEBOOK_FILE_NAME];
    if( [[NSFileManager defaultManager] fileExistsAtPath:URL.path] ){
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtURL:URL error:&error];
        // ファイルを削除
    }
    
    _shareButton.enabled = YES;
    
    // 送信画像を設定
    dispatch_group_enter(_groupPost);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
        @autoreleasepool {
            UIImage *image = [_delegate postImageInSimpleShareViewController:self];
            NSData *data = UIImageJPEGRepresentation(image, .8f);
            [data writeToURL:URL atomically:YES];
        }

        UIImage *thumbnailImage = nil;
        @autoreleasepool {
            NSData *dataOriginalImage = [NSData dataWithContentsOfURL:URL];
            UIImage *originalImage = [UIImage imageWithData:dataOriginalImage];
                // イメージを読み込み(保存前のデータより格段にサイズが小さくなる)
            
            CGFloat scale = [UIScreen mainScreen].scale;
#define FACEBOOK_POST_THUMBNAIL_IMAGE
            CGSize thumbnailSize = CGSizeMake(72.0f * scale, 72.0f * scale);
            
            const CGFloat width = ceil(thumbnailSize.width * scale);
            const CGFloat height = ceil(thumbnailSize.height * scale);
            
            CGColorSpaceRef imageColorSpace = CGColorSpaceCreateDeviceRGB();
            CGContextRef context = CGBitmapContextCreate(NULL, width, height,8, width * 4, imageColorSpace, kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Big);
            
            CGContextSaveGState(context);
            
            CGContextTranslateCTM(context, .0f ,height);
            CGContextScaleCTM(context, scale, -scale);
            
            UIGraphicsPushContext(context);
            {
                [originalImage drawInRect:CGRectMake(.0f, .0f, thumbnailSize.width, thumbnailSize.height)];
            }
            UIGraphicsPopContext();
            
            CGImageRef cgImage = CGBitmapContextCreateImage(context);
            thumbnailImage = [[UIImage alloc] initWithCGImage:cgImage scale:scale orientation:UIImageOrientationUp ];
            CGImageRelease(cgImage);
            
            CGContextRestoreGState(context);
            
            CGContextRelease(context);
            CGColorSpaceRelease(imageColorSpace);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _thumbnailView.alpha = .0f; // 一時非表示とする
            _thumbnailView.image = thumbnailImage; // 画像を置き換え
            
            [_indicaorThumbnail stopAnimating];
                // indicator を終了
 
            [UIView animateKeyframesWithDuration:.25f delay:.0f options:0 animations:^{
                _thumbnailView.alpha = 1.0;
            } completion:^(BOOL finished) {
                
            }];
        });
        
        dispatch_group_leave(_groupPost);
            // 描画終了
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firedShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firedHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}

 -(void) viewDidLayoutSubviews
{
    [super  viewDidLayoutSubviews];
    if( _originInitialized != YES ){
        _originInitialized = YES;
        _originalMessageBaseFrame = _messageBaseView.frame;
        
//        _textFieldContentsOrigin = 
    }
}

- (BOOL) prefersStatusBarHidden
{
    return NO;
}

- (IBAction)firedClose:(id)sender
{
    if( [_messageView isFirstResponder] ){
        [_messageView resignFirstResponder];
    }else{
        [_delegate facebookPostViewControllerDidCancel:self];
    }
}

- (IBAction)firedShared:(id)sender
{
    if( [_messageView isFirstResponder] ){
        [_messageView resignFirstResponder];
    }
    
    [_indicatorShareButton startAnimating];
    _shareButton.enabled = NO;
    _messageView.editable = NO;
    _messageView.alpha = .5f;
    _closeButton.enabled = NO;
    
    dispatch_group_leave(_groupPost);
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

#pragma mark - keyborad notifications
- (void) firedShowKeyboard:(NSNotification *) notification
{
    CGRect keyBoardAreaBegin = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect keyBoardArea = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat delta = .0f;
    if( keyBoardAreaBegin.origin.y != [UIScreen mainScreen].bounds.size.height ){
        delta = (keyBoardAreaBegin.origin.y - keyBoardArea.origin.y);
        // キーボードが出ている状態からさらに追加
        //        NSLog(@"delta=%@",@(delta));
    }else{
        CGRect textfieldRect = _originalMessageBaseFrame;
        CGRect baseArea = /*[_textFieldContents convertRect:*/ textfieldRect /*toView:self.view]*/;
        CGRect intersection = CGRectIntersection(keyBoardArea, baseArea);
        delta = intersection.size.height;
    }
    
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if( delta != .0f ){
        [UIView animateWithDuration:duration animations:^{
            
            if( (_messageBaseView.frame.origin.y - delta) >= .0f ){
                
                if( _originalMessageBaseFrame.size.height <= _messageBaseView.frame.size.height ){
                    _messageBaseView.frame = CGRectOffset(_messageBaseView.frame, .0f, -delta);
                }else{
                    _messageBaseView.frame = (CGRect){_messageBaseView.frame.origin,CGSizeMake(_messageBaseView.frame.size.width,_originalMessageBaseFrame.size.height) };
                }
            }else{
                _messageBaseView.frame = (CGRect){_messageBaseView.frame.origin,CGSizeMake(_messageBaseView.frame.size.width, _messageBaseView.frame.size.height - delta)};
            }
            
        } completion:^(BOOL finished) {
        }];
    }
}

- (void) firedHideKeyboard:(NSNotification *) notification
{
    [UIView animateWithDuration:.25f animations:^{
        _messageBaseView.frame = _originalMessageBaseFrame;
    } completion:^(BOOL finished) {
        
    }];
}


@end
