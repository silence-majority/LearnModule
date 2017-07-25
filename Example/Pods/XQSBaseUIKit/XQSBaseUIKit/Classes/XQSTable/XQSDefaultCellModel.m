//
//  XQSDefaultCellModel.m
//  Pods
//
//  Created by 傅浪 on 2017/7/20.
//
//

#import "XQSDefaultCellModel.h"

@implementation XQSDefaultCellModel

- (instancetype)initWithData:(id)data cellIdentifier:(NSString *)identifier {
    self = [super init];
    if (self) {
        _data = data;
        _cellIdentifier = identifier;
        _cellHeight = 0;
    }
    return self;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (!cell) {
        if (self.cellClassName) {
            Class cellClass = NSClassFromString(self.cellClassName);
            cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleValue1
                                    reuseIdentifier:self.cellIdentifier];
        }else {
            return nil;
        }
    }
    if ([cell conformsToProtocol:@protocol(XQSTableViewCellProtocol)]) {
        [(id<XQSTableViewCellProtocol>)cell refresh:self.data];
    }
    return cell;
}

- (CGFloat)cellHeight {
    if (_cellHeight == 0) {
        Class cellClass = NSClassFromString(self.cellClassName);
        if ([cellClass conformsToProtocol:@protocol(XQSTableViewCellProtocol) ]) {
            _cellHeight = [cellClass cellHeightForData:self.data];
        }else {
            _cellHeight = 40.f;
        }
    }
    
    return _cellHeight;
}

- (void)setCellClassName:(NSString *)cellClassName {
    _cellClassName = [cellClassName copy];
    [self cellHeight];
}

@end
