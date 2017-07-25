//
//  XQSAsyncLayer.m
//  Pods
//
//  Created by 傅浪 on 2017/7/21.
//
//

#import "XQSAsyncLayer.h"
#import <libkern/OSAtomic.h>

static dispatch_queue_t XQSAsyncLayerGetDisplayQueue() {
    static int queueCount;
    static dispatch_queue_t queues[16];
    static dispatch_once_t onceToken;
    static int32_t counter = 0;
    dispatch_once(&onceToken, ^{
        queueCount = (int)[NSProcessInfo processInfo].activeProcessorCount;
        queueCount = queueCount < 1 ? 1 : queueCount > 16 ? 16 : queueCount;
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            for (NSUInteger i = 0; i < queueCount; i++) {
                dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_USER_INITIATED, 0);
                queues[i] = dispatch_queue_create("com.xqs.render", attr);
            }
        }else {
            for (NSUInteger i = 0; i < queueCount; i++) {
                queues[i] = dispatch_queue_create("com.xqs.render", DISPATCH_QUEUE_SERIAL);
                dispatch_set_target_queue(queues[i], dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
            }
        }
    });
    int32_t cur = OSAtomicIncrement32(&counter);
    if (cur < 0) { cur = -cur; }
    return queues[(cur) % queueCount];
}





@interface Sentinel : NSObject

@property (readonly) int32_t value;

- (int32_t)increase;

@end


@implementation XQSAsyncLayer {
    Sentinel *_sentinel;
}

- (void)display {
    super.contents = super.contents;
    [self __displayAsync];
}

- (instancetype)init {
    self = [super init];
    static CGFloat scale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scale = [UIScreen mainScreen].scale;
    });
    self.contentsScale = scale;
    _sentinel = [Sentinel new];
    return self;
}

- (void)dealloc {
    [_sentinel increase];
}

- (void)setNeedsDisplay {
    [self __cancelDisplay];
    [super setNeedsDisplay];
}

#pragma mark - Private
- (void)__displayAsync {
    
    [self __willDisplay];
    // 没有需要绘制的内容
    if (!self.displayBlock && ![self.displayDelegate respondsToSelector:@selector(asyncLayer:displayIn:size:isCanceled:)]) {
        self.contents = nil;
        [self __didDisplay:YES];
        return;
    }
    // 创建用语判断是否取消绘制的block
    Sentinel *sentinel  = _sentinel;
    int32_t value       = sentinel.value;
    CancelBlock isCanceled = ^BOOL() {
        return value != sentinel.value;
    };
    // 预绘制背景需要的数据
    CGSize size     = self.bounds.size;
    BOOL opaque     = self.opaque;
    CGFloat scale   = self.contentsScale;
    CGColorRef backgroundColor = (opaque && self.backgroundColor) ? CGColorRetain(self.backgroundColor) : NULL;
    
    // 如果太小则不绘制了，直接清空
    if (size.width < 1 || size.height < 1) {
        CGImageRef image    = (__bridge_retained CGImageRef)self.contents;
        self.contents       = nil;
        if (image) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                CGImageRelease(image);
            });
        }
        [self __didDisplay:YES];
        CGColorRelease(backgroundColor);
        return;
    }
    
    // 开始绘制
    dispatch_queue_t renderQueue = _dispatchDrawQueue ? _dispatchDrawQueue : XQSAsyncLayerGetDisplayQueue();
    dispatch_async(renderQueue, ^{
        if (isCanceled()) {
            CGColorRelease(backgroundColor);
            return;
        }
        // 绘制背景
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (opaque) {
            CGContextSaveGState(context); {
                if (backgroundColor) {
                    CGContextSetFillColorWithColor(context, backgroundColor);
                }else {
                    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
                }
                CGContextAddRect(context, CGRectMake(0, 0, size.width * scale, size.height * scale));
                CGContextFillPath(context);
            } CGContextRestoreGState(context);
            CGColorRelease(backgroundColor);
        }
        // 调用自定义绘制
        __strong id<XQSAsyncLayerDelegate> delegate = self.displayDelegate;
        if ([delegate respondsToSelector:@selector(asyncLayer:displayIn:size:isCanceled:)]) {
            [delegate asyncLayer:self displayIn:context size:size isCanceled:isCanceled];
        }
        !self.displayBlock?:self.displayBlock(context, size, isCanceled);
        if (isCanceled()) {
            UIGraphicsEndImageContext();
            [self __didDisplay:NO];
            return;
        }
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if (isCanceled()) { [self __didDisplay:NO]; }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.contents = (__bridge id)image.CGImage;
            [self __didDisplay:YES];
        });
    });
}

- (void)__willDisplay {
    __strong id<XQSAsyncLayerDelegate> delegate = self.displayDelegate;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([delegate respondsToSelector:@selector(asyncLayerWillDisplay:)]) {
            [delegate asyncLayerWillDisplay:self];
        }
    });
}

- (void)__didDisplay:(BOOL)finished {
    __strong id<XQSAsyncLayerDelegate> delegate = self.displayDelegate;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([delegate respondsToSelector:@selector(asyncLayer:didDisplay:)]) {
            [delegate asyncLayer:self didDisplay:finished];
        }
    });
}

- (void)__cancelDisplay {
    [_sentinel increase];
}

@end



@implementation Sentinel

- (int32_t)increase {
    return OSAtomicIncrement32(&_value);
}

@end
