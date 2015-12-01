//
//  YJMessage.m
//  FuckingAnimation
//
//  Created by Octree on 15/11/27.
//  Copyright © 2015年 Octree. All rights reserved.
//

#import "YJMessage.h"

@implementation YJMessage

+ (void)showMessageInViewController:(UIViewController *)viewController title:(NSString *)title duration:(NSTimeInterval)duration type:(YJMessageType)type {
    
    [YJMessage showMessageInViewController:viewController title:title duration:duration type:type callback:nil];
}

+ (void)showMessageInViewController:(UIViewController *)viewController title:(NSString *)title duration:(NSTimeInterval)duration type:(YJMessageType)type callback:(YJMessageCompletion)callback {
 
    [YJMessage showMessageInViewController:viewController title:title duration:duration type:type callback:callback buttonTitle:nil buttonCallback:nil];
}

+ (void)showMessageInViewController:(UIViewController *)viewController title:(NSString *)title duration:(NSTimeInterval)duration type:(YJMessageType)type callback:(YJMessageCompletion)callback buttonTitle:(NSString *)buttonTitle buttonCallback:(YJMessageButtonClickCallBack)buttonCallback {
    
    YJMessageView *messageView = [[YJMessageView alloc] initWithTitle:title duration:duration type:type callback:callback buttonTitle:buttonTitle buttonCallback:buttonCallback];
    
    UIViewController *attachViewController = viewController;
    
//    tabbar offset
    CGFloat offset = viewController.tabBarController.tabBar.frame.size.height;
    
    if ([viewController.parentViewController isKindOfClass: [UINavigationController class]]) {
        
        attachViewController = viewController.parentViewController;
    }
    
    UIView *v = attachViewController.view;
    CGFloat vheight = v.frame.size.height;
    CGFloat distance = messageView.frame.size.height + kYJMessageViewMarginBottom;
    CGRect frame = messageView.frame;
    frame.origin.y = vheight - offset;
    messageView.frame = frame;
    [v addSubview: messageView];
    frame.origin.y = vheight - distance - offset;
    messageView.alpha = 0;
    
    [UIView animateWithDuration:kYJMessageShowAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                              | UIViewAnimationOptionBeginFromCurrentState
                              | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         messageView.frame = frame;
                         messageView.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {

                     }];
}

@end
