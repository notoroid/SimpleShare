//
//  IDPSimpleShareFigureRenderer.m
//  
//
//  Created by Noto Kaname on 12/05/03.
//  Copyright (c) 2012年 Irimasu Densan Planning. All rights reserved.
//

#import "IDPSimpleShareFigureRenderer.h"

@implementation IDPSimpleShareFigureRenderer

+ (void) renderWithFigureType:(IDPSimpleShareFigureRendererType)figureRendererType options:(NSDictionary*)options
{
    switch (figureRendererType) {
    case IDPSimpleShareFigureRendererTypeCloseButton:
    {
        //// Color Declarations
        UIColor* color = [UIColor colorWithRed: 0 green: 0.478 blue: 1 alpha: 1];
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = UIBezierPath.bezierPath;
        [bezierPath moveToPoint: CGPointMake(1.5, 1.5)];
        [bezierPath addLineToPoint: CGPointMake(15.5, 15.5)];
        [bezierPath addLineToPoint: CGPointMake(15.5, 15.5)];
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        [color setStroke];
        bezierPath.lineWidth = 2.5;
        [bezierPath stroke];
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
        [bezier2Path moveToPoint: CGPointMake(15.5, 1.5)];
        [bezier2Path addLineToPoint: CGPointMake(1.5, 15.5)];
        [bezier2Path addLineToPoint: CGPointMake(1.5, 15.5)];
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        [color setStroke];
        bezier2Path.lineWidth = 2.5;
        [bezier2Path stroke];
    }
        break;
    case IDPSimpleShareFigureRendererTypeFacebookPostCloseButton:
    {
        //// Color Declarations
        UIColor* color3 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        
        //// Bezier Drawing
        UIBezierPath* bezierPath = UIBezierPath.bezierPath;
        [bezierPath moveToPoint: CGPointMake(1.5, 1.5)];
        [bezierPath addLineToPoint: CGPointMake(15.5, 15.5)];
        [bezierPath addLineToPoint: CGPointMake(15.5, 15.5)];
        bezierPath.lineCapStyle = kCGLineCapRound;
        
        [color3 setStroke];
        bezierPath.lineWidth = 2.5;
        [bezierPath stroke];
        
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = UIBezierPath.bezierPath;
        [bezier2Path moveToPoint: CGPointMake(15.5, 1.5)];
        [bezier2Path addLineToPoint: CGPointMake(1.5, 15.5)];
        [bezier2Path addLineToPoint: CGPointMake(1.5, 15.5)];
        bezier2Path.lineCapStyle = kCGLineCapRound;
        
        [color3 setStroke];
        bezier2Path.lineWidth = 2.5;
        [bezier2Path stroke];
    }
        break;
    case IDPSimpleShareFigureRendererTypeFacebookPostCloseButtonHighlighted:
    {
        //// Color Declarations
        UIColor* color3 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        UIColor* color4 = [color3 colorWithAlphaComponent: 0.6];
        
        //// Bezier 3 Drawing
        UIBezierPath* bezier3Path = UIBezierPath.bezierPath;
        [bezier3Path moveToPoint: CGPointMake(16.38, 0.62)];
        [bezier3Path addCurveToPoint: CGPointMake(16.38, 2.38) controlPoint1: CGPointMake(16.87, 1.1) controlPoint2: CGPointMake(16.87, 1.9)];
        [bezier3Path addCurveToPoint: CGPointMake(10.27, 8.5) controlPoint1: CGPointMake(16.38, 2.38) controlPoint2: CGPointMake(13.45, 5.32)];
        [bezier3Path addCurveToPoint: CGPointMake(16.38, 14.62) controlPoint1: CGPointMake(13.45, 11.68) controlPoint2: CGPointMake(16.38, 14.62)];
        [bezier3Path addCurveToPoint: CGPointMake(16.38, 16.38) controlPoint1: CGPointMake(16.87, 15.1) controlPoint2: CGPointMake(16.87, 15.9)];
        [bezier3Path addCurveToPoint: CGPointMake(14.62, 16.38) controlPoint1: CGPointMake(15.9, 16.87) controlPoint2: CGPointMake(15.1, 16.87)];
        [bezier3Path addCurveToPoint: CGPointMake(8.5, 10.27) controlPoint1: CGPointMake(14.62, 16.38) controlPoint2: CGPointMake(11.68, 13.45)];
        [bezier3Path addCurveToPoint: CGPointMake(2.38, 16.38) controlPoint1: CGPointMake(5.32, 13.45) controlPoint2: CGPointMake(2.38, 16.38)];
        [bezier3Path addCurveToPoint: CGPointMake(0.62, 16.38) controlPoint1: CGPointMake(1.9, 16.87) controlPoint2: CGPointMake(1.1, 16.87)];
        [bezier3Path addCurveToPoint: CGPointMake(0.62, 14.62) controlPoint1: CGPointMake(0.13, 15.9) controlPoint2: CGPointMake(0.13, 15.1)];
        [bezier3Path addCurveToPoint: CGPointMake(6.73, 8.5) controlPoint1: CGPointMake(0.62, 14.62) controlPoint2: CGPointMake(3.55, 11.68)];
        [bezier3Path addCurveToPoint: CGPointMake(0.62, 2.38) controlPoint1: CGPointMake(3.55, 5.32) controlPoint2: CGPointMake(0.62, 2.38)];
        [bezier3Path addCurveToPoint: CGPointMake(0.62, 0.62) controlPoint1: CGPointMake(0.13, 1.9) controlPoint2: CGPointMake(0.13, 1.1)];
        [bezier3Path addCurveToPoint: CGPointMake(2.38, 0.62) controlPoint1: CGPointMake(1.1, 0.13) controlPoint2: CGPointMake(1.9, 0.13)];
        [bezier3Path addCurveToPoint: CGPointMake(8.5, 6.73) controlPoint1: CGPointMake(2.38, 0.62) controlPoint2: CGPointMake(5.32, 3.55)];
        [bezier3Path addCurveToPoint: CGPointMake(14.62, 0.62) controlPoint1: CGPointMake(11.68, 3.55) controlPoint2: CGPointMake(14.62, 0.62)];
        [bezier3Path addCurveToPoint: CGPointMake(16.38, 0.62) controlPoint1: CGPointMake(15.1, 0.13) controlPoint2: CGPointMake(15.9, 0.13)];
        [bezier3Path closePath];
        [color4 setFill];
        [bezier3Path fill];
    }
        break;
    case IDPSimpleShareFigureRendererTypeShareArrowButton:
    {
        //// Color Declarations
        UIColor* color3 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        
        //// Bezier 4 Drawing
        UIBezierPath* bezier4Path = UIBezierPath.bezierPath;
        [bezier4Path moveToPoint: CGPointMake(10.21, 1.79)];
        [bezier4Path addLineToPoint: CGPointMake(15.71, 7.29)];
        [bezier4Path addCurveToPoint: CGPointMake(16, 8) controlPoint1: CGPointMake(15.94, 7.61) controlPoint2: CGPointMake(16, 7.8)];
        [bezier4Path addCurveToPoint: CGPointMake(15.81, 8.59) controlPoint1: CGPointMake(16, 8.22) controlPoint2: CGPointMake(15.93, 8.43)];
        [bezier4Path addCurveToPoint: CGPointMake(10.21, 14.21) controlPoint1: CGPointMake(15.71, 8.71) controlPoint2: CGPointMake(10.21, 14.21)];
        [bezier4Path addCurveToPoint: CGPointMake(8.79, 14.21) controlPoint1: CGPointMake(9.82, 14.6) controlPoint2: CGPointMake(9.18, 14.6)];
        [bezier4Path addCurveToPoint: CGPointMake(8.79, 12.79) controlPoint1: CGPointMake(8.4, 13.82) controlPoint2: CGPointMake(8.4, 13.18)];
        [bezier4Path addCurveToPoint: CGPointMake(12.59, 9) controlPoint1: CGPointMake(8.79, 12.79) controlPoint2: CGPointMake(10.97, 10.61)];
        [bezier4Path addLineToPoint: CGPointMake(1, 9)];
        [bezier4Path addCurveToPoint: CGPointMake(0, 8) controlPoint1: CGPointMake(0.45, 9) controlPoint2: CGPointMake(0, 8.55)];
        [bezier4Path addCurveToPoint: CGPointMake(1, 7) controlPoint1: CGPointMake(0, 7.45) controlPoint2: CGPointMake(0.45, 7)];
        [bezier4Path addLineToPoint: CGPointMake(12.59, 7)];
        [bezier4Path addCurveToPoint: CGPointMake(8.79, 3.21) controlPoint1: CGPointMake(10.97, 5.39) controlPoint2: CGPointMake(8.79, 3.21)];
        [bezier4Path addCurveToPoint: CGPointMake(8.79, 1.79) controlPoint1: CGPointMake(8.4, 2.82) controlPoint2: CGPointMake(8.4, 2.18)];
        [bezier4Path addCurveToPoint: CGPointMake(10.21, 1.79) controlPoint1: CGPointMake(9.18, 1.4) controlPoint2: CGPointMake(9.82, 1.4)];
        [bezier4Path closePath];
        [color3 setFill];
        [bezier4Path fill];
    }
        break;
    case IDPSimpleShareFigureRendererTypeShareArrowButtonHighlighted:
    {
        //// Color Declarations
        UIColor* color3 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
        UIColor* color4 = [color3 colorWithAlphaComponent: 0.6];
        
        //// Bezier 4 Drawing
        UIBezierPath* bezier4Path = UIBezierPath.bezierPath;
        [bezier4Path moveToPoint: CGPointMake(10.21, 1.79)];
        [bezier4Path addLineToPoint: CGPointMake(15.71, 7.29)];
        [bezier4Path addCurveToPoint: CGPointMake(16, 8) controlPoint1: CGPointMake(15.94, 7.61) controlPoint2: CGPointMake(16, 7.8)];
        [bezier4Path addCurveToPoint: CGPointMake(15.81, 8.59) controlPoint1: CGPointMake(16, 8.22) controlPoint2: CGPointMake(15.93, 8.43)];
        [bezier4Path addCurveToPoint: CGPointMake(10.21, 14.21) controlPoint1: CGPointMake(15.71, 8.71) controlPoint2: CGPointMake(10.21, 14.21)];
        [bezier4Path addCurveToPoint: CGPointMake(8.79, 14.21) controlPoint1: CGPointMake(9.82, 14.6) controlPoint2: CGPointMake(9.18, 14.6)];
        [bezier4Path addCurveToPoint: CGPointMake(8.79, 12.79) controlPoint1: CGPointMake(8.4, 13.82) controlPoint2: CGPointMake(8.4, 13.18)];
        [bezier4Path addCurveToPoint: CGPointMake(12.59, 9) controlPoint1: CGPointMake(8.79, 12.79) controlPoint2: CGPointMake(10.97, 10.61)];
        [bezier4Path addLineToPoint: CGPointMake(1, 9)];
        [bezier4Path addCurveToPoint: CGPointMake(0, 8) controlPoint1: CGPointMake(0.45, 9) controlPoint2: CGPointMake(0, 8.55)];
        [bezier4Path addCurveToPoint: CGPointMake(1, 7) controlPoint1: CGPointMake(0, 7.45) controlPoint2: CGPointMake(0.45, 7)];
        [bezier4Path addLineToPoint: CGPointMake(12.59, 7)];
        [bezier4Path addCurveToPoint: CGPointMake(8.79, 3.21) controlPoint1: CGPointMake(10.97, 5.39) controlPoint2: CGPointMake(8.79, 3.21)];
        [bezier4Path addCurveToPoint: CGPointMake(8.79, 1.79) controlPoint1: CGPointMake(8.4, 2.82) controlPoint2: CGPointMake(8.4, 2.18)];
        [bezier4Path addCurveToPoint: CGPointMake(10.21, 1.79) controlPoint1: CGPointMake(9.18, 1.4) controlPoint2: CGPointMake(9.82, 1.4)];
        [bezier4Path closePath];
        [color4 setFill];
        [bezier4Path fill];
    }
        break;
    case IDPSimpleShareFigureRendererTypeThumbnailEmpty:
    {
        //// Color Declarations
        UIColor* color5 = [UIColor colorWithRed: 0.98 green: 0.98 blue: 0.98 alpha: 1];
        
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0.25, 0.25, 71.5, 71.5)];
        [color5 setFill];
        [rectanglePath fill];
        [UIColor.lightGrayColor setStroke];
        rectanglePath.lineWidth = 0.5;
        [rectanglePath stroke];
    }
        break;
    default:
        break;
    }
}

+ (CGSize) sizeForFigureType:(IDPSimpleShareFigureRendererType)figureRendererType options:(NSDictionary*)options
{
    CGSize size = CGSizeZero;
    switch (figureRendererType) {
    case IDPSimpleShareFigureRendererTypeCloseButton:
        size = CGSizeMake(17.0f,17.0f);
        break;
    case IDPSimpleShareFigureRendererTypeFacebookPostCloseButton:
    case IDPSimpleShareFigureRendererTypeFacebookPostCloseButtonHighlighted:
        size = CGSizeMake(17.0f,17.0f);
        break;
    case IDPSimpleShareFigureRendererTypeShareArrowButton:
    case IDPSimpleShareFigureRendererTypeShareArrowButtonHighlighted:
        size = CGSizeMake(16.0f,16.0f);
        break;
    case IDPSimpleShareFigureRendererTypeThumbnailEmpty:
        size = CGSizeMake(72.0f,72.0f);
        break;
    default:
        break;
    }
    return size;
}

+ (UIImage*) createImageWithFigureType:(IDPSimpleShareFigureRendererType)figureRendererType options:(NSDictionary*)options
{
    CGSize sizeImage = [IDPSimpleShareFigureRenderer sizeForFigureType:figureRendererType options:options];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sizeImage.width ,sizeImage.height ) , NO , [UIScreen mainScreen].scale );
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    
    [IDPSimpleShareFigureRenderer renderWithFigureType:figureRendererType options:options];
    
    CGContextRestoreGState(context);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();        
    
    return image;
}

@end
