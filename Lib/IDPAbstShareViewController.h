//
//  IDPAbstShareViewController.h
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/26.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IDPSimpleShareViewControllerExportType )
{
     IDPSimpleShareViewControllerExportTypeCameraRollOnly
    ,IDPSimpleShareViewControllerExportTypeCopyPasteboard
    ,IDPSimpleShareViewControllerExportTypeMail
    ,IDPSimpleShareViewControllerExportTypeMessage
    ,IDPSimpleShareViewControllerExportTypeDocumentInteraction
    ,IDPSimpleShareViewControllerExportTypeInstagram
    ,IDPSimpleShareViewControllerExportTypeLine
};

typedef NS_ENUM(NSInteger, SimpleShareRequireImageType)
{
    SimpleShareRequireImageTypeOriginal
    ,SimpleShareRequireImageType640x640
    ,SimpleShareRequireImageType1280x1280
    ,SimpleShareRequireImageType1920x1920
};

@class IDPSimpleShareViewController;
@protocol IDPSimpleShareViewControllerDelegate;
@class IDPShareBackgroundView;

#define kSimpleShareTypeName @"Type"
#define kSimpleShareLabelName @"Label"

@interface IDPAbstShareViewController : UIViewController

@property(weak,nonatomic) IBOutlet IDPShareBackgroundView *iconView;
@property(weak,nonatomic) IBOutlet IDPShareBackgroundView *icon2View;
@property(weak,nonatomic) IBOutlet IDPShareBackgroundView *icon3View;
@property(weak,nonatomic) IBOutlet IDPShareBackgroundView *icon4View;
@property(weak,nonatomic) IBOutlet IDPShareBackgroundView *icon5View;
@property(weak,nonatomic) IBOutlet IDPShareBackgroundView *icon6View;
@property(weak,nonatomic) IBOutlet IDPShareBackgroundView *icon7View;
@property(weak,nonatomic) IBOutlet IDPShareBackgroundView *icon8View;
@property(weak,nonatomic) IBOutlet IDPShareBackgroundView *icon9View;

@property(weak,nonatomic) IBOutlet UILabel *label;
@property(weak,nonatomic) IBOutlet UILabel *label2;
@property(weak,nonatomic) IBOutlet UILabel *label3;
@property(weak,nonatomic) IBOutlet UILabel *label4;
@property(weak,nonatomic) IBOutlet UILabel *label5;
@property(weak,nonatomic) IBOutlet UILabel *label6;
@property(weak,nonatomic) IBOutlet UILabel *label7;
@property(weak,nonatomic) IBOutlet UILabel *label8;
@property(weak,nonatomic) IBOutlet UILabel *label9;

@property(strong,nonatomic) IBOutlet UIView* waitingView;


#pragma mark - utility method
- (void) exportImageWithExportType:(IDPSimpleShareViewControllerExportType)exportType requireImageType:(SimpleShareRequireImageType)requireImageType simpleShareViewController:(IDPSimpleShareViewController *)simpleShareViewController delegate:(id<IDPSimpleShareViewControllerDelegate>)delegate;

- (BOOL) isEnterWorking;
- (void) setEnterWorking:(BOOL)enterWorking;

- (void) setWaiting;
- (void) resetWaiting;
- (void) updateUserInterfaceWithEnable:(BOOL)enable;

#pragma mark overridemethod
- (NSArray *) initializedButtonWithIconTypes;

@end
