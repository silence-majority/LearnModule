//
//  XQSDefaultTableViewDelegator.m
//  Pods
//
//  Created by 傅浪 on 2017/7/20.
//
//

#import "XQSDefaultTableViewDelegator.h"
#import "XQSTableViewModelProtocol.h"

@implementation XQSDefaultTableViewDelegator

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<XQSTableSectionModel> sectionModel = self.sections[section];
    return sectionModel.cellModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<XQSCellModelProtocol> cellModel = [self cellModelAtIndexPath:indexPath];
    return [cellModel cellForTableView:tableView];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id<XQSTableSectionModel> sectionModel = self.sections[section];
    if ([sectionModel respondsToSelector:@selector(titleForHeader)]) {
        return [sectionModel titleForHeader];
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    id<XQSTableSectionModel> sectionModel = self.sections[section];
    if ([sectionModel respondsToSelector:@selector(titleForFooter)]) {
        return [sectionModel titleForFooter];
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id<XQSCellModelProtocol> cellModel = [self cellModelAtIndexPath:indexPath];
    if ([cellModel.target respondsToSelector:cellModel.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [cellModel.target performSelector:cellModel.selector
                               withObject:cellModel
                               withObject:indexPath];
#pragma clang diagnostic pop
    }
    if (cellModel.action) {
        cellModel.action(cellModel, indexPath);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<XQSCellModelProtocol> cellModel = [self cellModelAtIndexPath:indexPath];
    if ([cellModel respondsToSelector:@selector(cellHeight)]) {
        return [cellModel cellHeight];
    }
    return 40.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id<XQSTableSectionModel> sectionModel = self.sections[section];
    if ([sectionModel respondsToSelector:@selector(heightOfHeader)]) {
        return [sectionModel heightOfHeader];
    }
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    id<XQSTableSectionModel> sectionModel = self.sections[section];
    if ([sectionModel respondsToSelector:@selector(heightOfFooter)]) {
        return [sectionModel heightOfFooter];
    }
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id<XQSTableSectionModel> sectionModel = self.sections[section];
    if ([sectionModel respondsToSelector:@selector(headerView)]) {
        return [sectionModel headerView];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    id<XQSTableSectionModel> sectionModel = self.sections[section];
    if ([sectionModel respondsToSelector:@selector(footerView)]) {
        return [sectionModel footerView];
    }
    return nil;
}

#pragma mark - Accessor
- (id<XQSCellModelProtocol>)cellModelAtIndexPath:(NSIndexPath *)indexpath {
    id<XQSTableSectionModel> sectionModel = self.sections[indexpath.section];
    return sectionModel.cellModels[indexpath.row];
}

- (NSArray<id<XQSTableSectionModel>> *)sections {
    if (_sections == nil) {
        _sections = @[];
    }
    return _sections;
}
@end
