//
//  ViewController.m
//  YJMessageDemo
//
//  Created by Octree on 15/11/27.
//  Copyright © 2015年 Octree. All rights reserved.
//

#import "ViewController.h"
#import "YJMessage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)showErrorMessage:(id)sender {
    
    [YJMessage showMessageInViewController:self
                                     Title:@"//  hey, error!"
                                  duration:1.5f
                                  type:YJMessageTypeError
                                  callback:nil
                               buttonTitle:@"tap me"
                            buttonCallback:^{
                                
                                NSLog(@"Tapped...");
                            }];
}

@end
