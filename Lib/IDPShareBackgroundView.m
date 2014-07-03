//
//  IDPShareBackgroundView.m
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/23.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import "IDPShareBackgroundView.h"

@implementation IDPShareBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"touchesBegan: call");
    self.alpha = .25f;
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.alpha = 1.0f;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.alpha = 1.0f;
}

- (void)drawRect:(CGRect)rect
{
    switch (_iconType) {
        case IDPShareBackgroundViewIconTypeInstagram:
            [IDPShareBackgroundView drawInstagramBackground];
            break;
        case IDPShareBackgroundViewIconTypeTwitter:
            [IDPShareBackgroundView drawTwitterBackground];
            break;
        case IDPShareBackgroundViewIconTypeFacebook:
            [IDPShareBackgroundView drawFacebookBackground];
            break;
        case IDPShareBackgroundViewIconTypeLINE:
            [IDPShareBackgroundView drawLINEBackground];
            break;
        case IDPShareBackgroundViewIconTypeMessage:
            [IDPShareBackgroundView drawMessageBackground];
            break;
        case IDPShareBackgroundViewIconTypeMail:
            [IDPShareBackgroundView drawMailBackground];
            break;
        case IDPShareBackgroundViewIconTypePasteboard:
            [IDPShareBackgroundView drawPastboardBackground];
            break;
        case IDPShareBackgroundViewIconTypeOther:
            [IDPShareBackgroundView drawOtherBackground];
            break;
        case IDPShareBackgroundViewIconTypeDocumentInteraction:
            [IDPShareBackgroundView drawDocumentInteractionBackground];
            break;
        case IDPShareBackgroundViewIconTypeResolution:
            [IDPShareBackgroundView drawResolutionBackground];
            break;
        case IDPShareBackgroundViewIconTypeCameraRoll:
            [IDPShareBackgroundView drawCamerRollBackground];
            break;
        case IDPShareBackgroundViewIconTypeBack:
            [IDPShareBackgroundView drawBackBackground];
            break;
        case IDPShareBackgroundViewIconTypeSmall:
            [IDPShareBackgroundView drawSmallBackground];
            break;
        case IDPShareBackgroundViewIconTypeNormal:
            [IDPShareBackgroundView drawNormalBackground];
            break;
        case IDPShareBackgroundViewIconTypeLarge:
            [IDPShareBackgroundView drawLargeBackground];
            break;
        default:
            break;
    }
}

+ (void)drawTemplateBackground;
{
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 76, 76)];
    [UIColor.grayColor setFill];
    [ovalPath fill];
}

+ (void)drawInstagramBackground;
{
    //// Color Declarations
    UIColor* color2 = [UIColor colorWithRed: 0.647 green: 0.478 blue: 0.424 alpha: 1];
    UIColor* color3 = [UIColor colorWithRed: 0.976 green: 0.976 blue: 0.976 alpha: 1];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 76, 76)];
    [color2 setFill];
    [ovalPath fill];
    
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(17, 18, 41, 41) cornerRadius: 8];
    [color2 setFill];
    [rectanglePath fill];
    [color3 setStroke];
    rectanglePath.lineWidth = 2;
    [rectanglePath stroke];
    
    
    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(21, 37, 33, 18) byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: CGSizeMake(4, 4)];
    [rectangle2Path closePath];
    [color3 setFill];
    [rectangle2Path fill];
    [color3 setStroke];
    rectangle2Path.lineWidth = 2;
    [rectangle2Path stroke];
    
    
    //// Oval 2 Drawing
    UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(26, 27, 23, 23)];
    [color2 setFill];
    [oval2Path fill];
    [color3 setStroke];
    oval2Path.lineWidth = 2;
    [oval2Path stroke];
}

+ (void)drawMailBackground;
{
    //// Color Declarations
    UIColor* color4 = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0.2 alpha: 1];
    CGFloat color4HSBA[4];
    [color4 getHue: &color4HSBA[0] saturation: &color4HSBA[1] brightness: &color4HSBA[2] alpha: &color4HSBA[3]];
    
    UIColor* color5 = [UIColor colorWithHue: color4HSBA[0] saturation: color4HSBA[1] brightness: 0.6 alpha: color4HSBA[3]];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 75, 75)];
    [color5 setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(21.5, 25.5, 33, 25) cornerRadius: 2];
    [color5 setStroke];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
    
    
    //// Polygon Drawing
    UIBezierPath* polygonPath = UIBezierPath.bezierPath;
    [polygonPath moveToPoint: CGPointMake(21.5, 27.06)];
    [polygonPath addLineToPoint: CGPointMake(37.92, 38)];
    [polygonPath addLineToPoint: CGPointMake(54.33, 27.06)];
    polygonPath.lineCapStyle = kCGLineCapRound;
    
    polygonPath.lineJoinStyle = kCGLineJoinBevel;
    
    [color5 setStroke];
    polygonPath.lineWidth = 1;
    [polygonPath stroke];
}

+ (void)drawTwitterBackground;
{
    //// Color Declarations
    UIColor* color3 = [UIColor colorWithRed: 0.976 green: 0.976 blue: 0.976 alpha: 1];
    UIColor* twitterBackgroundColor = [UIColor colorWithRed: 0.333 green: 0.675 blue: 0.933 alpha: 1];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 76, 76)];
    [twitterBackgroundColor setFill];
    [ovalPath fill];
    
    
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
    [bezier2Path moveToPoint: CGPointMake(32.06, 51)];
    [bezier2Path addCurveToPoint: CGPointMake(22, 48.16) controlPoint1: CGPointMake(28.36, 51) controlPoint2: CGPointMake(24.91, 49.96)];
    [bezier2Path addCurveToPoint: CGPointMake(23.57, 48.25) controlPoint1: CGPointMake(22.51, 48.22) controlPoint2: CGPointMake(23.04, 48.25)];
    [bezier2Path addCurveToPoint: CGPointMake(31.72, 45.55) controlPoint1: CGPointMake(26.64, 48.25) controlPoint2: CGPointMake(29.47, 47.24)];
    [bezier2Path addCurveToPoint: CGPointMake(25.59, 41.17) controlPoint1: CGPointMake(28.85, 45.5) controlPoint2: CGPointMake(26.42, 43.68)];
    [bezier2Path addCurveToPoint: CGPointMake(26.82, 41.28) controlPoint1: CGPointMake(25.99, 41.24) controlPoint2: CGPointMake(26.4, 41.28)];
    [bezier2Path addCurveToPoint: CGPointMake(28.55, 41.06) controlPoint1: CGPointMake(27.42, 41.28) controlPoint2: CGPointMake(28, 41.2)];
    [bezier2Path addCurveToPoint: CGPointMake(23.29, 34.87) controlPoint1: CGPointMake(25.55, 40.48) controlPoint2: CGPointMake(23.29, 37.93)];
    [bezier2Path addCurveToPoint: CGPointMake(23.29, 34.79) controlPoint1: CGPointMake(23.29, 34.84) controlPoint2: CGPointMake(23.29, 34.82)];
    [bezier2Path addCurveToPoint: CGPointMake(26.26, 35.58) controlPoint1: CGPointMake(24.17, 35.26) controlPoint2: CGPointMake(25.18, 35.55)];
    [bezier2Path addCurveToPoint: CGPointMake(23.34, 30.33) controlPoint1: CGPointMake(24.5, 34.45) controlPoint2: CGPointMake(23.34, 32.52)];
    [bezier2Path addCurveToPoint: CGPointMake(24.23, 27.16) controlPoint1: CGPointMake(23.34, 29.17) controlPoint2: CGPointMake(23.66, 28.09)];
    [bezier2Path addCurveToPoint: CGPointMake(37.76, 33.75) controlPoint1: CGPointMake(27.47, 30.97) controlPoint2: CGPointMake(32.3, 33.49)];
    [bezier2Path addCurveToPoint: CGPointMake(37.59, 32.31) controlPoint1: CGPointMake(37.65, 33.29) controlPoint2: CGPointMake(37.59, 32.81)];
    [bezier2Path addCurveToPoint: CGPointMake(44.15, 26) controlPoint1: CGPointMake(37.59, 28.83) controlPoint2: CGPointMake(40.53, 26)];
    [bezier2Path addCurveToPoint: CGPointMake(48.95, 27.99) controlPoint1: CGPointMake(46.04, 26) controlPoint2: CGPointMake(47.75, 26.77)];
    [bezier2Path addCurveToPoint: CGPointMake(53.12, 26.46) controlPoint1: CGPointMake(50.44, 27.71) controlPoint2: CGPointMake(51.85, 27.18)];
    [bezier2Path addCurveToPoint: CGPointMake(50.23, 29.95) controlPoint1: CGPointMake(52.63, 27.94) controlPoint2: CGPointMake(51.58, 29.17)];
    [bezier2Path addCurveToPoint: CGPointMake(54, 28.96) controlPoint1: CGPointMake(51.56, 29.8) controlPoint2: CGPointMake(52.82, 29.46)];
    [bezier2Path addCurveToPoint: CGPointMake(50.72, 32.23) controlPoint1: CGPointMake(53.12, 30.23) controlPoint2: CGPointMake(52.01, 31.34)];
    [bezier2Path addCurveToPoint: CGPointMake(50.74, 33.04) controlPoint1: CGPointMake(50.74, 32.5) controlPoint2: CGPointMake(50.74, 32.77)];
    [bezier2Path addCurveToPoint: CGPointMake(32.06, 51) controlPoint1: CGPointMake(50.74, 41.38) controlPoint2: CGPointMake(44.14, 51)];
    [bezier2Path closePath];
    bezier2Path.miterLimit = 4;
    
    bezier2Path.usesEvenOddFillRule = YES;
    
    [color3 setFill];
    [bezier2Path fill];
}

+ (void)drawFacebookBackground;
{
    //// Color Declarations
    UIColor* color3 = [UIColor colorWithRed: 0.976 green: 0.976 blue: 0.976 alpha: 1];
    UIColor* faceBookBackgroundColor = [UIColor colorWithRed: 0.224 green: 0.353 blue: 0.576 alpha: 1];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 76, 76)];
    [faceBookBackgroundColor setFill];
    [ovalPath fill];
    
    
    //// FacebookLogo Drawing
    UIBezierPath* facebookLogoPath = UIBezierPath.bezierPath;
    [facebookLogoPath moveToPoint: CGPointMake(34.98, 24.67)];
    [facebookLogoPath addCurveToPoint: CGPointMake(42.7, 21.62) controlPoint1: CGPointMake(36.31, 22.64) controlPoint2: CGPointMake(38.89, 21.62)];
    [facebookLogoPath addCurveToPoint: CGPointMake(43.81, 21.66) controlPoint1: CGPointMake(43.06, 21.62) controlPoint2: CGPointMake(43.43, 21.63)];
    [facebookLogoPath addCurveToPoint: CGPointMake(45.12, 21.76) controlPoint1: CGPointMake(44.19, 21.68) controlPoint2: CGPointMake(44.63, 21.71)];
    [facebookLogoPath addLineToPoint: CGPointMake(45.12, 27.18)];
    [facebookLogoPath addCurveToPoint: CGPointMake(43.83, 27.1) controlPoint1: CGPointMake(44.52, 27.14) controlPoint2: CGPointMake(44.09, 27.11)];
    [facebookLogoPath addCurveToPoint: CGPointMake(43.08, 27.08) controlPoint1: CGPointMake(43.56, 27.09) controlPoint2: CGPointMake(43.31, 27.08)];
    [facebookLogoPath addCurveToPoint: CGPointMake(39.97, 28.49) controlPoint1: CGPointMake(41.34, 27.08) controlPoint2: CGPointMake(40.31, 27.55)];
    [facebookLogoPath addCurveToPoint: CGPointMake(39.46, 35.65) controlPoint1: CGPointMake(39.63, 29.42) controlPoint2: CGPointMake(39.46, 31.81)];
    [facebookLogoPath addLineToPoint: CGPointMake(45.12, 35.65)];
    [facebookLogoPath addLineToPoint: CGPointMake(45.12, 40.34)];
    [facebookLogoPath addLineToPoint: CGPointMake(39.39, 40.34)];
    [facebookLogoPath addLineToPoint: CGPointMake(39.39, 56)];
    [facebookLogoPath addLineToPoint: CGPointMake(33.74, 56)];
    [facebookLogoPath addLineToPoint: CGPointMake(33.74, 40.34)];
    [facebookLogoPath addLineToPoint: CGPointMake(29, 40.34)];
    [facebookLogoPath addLineToPoint: CGPointMake(29, 35.65)];
    [facebookLogoPath addLineToPoint: CGPointMake(33.74, 35.65)];
    [facebookLogoPath addLineToPoint: CGPointMake(33.74, 30.09)];
    [facebookLogoPath addCurveToPoint: CGPointMake(34.98, 24.67) controlPoint1: CGPointMake(33.82, 27.62) controlPoint2: CGPointMake(34.23, 25.81)];
    [facebookLogoPath closePath];
    [color3 setFill];
    [facebookLogoPath fill];
}

+ (void)drawLINEBackground;
{
    //// Color Declarations
    UIColor* color7 = [UIColor colorWithRed: 0.216 green: 0.741 blue: 0.149 alpha: 1];
    UIColor* color9 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 76, 76)];
    [color7 setFill];
    [ovalPath fill];
    
    
    //// Page-1
    {
        //// [AI]LINE_logotype_RGB
        {
            //// Group-34
            {
                //// Bezier 4 Drawing
                UIBezierPath* bezier4Path = UIBezierPath.bezierPath;
                [bezier4Path moveToPoint: CGPointMake(53, 39.3)];
                [bezier4Path addCurveToPoint: CGPointMake(54.34, 37.98) controlPoint1: CGPointMake(53.74, 39.3) controlPoint2: CGPointMake(54.34, 38.71)];
                [bezier4Path addCurveToPoint: CGPointMake(53, 36.66) controlPoint1: CGPointMake(54.34, 37.26) controlPoint2: CGPointMake(53.74, 36.66)];
                [bezier4Path addLineToPoint: CGPointMake(49.28, 36.66)];
                [bezier4Path addLineToPoint: CGPointMake(49.28, 34.3)];
                [bezier4Path addLineToPoint: CGPointMake(53, 34.3)];
                [bezier4Path addCurveToPoint: CGPointMake(54.34, 32.98) controlPoint1: CGPointMake(53.74, 34.3) controlPoint2: CGPointMake(54.34, 33.71)];
                [bezier4Path addCurveToPoint: CGPointMake(53, 31.67) controlPoint1: CGPointMake(54.34, 32.26) controlPoint2: CGPointMake(53.74, 31.67)];
                [bezier4Path addLineToPoint: CGPointMake(47.94, 31.67)];
                [bezier4Path addCurveToPoint: CGPointMake(46.61, 32.98) controlPoint1: CGPointMake(47.21, 31.67) controlPoint2: CGPointMake(46.61, 32.26)];
                [bezier4Path addLineToPoint: CGPointMake(46.61, 42.98)];
                [bezier4Path addCurveToPoint: CGPointMake(47.94, 44.3) controlPoint1: CGPointMake(46.61, 43.71) controlPoint2: CGPointMake(47.21, 44.3)];
                [bezier4Path addLineToPoint: CGPointMake(53, 44.3)];
                [bezier4Path addCurveToPoint: CGPointMake(54.34, 42.98) controlPoint1: CGPointMake(53.74, 44.3) controlPoint2: CGPointMake(54.34, 43.71)];
                [bezier4Path addCurveToPoint: CGPointMake(53, 41.66) controlPoint1: CGPointMake(54.34, 42.25) controlPoint2: CGPointMake(53.74, 41.66)];
                [bezier4Path addLineToPoint: CGPointMake(49.28, 41.66)];
                [bezier4Path addLineToPoint: CGPointMake(49.28, 39.3)];
                [bezier4Path addLineToPoint: CGPointMake(53, 39.3)];
                [bezier4Path closePath];
                bezier4Path.miterLimit = 4;
                
                bezier4Path.usesEvenOddFillRule = YES;
                
                [color9 setFill];
                [bezier4Path fill];
                
                
                //// Bezier 5 Drawing
                UIBezierPath* bezier5Path = UIBezierPath.bezierPath;
                [bezier5Path moveToPoint: CGPointMake(43.48, 31.67)];
                [bezier5Path addCurveToPoint: CGPointMake(42.15, 32.98) controlPoint1: CGPointMake(42.75, 31.67) controlPoint2: CGPointMake(42.15, 32.26)];
                [bezier5Path addLineToPoint: CGPointMake(42.15, 39.17)];
                [bezier5Path addLineToPoint: CGPointMake(36.97, 32.19)];
                [bezier5Path addCurveToPoint: CGPointMake(35.9, 31.67) controlPoint1: CGPointMake(36.72, 31.86) controlPoint2: CGPointMake(36.32, 31.67)];
                [bezier5Path addCurveToPoint: CGPointMake(35.48, 31.73) controlPoint1: CGPointMake(35.76, 31.67) controlPoint2: CGPointMake(35.61, 31.69)];
                [bezier5Path addCurveToPoint: CGPointMake(34.56, 32.98) controlPoint1: CGPointMake(34.93, 31.91) controlPoint2: CGPointMake(34.56, 32.42)];
                [bezier5Path addLineToPoint: CGPointMake(34.56, 42.98)];
                [bezier5Path addCurveToPoint: CGPointMake(35.9, 44.3) controlPoint1: CGPointMake(34.56, 43.71) controlPoint2: CGPointMake(35.16, 44.3)];
                [bezier5Path addCurveToPoint: CGPointMake(37.23, 42.98) controlPoint1: CGPointMake(36.63, 44.3) controlPoint2: CGPointMake(37.23, 43.71)];
                [bezier5Path addLineToPoint: CGPointMake(37.23, 36.8)];
                [bezier5Path addLineToPoint: CGPointMake(42.42, 43.77)];
                [bezier5Path addCurveToPoint: CGPointMake(43.48, 44.3) controlPoint1: CGPointMake(42.67, 44.1) controlPoint2: CGPointMake(43.07, 44.3)];
                [bezier5Path addCurveToPoint: CGPointMake(43.91, 44.23) controlPoint1: CGPointMake(43.63, 44.3) controlPoint2: CGPointMake(43.77, 44.28)];
                [bezier5Path addCurveToPoint: CGPointMake(44.82, 42.98) controlPoint1: CGPointMake(44.45, 44.05) controlPoint2: CGPointMake(44.82, 43.55)];
                [bezier5Path addLineToPoint: CGPointMake(44.82, 32.98)];
                [bezier5Path addCurveToPoint: CGPointMake(43.48, 31.67) controlPoint1: CGPointMake(44.82, 32.26) controlPoint2: CGPointMake(44.22, 31.67)];
                [bezier5Path closePath];
                bezier5Path.miterLimit = 4;
                
                bezier5Path.usesEvenOddFillRule = YES;
                
                [color9 setFill];
                [bezier5Path fill];
                
                
                //// Bezier 6 Drawing
                UIBezierPath* bezier6Path = UIBezierPath.bezierPath;
                [bezier6Path moveToPoint: CGPointMake(31.31, 31.67)];
                [bezier6Path addCurveToPoint: CGPointMake(29.98, 32.98) controlPoint1: CGPointMake(30.57, 31.67) controlPoint2: CGPointMake(29.98, 32.26)];
                [bezier6Path addLineToPoint: CGPointMake(29.98, 42.98)];
                [bezier6Path addCurveToPoint: CGPointMake(31.31, 44.3) controlPoint1: CGPointMake(29.98, 43.71) controlPoint2: CGPointMake(30.57, 44.3)];
                [bezier6Path addCurveToPoint: CGPointMake(32.65, 42.98) controlPoint1: CGPointMake(32.05, 44.3) controlPoint2: CGPointMake(32.65, 43.71)];
                [bezier6Path addLineToPoint: CGPointMake(32.65, 32.98)];
                [bezier6Path addCurveToPoint: CGPointMake(31.31, 31.67) controlPoint1: CGPointMake(32.65, 32.26) controlPoint2: CGPointMake(32.05, 31.67)];
                [bezier6Path closePath];
                bezier6Path.miterLimit = 4;
                
                bezier6Path.usesEvenOddFillRule = YES;
                
                [color9 setFill];
                [bezier6Path fill];
                
                
                //// Bezier 7 Drawing
                UIBezierPath* bezier7Path = UIBezierPath.bezierPath;
                [bezier7Path moveToPoint: CGPointMake(27.41, 41.66)];
                [bezier7Path addLineToPoint: CGPointMake(23.69, 41.66)];
                [bezier7Path addLineToPoint: CGPointMake(23.69, 32.98)];
                [bezier7Path addCurveToPoint: CGPointMake(22.36, 31.67) controlPoint1: CGPointMake(23.69, 32.26) controlPoint2: CGPointMake(23.09, 31.67)];
                [bezier7Path addCurveToPoint: CGPointMake(21.02, 32.98) controlPoint1: CGPointMake(21.62, 31.67) controlPoint2: CGPointMake(21.02, 32.26)];
                [bezier7Path addLineToPoint: CGPointMake(21.02, 42.98)];
                [bezier7Path addCurveToPoint: CGPointMake(22.36, 44.3) controlPoint1: CGPointMake(21.02, 43.71) controlPoint2: CGPointMake(21.62, 44.3)];
                [bezier7Path addLineToPoint: CGPointMake(27.41, 44.3)];
                [bezier7Path addCurveToPoint: CGPointMake(28.75, 42.98) controlPoint1: CGPointMake(28.15, 44.3) controlPoint2: CGPointMake(28.75, 43.71)];
                [bezier7Path addCurveToPoint: CGPointMake(27.41, 41.66) controlPoint1: CGPointMake(28.75, 42.25) controlPoint2: CGPointMake(28.15, 41.66)];
                [bezier7Path closePath];
                bezier7Path.miterLimit = 4;
                
                bezier7Path.usesEvenOddFillRule = YES;
                
                [color9 setFill];
                [bezier7Path fill];
            }
        }
    }
}

+ (void)drawMessageBackground;
{
    //// Color Declarations
    UIColor* color4 = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0.2 alpha: 1];
    CGFloat color4HSBA[4];
    [color4 getHue: &color4HSBA[0] saturation: &color4HSBA[1] brightness: &color4HSBA[2] alpha: &color4HSBA[3]];
    
    UIColor* color5 = [UIColor colorWithHue: color4HSBA[0] saturation: color4HSBA[1] brightness: 0.6 alpha: color4HSBA[3]];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 75, 75)];
    [color5 setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(50.23, 26.47)];
    [bezierPath addCurveToPoint: CGPointMake(50.23, 45.61) controlPoint1: CGPointMake(57.26, 31.75) controlPoint2: CGPointMake(57.26, 40.32)];
    [bezierPath addCurveToPoint: CGPointMake(46.92, 47.58) controlPoint1: CGPointMake(49.21, 46.38) controlPoint2: CGPointMake(48.1, 47.03)];
    [bezierPath addCurveToPoint: CGPointMake(50.53, 54.5) controlPoint1: CGPointMake(48.34, 50.9) controlPoint2: CGPointMake(50.53, 54.5)];
    [bezierPath addCurveToPoint: CGPointMake(42.28, 49.09) controlPoint1: CGPointMake(50.53, 54.5) controlPoint2: CGPointMake(45.18, 51.66)];
    [bezierPath addCurveToPoint: CGPointMake(24.77, 45.61) controlPoint1: CGPointMake(36.24, 50.34) controlPoint2: CGPointMake(29.51, 49.18)];
    [bezierPath addCurveToPoint: CGPointMake(24.77, 26.47) controlPoint1: CGPointMake(17.74, 40.32) controlPoint2: CGPointMake(17.74, 31.75)];
    [bezierPath addCurveToPoint: CGPointMake(50.23, 26.47) controlPoint1: CGPointMake(31.8, 21.18) controlPoint2: CGPointMake(43.2, 21.18)];
    [bezierPath closePath];
    [color5 setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
}

+ (void)drawPastboardBackground;
{
    //// Color Declarations
    UIColor* color4 = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0.2 alpha: 1];
    CGFloat color4HSBA[4];
    [color4 getHue: &color4HSBA[0] saturation: &color4HSBA[1] brightness: &color4HSBA[2] alpha: &color4HSBA[3]];
    
    UIColor* color5 = [UIColor colorWithHue: color4HSBA[0] saturation: color4HSBA[1] brightness: 0.6 alpha: color4HSBA[3]];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 75, 75)];
    [color5 setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(30.5, 47.5)];
    [bezierPath addLineToPoint: CGPointMake(51.5, 47.5)];
    [bezierPath addLineToPoint: CGPointMake(51.5, 27.9)];
    [bezierPath addLineToPoint: CGPointMake(44.06, 20.5)];
    [bezierPath addLineToPoint: CGPointMake(30.5, 20.5)];
    [bezierPath addLineToPoint: CGPointMake(30.5, 47.5)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(44.06, 20.5)];
    [bezierPath addLineToPoint: CGPointMake(44.06, 27.9)];
    [bezierPath addLineToPoint: CGPointMake(51.5, 27.9)];
    [bezierPath moveToPoint: CGPointMake(46.5, 47.5)];
    [bezierPath addCurveToPoint: CGPointMake(46.5, 53.5) controlPoint1: CGPointMake(46.5, 50.85) controlPoint2: CGPointMake(46.5, 53.5)];
    [bezierPath addLineToPoint: CGPointMake(25.5, 53.5)];
    [bezierPath addLineToPoint: CGPointMake(25.5, 26.5)];
    [bezierPath addLineToPoint: CGPointMake(30.5, 26.5)];
    [color5 setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
}

+ (void)drawOtherBackground;
{
    //// Color Declarations
    UIColor* color4 = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0.2 alpha: 1];
    CGFloat color4HSBA[4];
    [color4 getHue: &color4HSBA[0] saturation: &color4HSBA[1] brightness: &color4HSBA[2] alpha: &color4HSBA[3]];
    
    UIColor* color5 = [UIColor colorWithHue: color4HSBA[0] saturation: color4HSBA[1] brightness: 0.6 alpha: color4HSBA[3]];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 75, 75)];
    [color5 setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    
    //// Group
    {
        //// Oval 4 Drawing
        UIBezierPath* oval4Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(19.5, 34.5, 8, 8)];
        [color5 setStroke];
        oval4Path.lineWidth = 1;
        [oval4Path stroke];
        
        
        //// Oval 2 Drawing
        UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(33.5, 34.5, 8, 8)];
        [color5 setStroke];
        oval2Path.lineWidth = 1;
        [oval2Path stroke];
        
        
        //// Oval 3 Drawing
        UIBezierPath* oval3Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(47.5, 34.5, 8, 8)];
        [color5 setStroke];
        oval3Path.lineWidth = 1;
        [oval3Path stroke];
    }
}

+ (void)drawCamerRollBackground;
{
    //// Color Declarations
    UIColor* color4 = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0.2 alpha: 1];
    CGFloat color4HSBA[4];
    [color4 getHue: &color4HSBA[0] saturation: &color4HSBA[1] brightness: &color4HSBA[2] alpha: &color4HSBA[3]];
    
    UIColor* color5 = [UIColor colorWithHue: color4HSBA[0] saturation: color4HSBA[1] brightness: 0.6 alpha: color4HSBA[3]];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 75, 75)];
    [color5 setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    
    //// Group
    {
        //// Bezier Drawing
        UIBezierPath* bezierPath = UIBezierPath.bezierPath;
        [bezierPath moveToPoint: CGPointMake(31.5, 30.5)];
        [bezierPath addLineToPoint: CGPointMake(27.5, 30.5)];
        [bezierPath addLineToPoint: CGPointMake(27.5, 49.5)];
        [bezierPath addLineToPoint: CGPointMake(48.5, 49.5)];
        [bezierPath addLineToPoint: CGPointMake(48.5, 30.5)];
        [bezierPath addLineToPoint: CGPointMake(44.5, 30.5)];
        [color5 setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
        
        
        //// Group 2
        {
            //// Bezier 2 Drawing
            UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
            [bezier2Path moveToPoint: CGPointMake(32, 37.5)];
            [bezier2Path addLineToPoint: CGPointMake(38, 43.5)];
            [bezier2Path addLineToPoint: CGPointMake(44, 37.5)];
            [bezier2Path addLineToPoint: CGPointMake(44, 37.5)];
            [color5 setStroke];
            bezier2Path.lineWidth = 1;
            [bezier2Path stroke];
            
            
            //// Bezier 3 Drawing
            UIBezierPath* bezier3Path = UIBezierPath.bezierPath;
            [bezier3Path moveToPoint: CGPointMake(38, 43.5)];
            [bezier3Path addLineToPoint: CGPointMake(38, 16.5)];
            [color5 setStroke];
            bezier3Path.lineWidth = 1;
            [bezier3Path stroke];
        }
    }
}

+ (void)drawBackBackground;
{
    //// Color Declarations
    UIColor* color4 = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0.2 alpha: 1];
    CGFloat color4HSBA[4];
    [color4 getHue: &color4HSBA[0] saturation: &color4HSBA[1] brightness: &color4HSBA[2] alpha: &color4HSBA[3]];
    
    UIColor* color5 = [UIColor colorWithHue: color4HSBA[0] saturation: color4HSBA[1] brightness: 0.6 alpha: color4HSBA[3]];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 75, 75)];
    [color5 setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    
    //// Group
    {
        //// Bezier Drawing
        UIBezierPath* bezierPath = UIBezierPath.bezierPath;
        [bezierPath moveToPoint: CGPointMake(29.5, 28.5)];
        [bezierPath addLineToPoint: CGPointMake(19.5, 38.5)];
        [bezierPath addLineToPoint: CGPointMake(29.5, 48.5)];
        [color5 setStroke];
        bezierPath.lineWidth = 1;
        [bezierPath stroke];
        
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
        [bezier2Path moveToPoint: CGPointMake(19.5, 38.5)];
        [bezier2Path addLineToPoint: CGPointMake(56.5, 38.5)];
        [color5 setStroke];
        bezier2Path.lineWidth = 1;
        [bezier2Path stroke];
    }
}

+ (void)drawSmallBackground;
{
    //// Color Declarations
    UIColor* color4 = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0.2 alpha: 1];
    CGFloat color4HSBA[4];
    [color4 getHue: &color4HSBA[0] saturation: &color4HSBA[1] brightness: &color4HSBA[2] alpha: &color4HSBA[3]];
    
    UIColor* color5 = [UIColor colorWithHue: color4HSBA[0] saturation: color4HSBA[1] brightness: 0.6 alpha: color4HSBA[3]];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 75, 75)];
    [color5 setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(8, 31, 61, 15);
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 11.5], NSForegroundColorAttributeName: color5, NSParagraphStyleAttributeName: textStyle};
    
    [@"640 × 640" drawInRect: textRect withAttributes: textFontAttributes];
}

+ (void)drawNormalBackground;
{
    //// Color Declarations
    UIColor* color4 = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0.2 alpha: 1];
    CGFloat color4HSBA[4];
    [color4 getHue: &color4HSBA[0] saturation: &color4HSBA[1] brightness: &color4HSBA[2] alpha: &color4HSBA[3]];
    
    UIColor* color5 = [UIColor colorWithHue: color4HSBA[0] saturation: color4HSBA[1] brightness: 0.6 alpha: color4HSBA[3]];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 75, 75)];
    [color5 setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(8, 31, 61, 15);
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 10], NSForegroundColorAttributeName: color5, NSParagraphStyleAttributeName: textStyle};
    
    [@"1280 × 1280" drawInRect: textRect withAttributes: textFontAttributes];
}

+ (void)drawLargeBackground;
{
    //// Color Declarations
    UIColor* color4 = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0.2 alpha: 1];
    CGFloat color4HSBA[4];
    [color4 getHue: &color4HSBA[0] saturation: &color4HSBA[1] brightness: &color4HSBA[2] alpha: &color4HSBA[3]];
    
    UIColor* color5 = [UIColor colorWithHue: color4HSBA[0] saturation: color4HSBA[1] brightness: 0.6 alpha: color4HSBA[3]];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 75, 75)];
    [color5 setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    
    //// Text Drawing
    CGRect textRect = CGRectMake(8, 31, 61, 15);
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 10], NSForegroundColorAttributeName: color5, NSParagraphStyleAttributeName: textStyle};
    
    [@"1920 × 1920" drawInRect: textRect withAttributes: textFontAttributes];
}

+ (void)drawDocumentInteractionBackground;
{
    //// Color Declarations
    UIColor* color4 = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0.2 alpha: 1];
    CGFloat color4HSBA[4];
    [color4 getHue: &color4HSBA[0] saturation: &color4HSBA[1] brightness: &color4HSBA[2] alpha: &color4HSBA[3]];
    
    UIColor* color5 = [UIColor colorWithHue: color4HSBA[0] saturation: color4HSBA[1] brightness: 0.6 alpha: color4HSBA[3]];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 75, 75)];
    [color5 setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    
    //// Text Drawing
    UIBezierPath* textPath = UIBezierPath.bezierPath;
    [textPath moveToPoint: CGPointMake(33.05, 41.32)];
    [textPath addLineToPoint: CGPointMake(37.69, 28.7)];
    [textPath addLineToPoint: CGPointMake(37.77, 28.7)];
    [textPath addLineToPoint: CGPointMake(42.33, 41.32)];
    [textPath addLineToPoint: CGPointMake(33.05, 41.32)];
    [textPath closePath];
    [textPath moveToPoint: CGPointMake(35.77, 25.44)];
    [textPath addLineToPoint: CGPointMake(25.11, 52.5)];
    [textPath addLineToPoint: CGPointMake(28.83, 52.5)];
    [textPath addLineToPoint: CGPointMake(31.9, 44.35)];
    [textPath addLineToPoint: CGPointMake(43.48, 44.35)];
    [textPath addLineToPoint: CGPointMake(46.47, 52.5)];
    [textPath addLineToPoint: CGPointMake(50.5, 52.5)];
    [textPath addLineToPoint: CGPointMake(39.8, 25.44)];
    [textPath addLineToPoint: CGPointMake(35.77, 25.44)];
    [textPath closePath];
    textPath.lineCapStyle = kCGLineCapRound;
    
    textPath.lineJoinStyle = kCGLineJoinBevel;
    
    [color5 setStroke];
    textPath.lineWidth = 1;
    [textPath stroke];
}

+ (void)drawResolutionBackground;
{
    //// Color Declarations
    UIColor* color4 = [UIColor colorWithRed: 0.2 green: 0.2 blue: 0.2 alpha: 1];
    CGFloat color4HSBA[4];
    [color4 getHue: &color4HSBA[0] saturation: &color4HSBA[1] brightness: &color4HSBA[2] alpha: &color4HSBA[3]];
    
    UIColor* color5 = [UIColor colorWithHue: color4HSBA[0] saturation: color4HSBA[1] brightness: 0.6 alpha: color4HSBA[3]];
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 75, 75)];
    [color5 setStroke];
    ovalPath.lineWidth = 1;
    [ovalPath stroke];
    
    
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(31.5, 27.5, 19, 19)];
    [color5 setStroke];
    rectanglePath.lineWidth = 1;
    [rectanglePath stroke];
    
    
    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(52.5, 39.5, 7, 7)];
    [color5 setStroke];
    rectangle2Path.lineWidth = 1;
    [rectangle2Path stroke];
    
    
    //// Rectangle 3 Drawing
    UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRect: CGRectMake(17.5, 34.5, 12, 12)];
    [color5 setStroke];
    rectangle3Path.lineWidth = 1;
    [rectangle3Path stroke];
}

@end
