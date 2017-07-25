//
//  XQSDefaultSectionModel.h
//  Pods
//
//  Created by 傅浪 on 2017/7/20.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XQSTableViewModelProtocol.h"

@interface XQSDefaultSectionModel : NSObject<XQSTableSectionModel>

@property (nonatomic,copy) NSArray<id<XQSCellModelProtocol>> *cellModels;

@property (nonatomic,assign) CGFloat heightOfHeader;
@property (nonatomic,assign) CGFloat heightOfFooter;

@property (nonatomic,copy) NSString *titleForHeader;
@property (nonatomic,copy) NSString *titleForFooter;

@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *footerView;

- (instancetype)initWithCellModels:(NSArray<id<XQSCellModelProtocol>> *)cellModels;

@end
