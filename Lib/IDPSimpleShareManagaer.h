//
//  IDPSimpleShareManagaer.h
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/24.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPSimpleShareViewController;
@protocol IDPSimpleShareViewControllerDelegate;

@interface IDPSimpleShareManagaer : NSObject

+ (IDPSimpleShareManagaer *) sharedManager;

- (NSDictionary *) captionsByIconType;

- (void) saveImage:(UIImage *)image withAlbumName:(NSString *)albumName metadata:(NSDictionary *)metadata completion:(void (^)(BOOL finished))completion;

- (NSURL *)documentsDirectory;


@end
