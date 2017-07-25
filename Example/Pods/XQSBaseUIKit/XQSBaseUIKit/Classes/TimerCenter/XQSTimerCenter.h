//
//  XQSTimerCenter.h
//  Pods
//
//  Created by 傅浪 on 2017/7/24.
//
//

#import <Foundation/Foundation.h>
// 监听器回调函数类型
typedef void (^XQSTimerAction)(NSTimer *timer);

@interface XQSTimerItem : NSObject
// 移除此item对应的监听器
- (void)removeObserver;

@end


@interface XQSTimerCenter : NSObject

+ (instancetype)sharedTimerCenter;
// 通过block回调的方式添加监听器
- (XQSTimerItem *)addTimerObserverWithTimeInterval:(NSTimeInterval)timeInterval
                                 repeats:(BOOL)repeats
                                   block:(XQSTimerAction)block;
// 通过Target-Action的方式添加监听器
- (XQSTimerItem *)addTimerObserverWithTimeInterval:(NSTimeInterval)timeInterval
                                            target:(id)target
                                          selector:(SEL)selector
                                           repeats:(BOOL)repeats;
// 移除item对应的监听器
- (void)removeTimerObserver:(XQSTimerItem *)item;
// 移除某个频率的所有监听器，也会停止对应的计时器
- (void)removeAllTimerObserverForTimeInterval:(NSTimeInterval)timeInterval;
// 停止所有计时器
- (void)removeAllTimer;

@end
