//
//  NSTimer+BlockTimer.h
//  xiaoqishen
//
//  Created by 金泉斌 on 2017/6/30.
//  Copyright © 2017年 xiaoyuxiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (BlockTimer)

+ (NSTimer *)xy_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *))block;

@end
