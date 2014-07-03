//
//  IDPActionViewController.h
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/23.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDPAbstShareViewController.h"

@protocol IDPSimpleShareViewControllerDelegate;
@class IDPSimpleShareViewController;

@interface IDPActionViewController : IDPAbstShareViewController

@property (weak,nonatomic) id<IDPSimpleShareViewControllerDelegate> delegate;
@property (weak,nonatomic) IDPSimpleShareViewController *simpleShareViewController;

@end
