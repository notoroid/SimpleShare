//
//  IDPSimpleShareFadeTransition.h
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/26.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, IDPSimpleShareFadeTransitionType)
{
     IDPSimpleShareFadeTransitionTypePush
    ,IDPSimpleShareFadeTransitionTypePop
};

@interface IDPSimpleShareFadeTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) IDPSimpleShareFadeTransitionType transitionType;
@end
