//
//  YJMessageView.h
//  FuckingAnimation
//
//  Created by Octree on 15/11/27.
//  Copyright © 2015年 Octree. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YJMessageType) {
    
    YJMessageTypeInfo,
    YJMessageTypeSuccess,
    YJMessageTypeWarning,
    YJMessageTypeError,
};

typedef void (^YJMessageCompletion)();
typedef void (^YJMessageButtonClickCallBack)();

static const CGFloat kYJMessageViewHeight = 60;
static const CGFloat kYJMessageViewMarginLeft = 10;
static const CGFloat kYJMessageViewMarginBottom = 20;
static const CGFloat kYJMessageViewMessageFontSize = 14;
static const NSTimeInterval kYJMessageShowAnimationDuration = 0.15;

@interface YJMessageView : UIView

- (instancetype)initWithTitle:(NSString *)title duration:(NSTimeInterval)duration type:(YJMessageType)type callback:(YJMessageCompletion)callback buttonTitle:(NSString *)buttonTitle buttonCallback:(YJMessageButtonClickCallBack)buttonCallback;

@end
