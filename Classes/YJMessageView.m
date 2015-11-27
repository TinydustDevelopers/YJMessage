//
//  YJMessageView.m
//  FuckingAnimation
//
//  Created by Octree on 15/11/27.
//  Copyright © 2015年 Octree. All rights reserved.
//

#import "YJMessageView.h"

const static CGFloat kYJMessageIconWidth = 30;
const static CGFloat kYJMessageIconMarginLeft = 10;
const static CGFloat kYJMessageLabelMarginLeft = 10;
const static CGFloat kYJMessageLabelMarginRight = 10;
const static CGFloat kYJMessageButtonWith = 67;
const static CGFloat kYJMessageButtonMarginRight = 0;

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface YJMessageView ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *button;
@property (copy) void (^callback)();
@property (copy) void (^buttonCallback)();
@property (nonatomic) NSTimeInterval duration;
@property (strong, nonatomic) UIView *containerView;

@end

@implementation YJMessageView

#pragma mark - life cycle

- (instancetype)initWithTitle:(NSString *)title duration:(NSTimeInterval)duration type:(YJMessageType)type callback:(YJMessageCompletion)callback buttonTitle:(NSString *)buttonTitle buttonCallback:(YJMessageButtonClickCallBack)buttonCallback {
    
    self = [super init];
    if (self) {
        
        _callback = callback;
        _buttonCallback = buttonCallback;
        _duration = duration;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
        CGFloat vWidth = width - 2 * kYJMessageViewMarginLeft;
        CGFloat labelWidth = vWidth - kYJMessageIconMarginLeft - kYJMessageIconWidth - kYJMessageLabelMarginLeft - kYJMessageLabelMarginRight;
        if (buttonTitle) {
            
            labelWidth -= kYJMessageButtonWith + kYJMessageButtonMarginRight;
        }
        
        self.titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, labelWidth, 17)];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.font = [UIFont systemFontOfSize: kYJMessageViewMessageFontSize];
        CGSize labelSize = [title boundingRectWithSize:CGSizeMake(labelWidth, CGFLOAT_MAX)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{ NSFontAttributeName: self.titleLabel.font }
                                               context:nil].size;
        
        CGFloat vHeight = kYJMessageViewHeight + (labelSize.height - 17);
        
        self.frame = CGRectMake(kYJMessageViewMarginLeft, 100, vWidth, vHeight);
        [self addSubview: self.containerView];
        self.containerView.backgroundColor = [self backgroundColorForType: type];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame: CGRectMake(kYJMessageIconMarginLeft, (vHeight - kYJMessageIconWidth) / 2, kYJMessageIconWidth, kYJMessageIconWidth)];
        imageView.image = [self iconImageForType: type];
        [self.containerView addSubview: imageView];
        
        CGRect labelFrame;
        labelFrame.size = labelSize;
        labelFrame.origin.x = kYJMessageIconWidth + kYJMessageIconMarginLeft + kYJMessageLabelMarginLeft;
        labelFrame.origin.y = (vHeight - labelSize.height) / 2;
        self.titleLabel.frame = labelFrame;
        self.titleLabel.text = title;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self.containerView addSubview: self.titleLabel];
        
        if (buttonTitle) {
            
            self.button = [UIButton buttonWithType: UIButtonTypeSystem];
            self.button.frame = CGRectMake(vWidth - kYJMessageButtonWith - kYJMessageButtonMarginRight, 0, kYJMessageButtonWith, vHeight);
            [self.button setTitle:buttonTitle forState:UIControlStateNormal];
            [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.button addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
            self.button.backgroundColor = [self buttonBackgroundColorForType: type];
            [self.containerView addSubview: self.button];
        }
        
        CALayer *layer = self.layer;
        layer.masksToBounds = NO;
        layer.shadowColor = [UIColor grayColor].CGColor;
        layer.shadowOffset = CGSizeMake(1, 1);
        layer.shadowRadius = 3;
        layer.shadowOpacity = 0.7;
        layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius: 4.0].CGPath;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    }
    
    return self;
}

- (void)didMoveToSuperview {
    
    [super didMoveToSuperview];
    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay: kYJMessageShowAnimationDuration + self.duration];
}
#pragma mark - private method



- (void)dismiss {
    
    CGFloat distance = self.frame.size.height + kYJMessageViewMarginBottom;
    __weak __typeof(self) wself = self;
    [UIView animateWithDuration:kYJMessageShowAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                              | UIViewAnimationOptionBeginFromCurrentState
                              | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                      
                         CGRect frame = self.frame;
                         frame.origin.y += distance;
                         wself.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         
                         [wself removeFromSuperview];
                     }];
}

- (void)buttonTouched {
    
    if (self.buttonCallback) {
        
        self.buttonCallback();
        [self dismiss];
    }
}

- (UIImage *)iconImageForType:(YJMessageType)type {
    
    NSString *iconName;
    
    switch (type) {
        case YJMessageTypeError:
            
            iconName = @"yjmessage_error";
            break;
        case YJMessageTypeInfo:
            
            iconName = @"yjmessage_info";
            break;
        case YJMessageTypeSuccess:
            
            iconName = @"yjmessage_success";
            break;
        case YJMessageTypeWarning:
            
            iconName = @"yjmessage_warning";
            break;
    }
    
    NSString *path = [[NSBundle bundleForClass: self.class] pathForResource:iconName ofType:@"png"];
    return [UIImage imageWithContentsOfFile: path];
}

- (UIColor *)backgroundColorForType:(YJMessageType)type {
    
    switch (type) {
            
        case YJMessageTypeError:
            
            return UIColorFromRGB(0xE64D43);
        case YJMessageTypeSuccess:
            
            return UIColorFromRGB(0x28BA9C);
        case YJMessageTypeInfo:
            
            return UIColorFromRGB(0x3B99DB);
        case YJMessageTypeWarning:
            
            return UIColorFromRGB(0xF19B2C);
    }
}

- (UIColor *)buttonBackgroundColorForType:(YJMessageType)type {
    
    switch (type) {
            
        case YJMessageTypeError:
            
            return UIColorFromRGB(0xE85E55);
        case YJMessageTypeInfo:
            
            return UIColorFromRGB(0x4EA3DB);
        case YJMessageTypeSuccess:
            
            return UIColorFromRGB(0x2EC3A5);
        case YJMessageTypeWarning:
            
            return UIColorFromRGB(0xF2A440);
    }
}
#pragma mark - accessor

- (UIView *)containerView {

    if (!_containerView) {
        
        _containerView = [[UIView alloc] initWithFrame: self.bounds];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 4.0;
    }
    return _containerView;
}


@end
