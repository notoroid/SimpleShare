//
//  IDPResolutionViewController.m
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/23.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import "IDPResolutionViewController.h"
#import "IDPShareBackgroundView.h"
#import "IDPSimpleShareManagaer.h"
#import "IDPSimpleShareViewController.h"

@interface IDPResolutionViewController () 
{

}
@end

@implementation IDPResolutionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"解像度を指定";
}

- (NSArray *) initializedButtonWithIconTypes
{
    NSArray *iconTypes = @[
                           @(IDPShareBackgroundViewIconTypeSmall)
                           ,@(IDPShareBackgroundViewIconTypeNormal)
                           ,@(IDPShareBackgroundViewIconTypeLarge)
                           ,@(IDPShareBackgroundViewIconTypeEmpty)
                           ,@(IDPShareBackgroundViewIconTypeEmpty)
                           ,@(IDPShareBackgroundViewIconTypeEmpty)
                           ,@(IDPShareBackgroundViewIconTypeBack)
                           ,@(IDPShareBackgroundViewIconTypeEmpty)
                           ,@(IDPShareBackgroundViewIconTypeEmpty)
                           ];
    
    return iconTypes;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fired640x640Resolution:(id)sender
{
    if( [self isEnterWorking] != YES ){
        [self setEnterWorking:YES];
        
        [self exportImageWithExportType:IDPSimpleShareViewControllerExportTypeInstagram requireImageType:SimpleShareRequireImageType640x640 simpleShareViewController:_simpleShareViewController delegate:_delegate];
    }
}

- (IBAction)fired1280x1280Resolution:(id)sender
{
    if( [self isEnterWorking] != YES ){
        [self setEnterWorking:YES];
        
        [self exportImageWithExportType:IDPSimpleShareViewControllerExportTypeInstagram requireImageType:SimpleShareRequireImageType1280x1280 simpleShareViewController:_simpleShareViewController delegate:_delegate];
    }
}

- (IBAction)fired1920x1920Resolution:(id)sender
{
    if( [self isEnterWorking] != YES ){
        [self setEnterWorking:YES];
        
        [self exportImageWithExportType:IDPSimpleShareViewControllerExportTypeInstagram requireImageType:SimpleShareRequireImageType1920x1920 simpleShareViewController:_simpleShareViewController delegate:_delegate];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
