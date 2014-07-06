//
//  IntroductionViewController.m
//  IntroductionAndAccept
//
//  Created by 能登 要 on 2014/04/20.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import "IDPAbstRichModalViewController.h"
#import "IDPAuthorizationFigureRenderer.h"
@import QuartzCore;

static UIImage *s_maskImage = nil;

@interface IDPAbstRichModalViewController ()
{
}
@end

@implementation IDPAbstRichModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) loadView
{
    [super loadView];
    
    if( _boardView == nil ){
        UIView *boardView = [[UIView alloc] initWithFrame:CGRectMake(16 + _boardOffset.x, 32 + _boardOffset.y, 288, 401)];
        boardView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        boardView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(28, 48, 235, 35)];
        label.tag = IDPAuthorizationLabelTag;
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        label.attributedText = [[NSAttributedString alloc] initWithString:@"写真へのアクセスを許可" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:19.0f],NSForegroundColorAttributeName:[UIColor colorWithRed:.02f green:.02f blue:.02f alpha:1.0f]}];
        label.textAlignment = NSTextAlignmentCenter;
        [boardView addSubview:label];

        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(31, 91, 237, 128)];
        textView.tag = IDPAuthorizationTextViewTag;
        textView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        textView.attributedText = [[NSAttributedString alloc] initWithString:@"写真アルバムへアクセスを許可をお願いします。" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f],NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
        textView.textAlignment = NSTextAlignmentLeft;
        [boardView addSubview:textView];
        
        UIButton *laterButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 246, 112, 36)];
        laterButton.tag = IDPAuthorizationLaterAuthorizeButtonTag;
        laterButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [laterButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"また後で"
            attributes:@{
                   NSFontAttributeName:[UIFont systemFontOfSize:14.0f]
                  ,NSForegroundColorAttributeName:[UIColor colorWithRed: 0 green: 0.424 blue: 0.941 alpha: 1]
            }
         ] forState:UIControlStateNormal];
        [laterButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"また後で"
                                                                        attributes:@{
                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:14.0f]
                                                                                     ,NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                     }
                                         ] forState:UIControlStateHighlighted];
        [laterButton addTarget:self action:@selector(firedLater:) forControlEvents:UIControlEventTouchUpInside];
        [boardView addSubview:laterButton];
        _laterButton = laterButton;
        
        UIButton *authorizedButton = [[UIButton alloc] initWithFrame:CGRectMake(151, 246, 112, 36)];
        authorizedButton.tag = IDPAuthorizationAuthorizedButtonTag;
        authorizedButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [authorizedButton setTitle:@"アクセスを許可" forState:UIControlStateNormal];
        
        [authorizedButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"アクセスを許可"
                                                                        attributes:@{
                                                                                     NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f]
                                                                                     ,NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                                     }
                                         ] forState:UIControlStateNormal];
        [authorizedButton setAttributedTitle:[[NSAttributedString alloc] initWithString:@"アクセスを許可"
                                                                        attributes:@{
                                                                                     NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f]
                                                                                     ,NSForegroundColorAttributeName:[UIColor colorWithRed: 0 green: 0.424 blue: 0.941 alpha: 1]
                                                                                     }
                                          ] forState:UIControlStateHighlighted];
        [authorizedButton addTarget:self action:@selector(firedAuthorized:) forControlEvents:UIControlEventTouchUpInside];
        
        [boardView addSubview:authorizedButton];
        _authorizedButton = authorizedButton;

        // 背景画像を設定
        UIImage *frame = [IDPAuthorizationFigureRenderer createImageWithFigureType:IDPAuthorizationFigureRendererTypeButtonFrame];
        UIImage *frameHighlighted = [IDPAuthorizationFigureRenderer createImageWithFigureType:IDPAuthorizationFigureRendererTypeButtonFrameHighlighted];
        
        UIImage *authorizedFrame = [IDPAuthorizationFigureRenderer createImageWithFigureType:IDPAuthorizationFigureRendererTypeAuthorizedButtonFrame];
        UIImage *authorizedFrameHighlighted = [IDPAuthorizationFigureRenderer createImageWithFigureType:IDPAuthorizationFigureRendererTypeAuthorizedButtonFrameHighlighted];
        
        [_laterButton setBackgroundImage:frame forState:UIControlStateNormal];
        [_laterButton setBackgroundImage:frameHighlighted forState:UIControlStateHighlighted];
        
        [_authorizedButton setBackgroundImage:authorizedFrame forState:UIControlStateNormal];
        [_authorizedButton setBackgroundImage:authorizedFrameHighlighted forState:UIControlStateHighlighted];
        
        
        [self.view addSubview:boardView];
        _boardView = boardView;
    }
}

- (void) laterAuthorize
{
    
}

- (void) authorized
{
    
}

- (void)firedLater:(id)sender
{
    [self laterAuthorize];
}

- (void)firedAuthorized:(id)sender
{
    [self authorized];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
 
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIGraphicsBeginImageContextWithOptions(_boardView.frame.size, NO, [UIScreen mainScreen].scale);
        
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0.295 green: 0.886 blue: 0 alpha: 1];
        
        //// Rounded Rectangle Drawing
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: (CGRect){CGPointZero,_boardView.frame.size} cornerRadius: 5];
        [color setFill];
        [roundedRectanglePath fill];
        
        s_maskImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    });
    

    CALayer *layerMask = [[CALayer alloc] init];
    layerMask.bounds = (CGRect){CGPointZero,_boardView.frame.size};
    layerMask.position = CGPointMake(CGRectGetWidth(_boardView.frame) * .5f ,CGRectGetHeight(_boardView.frame) * .5f );
    layerMask.contents = (__bridge id)s_maskImage.CGImage;
    _boardView.layer.mask = layerMask;

    CALayer *layerShadow = [[CALayer alloc] init];
    layerShadow.bounds = (CGRect){CGPointZero,_boardView.frame.size};
    layerShadow.position = CGPointMake(_boardView.frame.origin.x + CGRectGetWidth(_boardView.frame) * .5f,_boardView.frame.origin.y + CGRectGetHeight(_boardView.frame) * .5f );
    layerShadow.shadowOffset = CGSizeMake(.0f, 2.5f);
    layerShadow.shadowColor = [UIColor blackColor].CGColor;
    layerShadow.shadowRadius = 20.0f;
    layerShadow.shadowOpacity = 0.4;
    layerShadow.shadowPath = [UIBezierPath bezierPathWithRoundedRect: (CGRect){CGPointZero,_boardView.frame.size} cornerRadius: 10].CGPath;
    [_boardView.layer.superlayer insertSublayer:layerShadow below:_boardView.layer];
    
    
    [self.view addSubview:_backgroundView];
    [self.view sendSubviewToBack:_backgroundView];
    
    CGPoint center = _backgroundView.center;
    _backgroundView.frame = (CGRect){_backgroundView.frame.origin,CGSizeMake(_backgroundView.frame.size.width * 1.08f,_backgroundView.frame.size.height * 1.08f)};
    _backgroundView.center = center;
    
    UIInterpolatingMotionEffect *interpolationHorizontal = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    interpolationHorizontal.minimumRelativeValue = @(-_backgroundView.frame.size.width * .04f);
    interpolationHorizontal.maximumRelativeValue = @(_backgroundView.frame.size.width * .04f);
    
    UIInterpolatingMotionEffect *interpolationVertical = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    interpolationVertical.minimumRelativeValue = @(-_backgroundView.frame.size.height * .04f);
    interpolationVertical.maximumRelativeValue = @(_backgroundView.frame.size.height * .04f);
    
    [_backgroundView addMotionEffect:interpolationHorizontal];
    [_backgroundView addMotionEffect:interpolationVertical];
    

    [self constructContentWithBoardView:_boardView];;

    
    // アニメーションを開始
    [CATransaction begin];

    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration = .25f;
    animation.fromValue = @.0f;
    animation.toValue = @1.0f;
    animation.delegate = self;
    [_boardView.layer addAnimation:animation forKey:@"opacityAnimation"];
    
    CABasicAnimation* animation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation2.duration = .5f;
    animation2.fromValue = @.0f;
    animation2.toValue = @.5f;
    animation2.delegate = self;
    [layerShadow addAnimation:animation2 forKey:@"opacityAnimation2"];
    
    [CATransaction commit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) constructContentWithBoardView:(UIView *)boardView
{
    
}

@end
