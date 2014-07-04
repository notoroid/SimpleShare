//
//  IDPAbstRichModalViewController.h
//  IDPAbstRichModalViewController
//
//  Created by 能登 要 on 2014/04/20.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IDPAuthorizationLabelTag 100
#define IDPAuthorizationTextViewTag 101
#define IDPAuthorizationLaterAuthorizeButtonTag 102
#define IDPAuthorizationAuthorizedButtonTag 103

@interface IDPAbstRichModalViewController : UIViewController

@property (strong,nonatomic) UIView *backgroundView;
@property (assign,nonatomic) CGPoint boardOffset;
@property (weak,nonatomic) IBOutlet UIView *boardView;
@property (weak,nonatomic)  IBOutlet UIButton *laterButton;
@property (weak,nonatomic)  IBOutlet UIButton *authorizedButton;

- (void) constructContentWithBoardView:(UIView *)boardView;
- (void) authorized;
- (void) laterAuthorize;
@end
