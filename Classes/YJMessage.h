//
//  YJMessage.h
//  FuckingAnimation
//
//  Created by Octree on 15/11/27.
//  Copyright © 2015年 Octree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJMessageView.h"

@interface YJMessage : NSObject

+ (void)showMessageInViewController:(UIViewController *)viewController Title:(NSString *)title duration:(NSTimeInterval)duration type:(YJMessageType)type;

+ (void)showMessageInViewController:(UIViewController *)viewController Title:(NSString *)title duration:(NSTimeInterval)duration type:(YJMessageType)type callback:(YJMessageCompletion)callback buttonTitle:(NSString *)buttonTitle buttonCallback:(YJMessageButtonClickCallBack)buttonCallback;

+ (void)showMessageInViewController:(UIViewController *)viewController Title:(NSString *)title duration:(NSTimeInterval)duration type:(YJMessageType)type callback:(YJMessageCompletion)callback;

@end
