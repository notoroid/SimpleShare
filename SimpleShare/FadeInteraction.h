//
//  FadeInteraction.h
//  Transitions
//
//  インプレスジャパン発行
//  「上を目指すプログラマーのためのiPhoneアプリ開発テクニック iOS 7編」
//  サンプルコード
//

#import <UIKit/UIKit.h>

@protocol FadeInteractionDelegate <NSObject>
- (void)interactionBeganAtPoint:(CGPoint)point;
@end

@interface FadeInteraction : UIPercentDrivenInteractiveTransition
@property (nonatomic, weak) id <FadeInteractionDelegate> delegate;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, assign, getter = isInteractive) BOOL interactive;
@end
