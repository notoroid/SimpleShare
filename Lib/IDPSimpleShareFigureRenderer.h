//
//  IDPSimpleShareFigureRenderer.h
//  
//
//  Created by Noto Kaname on 12/05/03.
//  Copyright (c) 2012年 Irimasu Densan Planning. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IDP_CROP_CROPAREA_FRAME_NAME @"frame"
#define IDP_CROP_CROPAREA_ASPECT_RAOTO_NAME @"cropAspectRatio"
#define IDP_CROP_CROPAREA_ASPECT_EDGE_INSETS_NAME @"edgeInsets"
#define IDP_CROP_CROPAREA_FRAME_TYPE @"frameType"
#define IDP_CROP_TOOLBAR_BUTTON_NORMAL_COLOR @"normalColor"
#define IDP_CROP_TOOLBAR_BUTTON_HIGHLIGHTED_COLOR @"highlightedColor"

typedef NS_ENUM(NSInteger, IDPSimpleShareFigureRendererType)
{
     IDPSimpleShareFigureRendererTypeCloseButton
    ,IDPSimpleShareFigureRendererTypeFacebookPostCloseButton
    ,IDPSimpleShareFigureRendererTypeFacebookPostCloseButtonHighlighted
    ,IDPSimpleShareFigureRendererTypeShareArrowButton
    ,IDPSimpleShareFigureRendererTypeShareArrowButtonHighlighted
    ,IDPSimpleShareFigureRendererTypeThumbnailEmpty
};

@interface IDPSimpleShareFigureRenderer : NSObject

+ (void) renderWithFigureType:(IDPSimpleShareFigureRendererType)figureRendererType options:(NSDictionary*)options;
+ (CGSize) sizeForFigureType:(IDPSimpleShareFigureRendererType)figureRendererType options:(NSDictionary*)options;
+ (UIImage*) createImageWithFigureType:(IDPSimpleShareFigureRendererType)figureRendererType options:(NSDictionary*)options;

@end
