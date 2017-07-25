//
//  NSTimer+BlockTimer.m
//  xiaoqishen
//
//  Created by 金泉斌 on 2017/6/30.
//  Copyright © 2017年 xiaoyuxiaoyu. All rights reserved.
//

#import "NSTimer+BlockTimer.h"
#import <objc/runtime.h>

static NSString *const fireBlock = @"xy_timer_fire_block";

@implementation NSTimer (BlockTimer)

+ (NSTimer *)xy_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer * _Nonnull))block {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(xy_timerFire:) userInfo:nil repeats:repeats];
    objc_setAssociatedObject(timer, &fireBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return timer;
}

+ (void)xy_timerFire:(NSTimer *)timer {
    void (^block)(NSTimer * _Nonnull) = objc_getAssociatedObject(timer, &fireBlock);
    if (block) {
        block(timer);
    }
}

@end
