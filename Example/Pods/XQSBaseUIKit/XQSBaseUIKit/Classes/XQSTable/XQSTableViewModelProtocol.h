//
//  XQSTableSectionModel.h
//  Pods
//
//  Created by 傅浪 on 2017/7/20.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol XQSCellModelProtocol;

@protocol XQSTableSectionModel <NSObject>

@property (nonatomic,copy) NSArray<id<XQSCellModelProtocol>> *cellModels;

@optional

- (NSString *)titleForHeader;
- (NSString *)titleForFooter;

- (CGFloat)heightOfHeader;
- (CGFloat)heightOfFooter;
- (UIView *)headerView;
- (UIView *)footerView;
@end



typedef void(^CellSelectedAction)(id<XQSCellModelProtocol>, NSIndexPath *);

@protocol XQSCellModelProtocol <NSObject>
// 原始数据
@property (nonatomic,strong) id data;
// 复用标识
@property (nonatomic,copy) NSString *cellIdentifier;

@optional
// 点击cell时响应的target
@property (nonatomic,weak) id target;
// 点击cell时响应的方法， 参数列表同CellSelectedAction
@property (nonatomic,assign) SEL selector;
// 点击cell时可执行的回调
@property (nonatomic,copy) CellSelectedAction action;
// cell的类名
@property (nonatomic,copy) NSString *cellClassName;

- (CGFloat)cellHeight;

@required
- (UITableViewCell *)cellForTableView:(UITableView *)tableView;

@end


@protocol XQSTableViewCellProtocol <NSObject>

+ (CGFloat)cellHeightForData:(id)data;

- (void)refresh:(id)data;

@end

