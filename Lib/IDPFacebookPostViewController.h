//
//  IDPFacebookPostViewController.h
//  SimpleShare
//
//  Created by 能登 要 on 2014/06/30.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IDPSimpleShareViewControllerDelegate;
@class IDPSimpleShareViewController;

@protocol IDPFacebookPostViewControllerDelegate;

@interface IDPFacebookPostViewController : UIViewController
@property(strong,nonatomic,) UIView *backgroundView;
@property(strong,nonatomic) NSString *facebookApplicationID;
@property (weak,nonatomic) id<IDPFacebookPostViewControllerDelegate> delegate;
@property (weak,nonatomic) IDPSimpleShareViewController *simpleShareViewController;
@end

@protocol IDPFacebookPostViewControllerDelegate <NSObject>

- (void) facebookPostViewControllerDidCancel:(IDPFacebookPostViewController *)facebookPostView;
- (void) facebookPostViewControllerDidDone:(IDPFacebookPostViewController *)facebookPostView error:(NSError *)error;

- (UIImage *)postImageInSimpleShareViewController:(IDPFacebookPostViewController *)simpleShareViewController;
- (NSString *)postMessageInSimpleShareViewController:(IDPFacebookPostViewController *)simpleShareViewController;

@end