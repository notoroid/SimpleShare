//
//  IDPSimpleShareViewController.h
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/23.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDPAbstShareViewController.h"

@protocol IDPSimpleShareViewControllerDelegate;


#define kIDPSimpleShareViewControllerMetadataSubject @"subject"
#define kIDPSimpleShareViewControllerMetadataBody @"body"
#define kIDPSimpleShareViewControllerMetadataMessage @"message"

#define kIDPSimpleShareViewControllerIgnoreFacebookAppID @"YOUR_FACEBOOK_APP_ID"

@interface IDPSimpleShareViewController : IDPAbstShareViewController
+ (instancetype) simpleShareViewController;
@property (weak,nonatomic) id<IDPSimpleShareViewControllerDelegate> delegate;
@end

@protocol IDPSimpleShareViewControllerDelegate <NSObject>

- (UIImage *)simpleShareViewController:(IDPSimpleShareViewController *)simpleShareViewController imageType:(SimpleShareRequireImageType)imageType;
- (NSString *)simpleShareViewControllerAlbumName:(IDPSimpleShareViewController *)simpleShareViewController;
- (NSArray *)simpleShareViewControllerHashTags:(IDPSimpleShareViewController *)simpleShareViewController;
- (BOOL) simpleShareViewControllerAlwaysSaveCameraRoll:(IDPSimpleShareViewController *)simpleShareViewController;

- (NSString *)simpleShareViewControllerFacebookAppID:(IDPSimpleShareViewController *)simpleShareViewController;

- (NSDictionary *)simpleShareViewControllerMessageMetadata:(IDPSimpleShareViewController *)simpleShareViewController;

- (void) simpleShareViewControllerDidDone:(IDPSimpleShareViewController *)simpleShareViewController;

- (void) simpleShareViewControllerDidCancel:(IDPSimpleShareViewController *)simpleShareViewController;



@end
