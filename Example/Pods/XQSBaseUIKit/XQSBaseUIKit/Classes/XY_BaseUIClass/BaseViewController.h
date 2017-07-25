//
//  BaseViewController.h
//  xiaoqishen
//
//  Created by 金泉斌 on 2017/6/24.
//  Copyright © 2017年 xiaoyuxiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "XYUIKitMacro.h"

@interface BaseViewController : UIViewController

@property (strong, nonatomic) UIView *navigationBar;

- (void)setNavigationBarColor:(UIColor *)color;

/**
 * setTitle: for normal title
 */
- (void)setAttributeTitle:(NSAttributedString *)aTitle;

- (void)setNavigationBarRightItem:(UIView *)item;

- (void)setNavigationBarLeftItem:(UIView *)item;

@end
