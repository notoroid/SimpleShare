//
//  IDPActionViewController.m
//  SimpleImageShare
//
//  Created by 能登 要 on 2014/06/23.
//  Copyright (c) 2014年 com.irimasu. All rights reserved.
//

#import "IDPActionViewController.h"
#import "IDPShareBackgroundView.h"
#import "IDPSimpleShareManagaer.h"
#import "IDPSimpleShareViewController.h"
@import MessageUI;
@import MobileCoreServices;

@interface IDPActionViewController () 
{

}
@end

@implementation IDPActionViewController

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
    
    self.navigationItem.title = @"その他";
}

- (NSArray *) initializedButtonWithIconTypes
{
    NSMutableArray *iconTypes = [NSMutableArray arrayWithArray:@[
                           @(IDPShareBackgroundViewIconTypeMessage)
                           ,@(IDPShareBackgroundViewIconTypeMail)
                           ,@(IDPShareBackgroundViewIconTypeEmpty)
                           ,@(IDPShareBackgroundViewIconTypePasteboard)
                           ,@(IDPShareBackgroundViewIconTypeDocumentInteraction)
                           ,@(IDPShareBackgroundViewIconTypeEmpty)
                           ,@(IDPShareBackgroundViewIconTypeBack)
                           ,@(IDPShareBackgroundViewIconTypeEmpty)
                           ,@(IDPShareBackgroundViewIconTypeEmpty)
                           ]];
    
    if( [MFMessageComposeViewController canSendText] != YES || [MFMessageComposeViewController canSendAttachments] != YES || [MFMessageComposeViewController isSupportedAttachmentUTI:(NSString*)kUTTypeJPEG] != YES ){
        __block NSUInteger messageIndex = NSUIntegerMax;
        [iconTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if( [obj integerValue] == IDPShareBackgroundViewIconTypeMessage ){
                messageIndex = idx;
                *stop = YES;
            }
        }];
        if( messageIndex != NSUIntegerMax ){
            iconTypes[messageIndex] = @(IDPShareBackgroundViewIconTypeEmpty);
        }
    }
    
    if( [MFMailComposeViewController canSendMail] != YES ){
        __block NSUInteger mailIndex = NSUIntegerMax;
        [iconTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if( [obj integerValue] == IDPShareBackgroundViewIconTypeMail ){
                mailIndex = idx;
                *stop = YES;
            }
        }];
        if( mailIndex != NSUIntegerMax ){
            iconTypes[mailIndex] = @(IDPShareBackgroundViewIconTypeEmpty);
        }
    }
    
    return iconTypes;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



- (IBAction)firedDocumentInteraction:(id)sender
{
    if( [self isEnterWorking] != YES ){
        [self setEnterWorking:YES];
        
        [self exportImageWithExportType:IDPSimpleShareViewControllerExportTypeDocumentInteraction requireImageType:SimpleShareRequireImageTypeOriginal simpleShareViewController:_simpleShareViewController delegate:_delegate];
    }else{

    }
    
}

- (IBAction)firedMessage:(id)sender
{
    if( [self isEnterWorking] != YES ){
        [self setEnterWorking:YES];
        
        [self exportImageWithExportType:IDPSimpleShareViewControllerExportTypeMessage requireImageType:SimpleShareRequireImageTypeOriginal simpleShareViewController:_simpleShareViewController delegate:_delegate];
    }else{

    }
}

- (IBAction)firedMail:(id)sender
{
    if( [self isEnterWorking] != YES ){
        [self setEnterWorking:YES];
        
        
        [self exportImageWithExportType:IDPSimpleShareViewControllerExportTypeMessage requireImageType:SimpleShareRequireImageTypeOriginal simpleShareViewController:_simpleShareViewController delegate:_delegate];
    }else{

    }
}

- (IBAction)firedCopyPasteboard:(id)sender {
    if( [self isEnterWorking] != YES ){
        [self setEnterWorking:YES];
        
        [self exportImageWithExportType:IDPSimpleShareViewControllerExportTypeCopyPasteboard requireImageType:SimpleShareRequireImageTypeOriginal simpleShareViewController:_simpleShareViewController delegate:_delegate];
    }else{
        
    }
}


@end
