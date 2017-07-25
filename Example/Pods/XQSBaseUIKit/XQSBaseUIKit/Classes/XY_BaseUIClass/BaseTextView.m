//
//  BaseTextView.m
//  Pods
//
//  Created by 金泉斌 on 2017/7/6.
//
//

#import "BaseTextView.h"
#import <Masonry/Masonry.h>
#import "XYUIKitMacro.h"

@interface BaseTextView ()

@property (strong, nonatomic) UILabel *placeholderLbl;

@end

@implementation BaseTextView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self j_addObserver];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self j_addObserver];
    }
    return self;
}

- (void)j_addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textValueChanged) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)textValueChanged {
    self.placeholderLbl.hidden = self.text.length > 0? YES : NO;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeholderLbl.text = placeholder;
}

- (UILabel *)placeholderLbl {
    if (!_placeholderLbl) {
        _placeholderLbl = [UILabel new];
        [self addSubview:_placeholderLbl];
        [_placeholderLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.offset(5);
            make.width.equalTo(self).offset(-10);
            make.top.offset(7);
        }];
        _placeholderLbl.font = XY_SystemFont4;
        _placeholderLbl.textColor = XY_FontColor4;
        _placeholderLbl.textAlignment = NSTextAlignmentLeft;
        _placeholderLbl.numberOfLines = 0;
    }
    return _placeholderLbl;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
