//
//  XQSAsyncLayer.h
//  Pods
//
//  Created by 傅浪 on 2017/7/21.
//
//

#import <QuartzCore/QuartzCore.h>

typedef BOOL (^CancelBlock)();

@class XQSAsyncLayer;
@protocol XQSAsyncLayerDelegate <NSObject>

@optional
- (void)asyncLayerWillDisplay:(XQSAsyncLayer *)layer;

- (void)asyncLayer:(XQSAsyncLayer *)layer
         displayIn:(CGContextRef)context
              size:(CGSize)size
        isCanceled:(CancelBlock)isCanceled;

- (void)asyncLayer:(XQSAsyncLayer *)layer didDisplay:(BOOL)finished;

@end

typedef void (^XQSAsyncLayerDisplayBlock)(CGContextRef context, CGSize size, CancelBlock isCanceled);

@interface XQSAsyncLayer : CALayer
// 用于异步绘制的队列
@property (nonatomic,assign) dispatch_queue_t dispatchDrawQueue;
// 用于自定义绘制内容的block
@property (nonatomic,copy) XQSAsyncLayerDisplayBlock displayBlock;
// 代理
@property (nonatomic,weak) id<XQSAsyncLayerDelegate> displayDelegate;

@end
