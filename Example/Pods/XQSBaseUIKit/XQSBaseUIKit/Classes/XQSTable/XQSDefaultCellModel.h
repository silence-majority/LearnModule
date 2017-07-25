//
//  XQSDefaultCellModel.h
//  Pods
//
//  Created by 傅浪 on 2017/7/20.
//
//

#import <Foundation/Foundation.h>
#import "XQSTableViewModelProtocol.h"

@interface XQSDefaultCellModel : NSObject<XQSCellModelProtocol>
// 复用标识
@property (nonatomic,copy) NSString *           cellIdentifier;
// cell的类名
@property (nonatomic,copy) NSString *           cellClassName;
// 原始数据
@property (nonatomic,strong) id                 data;
// 点击cell时响应的target
@property (nonatomic,weak) id                   target;
// 点击cell时响应的方法
@property (nonatomic,assign) SEL                selector;
// 点击cell时可执行的回调
@property (nonatomic,copy) CellSelectedAction   action;
// 行高
@property (nonatomic,assign) CGFloat            cellHeight;

- (instancetype)initWithData:(id)data cellIdentifier:(NSString *)identifier;

@end
