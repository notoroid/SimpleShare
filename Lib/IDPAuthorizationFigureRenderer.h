//
//  IDPAuthorizationFigureRenderer.h
//  Eertyks
//
//  Created by Noto Kaname on 12/05/03.
//  Copyright (c) 2012年 Irimasu Densan Planning. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,IDPAuthorizationFigureRendererType)
{
     IDPAuthorizationFigureRendererTypeButtonFrame
    ,IDPAuthorizationFigureRendererTypeButtonFrameHighlighted
    ,IDPAuthorizationFigureRendererTypeAuthorizedButtonFrame
    ,IDPAuthorizationFigureRendererTypeAuthorizedButtonFrameHighlighted
};

@class CCSprite;
@class CCSpriteBatchNode;

@interface IDPAuthorizationFigureRenderer : NSObject

+ (void) renderWithFigureType:(IDPAuthorizationFigureRendererType)figureRendererType;
+ (CGSize) sizeForFigureType:(IDPAuthorizationFigureRendererType)figureRendererType;

+ (UIImage*) createImageWithFigureType:(IDPAuthorizationFigureRendererType)figureRendererType;

@end
