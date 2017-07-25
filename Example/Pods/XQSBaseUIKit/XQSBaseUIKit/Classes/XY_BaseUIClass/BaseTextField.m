//
//  BaseTextField.m
//  xiaoqishen
//
//  Created by 金泉斌 on 2017/6/29.
//  Copyright © 2017年 xiaoyuxiaoyu. All rights reserved.
//

#import "BaseTextField.h"
#import "XYUIKitMacro.h"

@implementation BaseTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textColor = XY_FontColor2;
        self.tintColor = XY_OrangeColor;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
