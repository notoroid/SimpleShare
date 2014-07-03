//
//  FadeInteraction.m
//  Transitions
//
//  インプレスジャパン発行
//  「上を目指すプログラマーのためのiPhoneアプリ開発テクニック iOS 7編」
//  サンプルコード
//

/* ****************************************************
 2-3-1 簡単なインタラクションコントローラの作成
 ※ UIPercentDrivenInteractiveTransitionを利用したインタラクションコントローラ
 **************************************************** */

#import "FadeInteraction.h"

@implementation FadeInteraction
// ビューの登録、ジェスチャーハンドラとの関連づけ
- (void)setView:(UIView *)view
{
    _view = view;
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)handlePan:(UIPanGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            // ジェスチャーを検出したらデリゲートを通じて画面遷移を開始する
            CGPoint point = [gesture locationInView:self.view];
            self.interactive = YES;
            [self.delegate interactionBeganAtPoint:point];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            // ジェスチャーの更新に合わせて画面遷移の進捗を更新する
            CGRect viewRect = self.view.bounds;
            CGPoint translation = [gesture translationInView:self.view];
            CGFloat percent = -(translation.x / CGRectGetWidth(viewRect));
            
//            NSLog(@"percent=%@",@(percent) );
            
            [self updateInteractiveTransition:percent];
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            CGPoint velocity = [gesture velocityInView:self.view];
            if (velocity.x <= 0) {
                // 左方向に動かしていたら画面遷移を継続する
                [self finishInteractiveTransition];
            } else {
                // 右方向に動かしていたらキャンセルとみなす
                [self cancelInteractiveTransition];
            }
            self.interactive = NO;
            break;
        } default:
        break;
    }
}
@end
