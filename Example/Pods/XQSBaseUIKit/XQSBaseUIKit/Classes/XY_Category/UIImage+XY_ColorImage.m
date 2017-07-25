//
//  UIImage+XY_ColorImage.m
//  xiaoqishen
//
//  Created by 金泉斌 on 2017/6/26.
//  Copyright © 2017年 xiaoyuxiaoyu. All rights reserved.
//

#import "UIImage+XY_ColorImage.h"

@implementation UIImage (XY_ColorImage)

+ (UIImage *)xy_imageWithColor:(UIColor *)color size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    
    CGFloat radius = size.height / 2;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(radius, 0)];
    [path addLineToPoint:CGPointMake(size.width - radius, 0)];
    [path addArcWithCenter:CGPointMake(size.width - radius, radius) radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(radius, size.height)];
    [path addArcWithCenter:CGPointMake(radius, radius) radius:radius startAngle:M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    [path closePath];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextFillPath(ctx);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)xy_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                   borderColor:(UIColor *)borderColor
                    borderWith:(CGFloat)borderWith
                        radius:(CGFloat)radius {
    UIGraphicsBeginImageContext(size);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height)
                                                    cornerRadius:radius];
    [path setLineWidth:borderWith];
    [color setFill];
    [borderColor setStroke];
    [path stroke];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
