//
//  IDPSimpleShareFadeTransition.m
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/26.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import "IDPSimpleShareFadeTransition.h"

@implementation IDPSimpleShareFadeTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return .25f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    
    UIView *containerView = [transitionContext containerView];
    
    if (self.transitionType == IDPSimpleShareFadeTransitionTypePush ) { // 次の画面を表示する場合
        [containerView addSubview:toView];
        
        toView.alpha = .0f;
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             toView.alpha = 1.0f;
                         }
                         completion:^(BOOL finished){
                             BOOL completed = ![transitionContext transitionWasCancelled];
                             [transitionContext completeTransition:completed];
                         }
         ];
    } else { // 元の画面に戻る場合
        [containerView insertSubview:toView belowSubview:fromView];
        
        fromView.alpha = 1.0f;
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             fromView.alpha = .0f;
                         }
                         completion:^(BOOL finished){
                             BOOL completed = ![transitionContext transitionWasCancelled];
                             [transitionContext completeTransition:completed];
                         }
         ];
    }
}

@end
