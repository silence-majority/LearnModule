//
//  BaseViewController.m
//  xiaoqishen
//
//  Created by 金泉斌 on 2017/6/24.
//  Copyright © 2017年 xiaoyuxiaoyu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *leftItem;
@property (strong, nonatomic) UIView *rightItem;

@end

@implementation BaseViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.automaticallyAdjustsScrollViewInsets = false;
    [self makeNavigationBar];
    [self makeBackBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        self.tabBarController.tabBar.hidden = YES;
    } else {
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

#pragma mark - Setter
- (void)setNavigationBarColor:(UIColor *)color {
    self.navigationBar.backgroundColor = color;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    self.titleLabel.text = title;
}

- (void)setAttributeTitle:(NSAttributedString *)aTitle {
    self.titleLabel.attributedText = aTitle;
}

- (void)setNavigationBarRightItem:(UIView *)item {
    if (self.rightItem) [self.rightItem removeFromSuperview];
    self.rightItem = item;
    CGSize size = item.bounds.size;
    [self.navigationBar addSubview:item];
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.navigationBar.mas_trailing).offset(-10);
        make.centerY.equalTo(self.navigationBar).offset(10);
        make.size.mas_equalTo(size);
    }];
}

- (void)setNavigationBarLeftItem:(UIView *)item {
    if (self.leftItem) [self.leftItem removeFromSuperview];
    self.leftItem = item;
    CGSize size = item.bounds.size;
    [self.navigationBar addSubview:item];
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.navigationBar.mas_leading).offset(10);
        make.centerY.equalTo(self.navigationBar).offset(10);
        make.size.mas_equalTo(size);
    }];
}

- (void)setBackItem:(UIView *)item {
    CGSize size = item.bounds.size;
    [self.navigationBar addSubview:item];
    [item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.navigationBar.mas_leading).offset(10);
        make.centerY.equalTo(self.navigationBar).offset(10);
        make.size.mas_equalTo(size);
    }];
}

#pragma mark - Private

- (void)makeNavigationBar {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 64)];
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navigationBar];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 64);
    CGPathAddLineToPoint(path, nil, width, 64);
    
    CAShapeLayer *bottomLine = [CAShapeLayer layer];
    bottomLine.path = path;
    bottomLine.strokeColor = XY_FontColor5.CGColor;
    bottomLine.lineWidth = 0.5 / [UIScreen mainScreen].scale;
    [self.navigationBar.layer addSublayer:bottomLine];
    
    CGPathRelease(path);
}

- (void)makeBackBtn {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self setNavigationBarLeftItem:backBtn];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        [self.navigationBar addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navigationBar.mas_top).offset(20);
            make.centerX.equalTo(self.navigationBar);
            make.height.mas_equalTo(44.0f);
        }];
        _titleLabel.textColor = XY_FontColor1;
        _titleLabel.font = XY_HelveticaFont1;
    }
    return _titleLabel;
}

- (void)back:(UIButton *)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
