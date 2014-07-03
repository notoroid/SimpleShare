//
//  IDPSimpleShareSlideAndFadeTransition.h
//  SimpleShare
//
//  Created by 能登 要 on 2014/07/02.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IDPSimpleShareSlideAndFadeTransitionType)
{
     IDPSimpleShareSlideAndFadeTransitionTypePush
    ,IDPSimpleShareSlideAndFadeTransitionTypePop
};

@interface IDPSimpleShareSlideAndFadeTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) IDPSimpleShareSlideAndFadeTransitionType transitionType;
@end
