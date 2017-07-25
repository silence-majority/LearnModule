//
//  XQSDefaultTableViewDelegator.h
//  Pods
//
//  Created by 傅浪 on 2017/7/20.
//
//

#import <Foundation/Foundation.h>

@protocol XQSTableSectionModel;
@interface XQSDefaultTableViewDelegator : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,copy) NSArray<id<XQSTableSectionModel>> *sections;

@end
