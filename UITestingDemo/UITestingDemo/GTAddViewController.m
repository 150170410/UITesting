//
//  GTAddViewController.m
//  UITestingDemo
//
//  Created by Pham Chi Cong on 9/23/15.
//  Copyright © 2015 Transcosmos Technologic Arts. All rights reserved.
//

#import "GTAddViewController.h"
#import "AppDelegate.h"

@interface GTAddViewController ()

@end

@implementation GTAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)clickOnAddButton:(id)sender {
    [[kAppDelegate databases] addObject:self.textField.text];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
