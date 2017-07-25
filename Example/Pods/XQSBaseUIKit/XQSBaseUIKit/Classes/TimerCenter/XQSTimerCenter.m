//
//  XQSTimerCenter.m
//  Pods
//
//  Created by 傅浪 on 2017/7/24.
//
//

#import "XQSTimerCenter.h"

@interface XQSTimerItem ()

@property (nonatomic,assign,readonly) NSTimeInterval timeInterval;

@property (nonatomic,copy) XQSTimerAction action;

@property (nonatomic,weak) id target;

@property (nonatomic,assign) SEL selector;

@property (nonatomic,assign,readonly,getter=isRepeats) BOOL repeats;

@property (nonatomic,assign,getter=isExcuted) BOOL excuted;

- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval
                             repeats:(BOOL)repeats
                               block:(XQSTimerAction)action;

- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval
                              target:(id)target
                            selector:(SEL)selector
                             repeats:(BOOL)repeats;

@end

typedef NSMutableSet<XQSTimerItem *>  XQSTimerItemSet;

@interface XQSTimerCenter ()

@property (nonatomic,strong) NSMutableDictionary<NSString *, NSTimer *> *timers;

@property (nonatomic,strong) NSMutableDictionary<NSString*, XQSTimerItemSet *> *items;

@property (nonatomic,strong) NSLock *lock;

@end

@implementation XQSTimerCenter

+ (instancetype)sharedTimerCenter {
    static XQSTimerCenter *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[XQSTimerCenter alloc] init];
    });
    return _instance;
}

- (XQSTimerItem *)addTimerObserverWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats block:(XQSTimerAction)block {
    XQSTimerItem *item = [[XQSTimerItem alloc] initWithTimeInterval:timeInterval repeats:repeats block:block];
    XQSTimerItemSet *itemSet = [self itemSetForTimeInterval:timeInterval];
    [self.lock lock];
    [itemSet addObject:item];
    [self.lock unlock];
    [self timerForTimeInterval:timeInterval];
    return item;
}

- (XQSTimerItem *)addTimerObserverWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector repeats:(BOOL)repeats {
    XQSTimerItem *item = [[XQSTimerItem alloc] initWithTimeInterval:timeInterval target:target selector:selector repeats:repeats];
    XQSTimerItemSet *itemSet = [self itemSetForTimeInterval:timeInterval];
    [self.lock lock];
    [itemSet addObject:item];
    [self.lock unlock];
    [self timerForTimeInterval:timeInterval];
    return item;
}


- (void)removeTimerObserver:(XQSTimerItem *)item {
    XQSTimerItemSet *itemSet = [self itemSetForTimeInterval:item.timeInterval];
    [self.lock lock];
    if ([itemSet containsObject:item]) {
        [itemSet removeObject:item];
    }
    [self.lock unlock];
}

- (void)removeAllTimerObserverForTimeInterval:(NSTimeInterval)timeInterval {
    XQSTimerItemSet *itemSet = [self itemSetForTimeInterval:timeInterval];
    [self.lock lock];
    [itemSet removeAllObjects];
    [self.items removeObjectForKey:@(timeInterval).stringValue];
    [self.lock unlock];
}

- (void)removeAllTimer {
    [self.lock lock];
    [self.timers.allValues enumerateObjectsUsingBlock:^(NSTimer * _Nonnull timer, NSUInteger idx, BOOL * _Nonnull stop) {
        [timer invalidate];
    }];
    [self.timers removeAllObjects];
    [self.items removeAllObjects];
    [self.lock unlock];
}

#pragma mark - Action
- (void)timerAction:(NSTimer *)timer {
    XQSTimerItemSet *itemSet = [self itemSetForTimeInterval:timer.timeInterval];
    NSSet<XQSTimerItem *> *tempSet = [itemSet copy];
    [tempSet enumerateObjectsUsingBlock:^(XQSTimerItem * _Nonnull item, BOOL * _Nonnull stop) {
        !item.action?:item.action(timer);
        if ([item.target respondsToSelector:item.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [item.target performSelector:item.selector withObject:timer];
#pragma clang diagnostic pop
        }
        [self.lock lock];
        item.excuted = YES;
        if (!item.isRepeats && item.isExcuted) {
            [itemSet removeObject:item];
        }
        [self.lock unlock];
    }];

    [self.lock lock];
    if (itemSet.count == 0) {
        [timer invalidate];
        [self.timers removeObjectForKey:@(timer.timeInterval).stringValue];
    }
    [self.lock unlock];
}

#pragma mark - Accessor

- (XQSTimerItemSet *)itemSetForTimeInterval:(NSTimeInterval)timeInterval {
    NSString *identifier = @(timeInterval).stringValue;
    [self.lock lock];
    XQSTimerItemSet *itemSet = [self.items objectForKey:identifier];
    if (!itemSet) {
        itemSet = [[NSMutableSet alloc] init];
        [self.items setObject:itemSet forKey:identifier];
    }
    [self.lock unlock];
    return itemSet;
}

- (NSTimer *)timerForTimeInterval:(NSTimeInterval)timeInterval {
    NSString *identifier = @(timeInterval).stringValue;
    [self.lock lock];
    NSTimer *timer = [self.timers objectForKey:identifier];
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [self.timers setObject:timer forKey:identifier];
        NSLog(@"已添加的timer数量：%@ - %ld", identifier, self.timers.count);
    }
    [self.lock unlock];
    return timer;
}


- (NSMutableDictionary<NSString *,NSTimer *> *)timers {
    if (_timers == nil) {
        _timers = @{}.mutableCopy;
    }
    return _timers;
}

- (NSMutableDictionary<NSString *,XQSTimerItemSet *> *)items {
    if (_items == nil) {
        _items = @{}.mutableCopy;
    }
    return _items;
}

- (NSLock *)lock {
    if (_lock == nil) {
        _lock = [[NSLock alloc] init];
    }
    return _lock;
}

@end



@implementation XQSTimerItem

- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)repeats block:(XQSTimerAction)action {
    self = [super init];
    if (self) {
        _timeInterval   = timeInterval;
        _repeats        = repeats;
        _action         = action;
        _excuted        = NO;
    }
    return self;
}

- (instancetype)initWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector repeats:(BOOL)repeats {
    self = [super init];
    if (self) {
        _timeInterval   = timeInterval;
        _target         = target;
        _selector       = selector;
        _repeats        = repeats;
        _excuted        = NO;
    }
    return self;
}

- (void)removeObserver {
    [[XQSTimerCenter sharedTimerCenter] removeTimerObserver:self];
}

@end
