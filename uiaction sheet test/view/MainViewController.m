//
//  MainViewController.m
//  uiaction sheet test
//
//  Created by lololol on 2/Jun/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
{
    CGFloat cgfU;
    CGFloat cgfScreenWidth;
    CGFloat cgfScreenHeight;
    CGFloat cgfScreenHeightBase;
    CGFloat cgfKeyboardOffset;
}

@end

@implementation MainViewController

- (void)setMyScreenSize
{
    cgfScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    cgfScreenHeight = [[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    cgfScreenHeightBase = [UIApplication sharedApplication].statusBarFrame.size.height;
    if ([UIApplication sharedApplication].statusBarFrame.size.height == 20.0) {
        //without Hotspot: 64
        cgfKeyboardOffset =  cgfScreenHeightBase;
    } else {
        //with Hotspot: 104
        cgfKeyboardOffset = cgfScreenHeightBase + [UIApplication sharedApplication].statusBarFrame.size.height / 2.0;
    }
    NSLog(@"status bar height:%f",[UIApplication sharedApplication].statusBarFrame.size.height);
    NSLog(@"width:%f, height:%f, tabbar:%f, navigationbarcontroller:%f, keyboardOffset: %f", cgfScreenWidth, cgfScreenHeight, self.tabBarController.tabBar.frame.size.height, self.navigationController.navigationBar.frame.size.height, cgfKeyboardOffset);
    cgfU = cgfScreenWidth / 320;
}

- (void)buttonGeneralUseActionSheetClicked:(id)sender {
    NSLog(@"- (void)buttonGeneralUseActionSheetClicked:(id)sender {");
    
    UIActionSheet *uiasGeneralUseActionSheet = [[UIActionSheet alloc] initWithTitle:@"Title for General Use"
                                                                       delegate:self
                                                              cancelButtonTitle:@"Put \"Cancel\" or nil for nothing"
                                                         destructiveButtonTitle:@"A red Line for \"deleting\"; nil for nothing"
                                                              otherButtonTitles:@"Other 1", @"Other 2", @"Other 3", nil];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // In this case the device is an iPad.
        [uiasGeneralUseActionSheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
    }
    else{
        // In this case the device is an iPhone/iPod Touch.
        [uiasGeneralUseActionSheet showInView:self.view];
    }
    uiasGeneralUseActionSheet.tag = 100;
}

- (void)uibDeleteConfirmationActionSheet:(id) sender {
    NSLog(@"- (void)uibDeleteConfirmationActionSheet:(id) sender {");
    
    NSString *cancelTitle = (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) ? @"Put \"Cancel\" or nil for nothing" : nil;
    UIActionSheet *uiasDeleteConfirmationActionSheet = [[UIActionSheet alloc] initWithTitle:@"Title for Delete confirm"
                                                                                   delegate:self
                                                                          cancelButtonTitle:cancelTitle
                                                                     destructiveButtonTitle:@"A red Line for \"deleting\"; nil for nothing"
                                                                          otherButtonTitles:nil];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // In this case the device is an iPad.
        [uiasDeleteConfirmationActionSheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
    }
    else{
        // In this case the device is an iPhone/iPod Touch.
        [uiasDeleteConfirmationActionSheet showInView:self.view];
    }
    uiasDeleteConfirmationActionSheet.tag = 200;
}

#pragma mark - UIActionSheet method implementation
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"The %@ button was tapped.", [actionSheet buttonTitleAtIndex:buttonIndex]);
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{");
}

-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{");
}

- (void)addButtonWithActionSheet
{
    UIButton *uibGeneralUseActionSheet = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [uibGeneralUseActionSheet addTarget:self action:@selector(buttonGeneralUseActionSheetClicked:) forControlEvents:UIControlEventTouchUpInside];
    [uibGeneralUseActionSheet setFrame:CGRectMake(0.0, cgfScreenHeight * 0.2, cgfScreenWidth, cgfScreenHeight * 0.1)];
    [uibGeneralUseActionSheet setTitle:@"Normal Action Sheet" forState:UIControlStateNormal];
    [self.view addSubview:uibGeneralUseActionSheet];

    UIButton *uibDeleteConfirmationActionSheet = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [uibDeleteConfirmationActionSheet addTarget:self action:@selector(uibDeleteConfirmationActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    [uibDeleteConfirmationActionSheet setFrame:CGRectMake(0.0, cgfScreenHeight * 0.3, cgfScreenWidth, cgfScreenHeight * 0.1)];
    [uibDeleteConfirmationActionSheet setTitle:@"Delete Confirmation Action Sheet" forState:UIControlStateNormal];
    [self.view addSubview:uibDeleteConfirmationActionSheet];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMyScreenSize];
    // Do any additional setup after loading the view.
    [self addButtonWithActionSheet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation
ww
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
