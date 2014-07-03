//
//  IDPShareBackgroundView.h
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/23.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IDPShareBackgroundViewIconType )
{
     IDPShareBackgroundViewIconTypeEmpty
    ,IDPShareBackgroundViewIconTypeInstagram
    ,IDPShareBackgroundViewIconTypeTwitter
    ,IDPShareBackgroundViewIconTypeFacebook
    ,IDPShareBackgroundViewIconTypeLINE
    ,IDPShareBackgroundViewIconTypeMessage
    ,IDPShareBackgroundViewIconTypeMail
    ,IDPShareBackgroundViewIconTypePasteboard
    ,IDPShareBackgroundViewIconTypeOther
    ,IDPShareBackgroundViewIconTypeResolution
    ,IDPShareBackgroundViewIconTypeDocumentInteraction
    ,IDPShareBackgroundViewIconTypeCameraRoll
    ,IDPShareBackgroundViewIconTypeBack
    ,IDPShareBackgroundViewIconTypeSmall
    ,IDPShareBackgroundViewIconTypeNormal
    ,IDPShareBackgroundViewIconTypeLarge
};

@interface IDPShareBackgroundView : UIView

@property (assign,nonatomic) IDPShareBackgroundViewIconType iconType;

@end
