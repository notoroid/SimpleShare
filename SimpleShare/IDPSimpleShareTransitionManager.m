//
//  TransitionManager.m
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/02.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import "TransitionManager.h"
#import "IDPSimpleShareFadeTransition.h"
#import "IDPSimpleShareViewController.h"
#import "IDPActionViewController.h"
#import "IDPResolutionViewController.h"

static IDPSimpleShareTransitionManager *s_sharedTransitionManager = nil;

@implementation IDPSimpleShareTransitionManager

+ (IDPSimpleShareTransitionManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_sharedTransitionManager = [[IDPSimpleShareTransitionManager alloc] init];
    });
    return s_sharedTransitionManager;
}

#pragma mark -
#pragma mark UINavigationController Delegate methods

- (id <UIViewControllerAnimatedTransitioning>)navigationController:
(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if( [fromVC isKindOfClass:[IDPSimpleShareViewController class]] ){
        IDPSimpleShareFadeTransition *transition = [[IDPSimpleShareFadeTransition alloc] init];
        transition.transitionType = (operation == UINavigationControllerOperationPush) ? IDPSimpleShareFadeTransitionTypePush : IDPSimpleShareFadeTransitionTypePop;
        return transition;
    }

    if( [fromVC isKindOfClass:[IDPActionViewController class]] ){
        IDPSimpleShareFadeTransition *transition = [[IDPSimpleShareFadeTransition alloc] init];
        transition.transitionType = (operation == UINavigationControllerOperationPush) ? IDPSimpleShareFadeTransitionTypePush : IDPSimpleShareFadeTransitionTypePop;
        return transition;
    }
    
    if( [fromVC isKindOfClass:[IDPResolutionViewController class]] ){
        IDPSimpleShareFadeTransition *transition = [[IDPSimpleShareFadeTransition alloc] init];
        transition.transitionType = (operation == UINavigationControllerOperationPush) ? IDPSimpleShareFadeTransitionTypePush : IDPSimpleShareFadeTransitionTypePop;
        return transition;
    }
    
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return nil;
}


@end
