//
//  TransitionManager.h
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/02.
//  Copyright (c) 2014年 Irimasu Densan Planning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPSimpleShareTransitionManager : NSObject<UINavigationControllerDelegate>

+ (IDPSimpleShareTransitionManager *)sharedManager;

@end
