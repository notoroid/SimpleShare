//
//  ViewController.m
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/23.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import "ViewController.h"
#import "IDPSimpleShareViewController.h"
@import AssetsLibrary;

@interface ViewController () <IDPSimpleShareViewControllerDelegate/*,IDPAuthorizationViewControllerDelegate*/>
{
    UIImage *_originalImage;
    
//    BOOL _visibleIntroduction;
//    __weak UIView *_asstsLibraryAuthorizationView;
//    __weak UIViewController *_asstsLibraryAuthorizationController;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"picture1280x1280" ofType:@"jpg"];
    NSURL *URL = [NSURL fileURLWithPath:path];
    _originalImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL]];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)firedStart:(id)sender
{
    IDPSimpleShareViewController *simpleShareViewController = [IDPSimpleShareViewController simpleShareViewController];
    [simpleShareViewController setDelegate:self];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:simpleShareViewController];
    
    
    [self presentViewController:navigationController animated:YES completion:^{
       
    }];
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

- (UIImage *)simpleShareViewController:(IDPSimpleShareViewController *)simpleShareViewController imageType:(SimpleShareRequireImageType)imageType
{
    [NSThread sleepForTimeInterval:3.0];
    
    return _originalImage;
}

- (NSArray *)simpleShareViewControllerHashTags:(IDPSimpleShareViewController *)simpleShareViewController
{
    return @[@"#simpleshare"];
}

- (NSString *)simpleShareViewControllerAlbumName:(IDPSimpleShareViewController *)simpleShareViewController
{
    return @"simpleshare";
}

- (NSString *)simpleShareViewControllerFacebookAppID:(IDPSimpleShareViewController *)simpleShareViewController
{
#warning Input FacebookApp ID
    return @"YOUR_FACEBOOK_APP_ID";
}

- (NSDictionary *)simpleShareViewControllerMessageMetadata:(IDPSimpleShareViewController *)simpleShareViewController
{
    
    return @{ kIDPSimpleShareViewControllerMetadataSubject:@""
             ,kIDPSimpleShareViewControllerMetadataBody:@"SimpleShareで写真共有を貴方のアプリに"
             ,kIDPSimpleShareViewControllerMetadataMessage:@"これはテスト投稿となります。"
             };
}


- (void) simpleShareViewControllerDidDone:(IDPSimpleShareViewController *)simpleShareViewController
{
    [self dismissViewControllerAnimated:YES completion:^{
       
    }];
}

- (void) simpleShareViewControllerDidCancel:(IDPSimpleShareViewController *)simpleShareViewController
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
