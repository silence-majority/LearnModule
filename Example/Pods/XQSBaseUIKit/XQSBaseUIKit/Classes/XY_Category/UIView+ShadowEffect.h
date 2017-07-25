//
//  UIView+ShadowEffect.h
//  xiaoqishen
//
//  Created by 金泉斌 on 2017/6/30.
//  Copyright © 2017年 xiaoyuxiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ShadowEffect)

- (void)commonShadowWithSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius;

- (void)makeShadowWithSize:(CGSize)size shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius color:(UIColor *)color opacity:(CGFloat)opacity;

@end
