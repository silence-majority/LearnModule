//
//  UIView+ShadowEffect.m
//  xiaoqishen
//
//  Created by 金泉斌 on 2017/6/30.
//  Copyright © 2017年 xiaoyuxiaoyu. All rights reserved.
//

#import "UIView+ShadowEffect.h"
#import "XYUIKitMacro.h"

@implementation UIView (ShadowEffect)

- (void)commonShadowWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    [self makeShadowWithSize:size shadowRadius:6 cornerRadius:cornerRadius color:XY_FontColor4 opacity:0.4];
}

- (void)makeShadowWithSize:(CGSize)size shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius color:(UIColor *)color opacity:(CGFloat)opacity {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(cornerRadius, 0)];
    [path addLineToPoint:CGPointMake(size.width - cornerRadius, 0)];
    [path addArcWithCenter:CGPointMake(size.width - cornerRadius, cornerRadius) radius:cornerRadius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    [path addLineToPoint:CGPointMake(size.width, size.height - cornerRadius)];
    [path addArcWithCenter:CGPointMake(size.width - cornerRadius, size.height - cornerRadius) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(cornerRadius, size.height)];
    [path addArcWithCenter:CGPointMake(cornerRadius, size.height - cornerRadius) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(0, cornerRadius)];
    [path addArcWithCenter:CGPointMake(cornerRadius, cornerRadius) radius:cornerRadius startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    [path closePath];
    
    self.layer.shadowPath = path.CGPath;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOpacity = opacity;
    self.layer.cornerRadius = cornerRadius;
}

@end
