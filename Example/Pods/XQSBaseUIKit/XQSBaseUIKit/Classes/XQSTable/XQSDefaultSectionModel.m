//
//  XQSDefaultSectionModel.m
//  Pods
//
//  Created by 傅浪 on 2017/7/20.
//
//

#import "XQSDefaultSectionModel.h"

@implementation XQSDefaultSectionModel

- (instancetype)initWithCellModels:(NSArray<id<XQSCellModelProtocol>> *)cellModels {
    self = [super init];
    if (self) {
        _cellModels     = cellModels ? [cellModels copy] : @[];
        _heightOfHeader = 10.f;
        _heightOfFooter = 0.01f;
        
        _titleForHeader = nil;
        _titleForFooter = nil;
        
        _headerView     = nil;
        _footerView     = nil;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _cellModels     = @[];
        _heightOfHeader = 10.f;
        _heightOfFooter = 0.01f;
        
        _titleForHeader = nil;
        _titleForFooter = nil;
        
        _headerView     = nil;
        _footerView     = nil;
    }
    return self;
}

@end
