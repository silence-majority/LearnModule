//
//  NSString+XY_StringFilter.h
//  xiaoqishen
//
//  Created by 金泉斌 on 2017/6/27.
//  Copyright © 2017年 xiaoyuxiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XY_StringFilter)

/**
 * 是否包含emoji
 */
- (BOOL)isContainsEmoji;

/**
 * 是否为6-16位的字母或数字
 */
- (BOOL)isValidPassword;

/**
 *  校验手机号码格式
 */
- (BOOL)isMobile;

/**
 *  校验名字(2-10个中文字)
 */
- (BOOL)isValidName;


@end
