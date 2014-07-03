//
//  IDPSimpleShareSlideAndFadeTransition.m
//  SimpleShare
//
//  Created by 能登 要 on 2014/07/02.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import "IDPSimpleShareSlideAndFadeTransition.h"

@implementation IDPSimpleShareSlideAndFadeTransition

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

    UIView *postFormView = nil;
    if( _transitionType == IDPSimpleShareSlideAndFadeTransitionTypePush ){
#define IDP_SIMPLE_SHARE_FORM_VIEW_ID 100
        postFormView = [toViewController.view viewWithTag:IDP_SIMPLE_SHARE_FORM_VIEW_ID];
    }else{
        postFormView = [fromViewController.view viewWithTag:IDP_SIMPLE_SHARE_FORM_VIEW_ID];
    }
    
    if (self.transitionType == IDPSimpleShareSlideAndFadeTransitionTypePush ) { // 次の画面を表示する場合
        [containerView addSubview:toView];

        UIView *superPostFormView = postFormView.superview;
        CGRect originalFrame = postFormView.frame;
        CGRect fromRect = (CGRect){ CGPointMake(.0f, CGRectGetMaxY(containerView.frame) ),originalFrame.size};
        CGRect toRect = [containerView convertRect:originalFrame fromView:toView];
        
        [postFormView removeFromSuperview];
        postFormView.frame = fromRect;
        [containerView addSubview:postFormView];
        
        toView.alpha = .0f;
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             toView.alpha = 1.0f;
                             postFormView.frame = toRect;
                         }
                         completion:^(BOOL finished){
                             [postFormView removeFromSuperview];
                             postFormView.frame = originalFrame;
                             [superPostFormView addSubview:postFormView];
                             
                             BOOL completed = ![transitionContext transitionWasCancelled];
                             [transitionContext completeTransition:completed];
                         }
         ];
    } else { // 元の画面に戻る場合
        [containerView insertSubview:toView belowSubview:fromView];
        
        UIView *superPostFormView = postFormView.superview;
        CGRect originalFrame = postFormView.frame;
        CGRect fromRect = [containerView convertRect:originalFrame fromView:toView];
        CGRect toRect = (CGRect){ CGPointMake(.0f, CGRectGetMaxY(containerView.frame) ),originalFrame.size};

        [postFormView removeFromSuperview];
        postFormView.frame = fromRect;
        [containerView addSubview:postFormView];
        
        fromView.alpha = 1.0f;
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             fromView.alpha = .0f;
                             postFormView.frame = toRect;
                         }
                         completion:^(BOOL finished){
                             [postFormView removeFromSuperview];
                             postFormView.frame = originalFrame;
                             [superPostFormView addSubview:postFormView];
                             
                             BOOL completed = ![transitionContext transitionWasCancelled];
                             [transitionContext completeTransition:completed];
                         }
         ];
    }
}

@end
