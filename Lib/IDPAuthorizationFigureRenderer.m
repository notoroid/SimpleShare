//
//  IDPAuthorizationFigureRendererr.m
//  IntroductionAndAccept
//
//  Created by Noto Kaname on 12/05/03.
//  Copyright (c) 2012年 Irimasu Densan Planning. All rights reserved.
//

#import "IDPAuthorizationFigureRenderer.h"

@implementation IDPAuthorizationFigureRenderer

+ (void) renderWithFigureType:(IDPAuthorizationFigureRendererType)figureRendererType
{
    switch (figureRendererType) {
        case IDPAuthorizationFigureRendererTypeButtonFrame:
        {
            //// Color Declarations
            UIColor* color = [UIColor colorWithRed: 0 green: 0.424 blue: 0.941 alpha: 1];
            
            //// Rounded Rectangle Drawing
            UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.5, 0.5, 111, 35) cornerRadius: 3];
            [UIColor.whiteColor setFill];
            [roundedRectanglePath fill];
            [color setStroke];
            roundedRectanglePath.lineWidth = 1;
            [roundedRectanglePath stroke];
        }
            break;
        case IDPAuthorizationFigureRendererTypeButtonFrameHighlighted:
        {
            //// Color Declarations
            UIColor* color = [UIColor colorWithRed: 0 green: 0.424 blue: 0.941 alpha: 1];
            
            //// Rounded Rectangle Drawing
            UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.5, 0.5, 111, 35) cornerRadius: 3];
            [color setFill];
            [roundedRectanglePath fill];
            [color setStroke];
            roundedRectanglePath.lineWidth = 1;
            [roundedRectanglePath stroke];
        }
            break;
    case IDPAuthorizationFigureRendererTypeAuthorizedButtonFrame:
        {
            //// Color Declarations
            UIColor* color = [UIColor colorWithRed: 0 green: 0.424 blue: 0.941 alpha: 1];
            
            //// Rounded Rectangle Drawing
            UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.5, 0.5, 111, 35) cornerRadius: 3];
            [color setFill];
            [roundedRectanglePath fill];
            [color setStroke];
            roundedRectanglePath.lineWidth = 1;
            [roundedRectanglePath stroke];
        }
            break;
    case IDPAuthorizationFigureRendererTypeAuthorizedButtonFrameHighlighted:
        {
            //// Color Declarations
            UIColor* color = [UIColor colorWithRed: 0 green: 0.424 blue: 0.941 alpha: 1];
            
            //// Rounded Rectangle Drawing
            UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0.5, 0.5, 111, 35) cornerRadius: 3];
            [UIColor.whiteColor setFill];
            [roundedRectanglePath fill];
            [color setStroke];
            roundedRectanglePath.lineWidth = 1;
            [roundedRectanglePath stroke];
        }
            break;
    default:
        break;
    }
}

+ (CGSize) sizeForFigureType:(IDPAuthorizationFigureRendererType)figureRendererType
{
    CGSize size = CGSizeZero;
    switch (figureRendererType) {
    case IDPAuthorizationFigureRendererTypeButtonFrame:
    case IDPAuthorizationFigureRendererTypeButtonFrameHighlighted:
    case IDPAuthorizationFigureRendererTypeAuthorizedButtonFrame:
    case IDPAuthorizationFigureRendererTypeAuthorizedButtonFrameHighlighted:
        size = CGSizeMake(112.0f, 36.0f);
        break;
    default:
        break;
    }
    return size;
}

+ (UIImage*) createImageWithFigureType:(IDPAuthorizationFigureRendererType)figureRendererType
{
    CGSize sizeImage = [IDPAuthorizationFigureRenderer sizeForFigureType:figureRendererType ];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sizeImage.width ,sizeImage.height ) , NO , [UIScreen mainScreen].scale );
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    
    [IDPAuthorizationFigureRenderer renderWithFigureType:figureRendererType];
    
    CGContextRestoreGState(context);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();        
    
    return image;
}

@end
