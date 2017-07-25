//
//  UIImage+XY_ColorImage.h
//  xiaoqishen
//
//  Created by 金泉斌 on 2017/6/26.
//  Copyright © 2017年 xiaoyuxiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XY_ColorImage)

+ (UIImage *)xy_imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)xy_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                   borderColor:(UIColor *)borderColor
                    borderWith:(CGFloat)borderWith
                        radius:(CGFloat)radius;
@end
