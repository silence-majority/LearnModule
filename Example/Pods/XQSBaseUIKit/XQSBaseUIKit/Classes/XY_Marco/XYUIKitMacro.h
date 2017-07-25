//
//  XYUIKitMacro.h
//  xiaoqishen
//
//  Created by gaocheng on 2017/6/9.
//  Copyright © 2017年 xiaoyuxiaoyu. All rights reserved.
//

#ifndef XYUIKitMacro_h
#define XYUIKitMacro_h

#define XY_UIScreenWidth   [UIScreen mainScreen].bounds.size.width
#define XY_UIScreenHeight  [UIScreen mainScreen].bounds.size.height

#define IS_ON_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#pragma mark - Weak & Strong
#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif

#pragma mark - UIColor宏定义
#define XY_UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define XY_UIColorFromRGB(rgbValue) XY_UIColorFromRGBA(rgbValue, 1.0)

#define XY_MainColor                XY_UIColorFromRGB(0x35cbdb)
#define XY_BackgroundColor          XY_UIColorFromRGB(0xf8f8f8)
#define XY_SmallLineColoe           XY_UIColorFromRGB(0xcad0e5)

#define XY_LightBorderColor         XY_UIColorFromRGB(0xececec)
#define XY_DarkBorderColor          XY_UIColorFromRGB(0xcccccc)

#define XY_FontColor1               XY_UIColorFromRGB(0x333333)
#define XY_FontColor2               XY_UIColorFromRGB(0x666666)
#define XY_FontColor3               XY_UIColorFromRGB(0x999999)
#define XY_FontColor4               XY_UIColorFromRGB(0xbbbbbb)
#define XY_FontColor5               XY_UIColorFromRGB(0xcccccc)

#define XY_BlueColor                XY_UIColorFromRGB(0x0071fa)
#define XY_RedColor                 XY_UIColorFromRGB(0xf43530)
#define XY_YellowColor              XY_UIColorFromRGB(0xf5c415)
#define XY_GreenColor               XY_UIColorFromRGB(0x35bc01)
#define XY_OrangeColor              XY_UIColorFromRGB(0xffb457)

#pragma mark - 字体大小宏定义
#define XY_Font(size) [UIFont systemFontOfSize:size]
#define XY_HelveticaFont(font) [UIFont fontWithName:@"Helvetica-Bold" size:font]

#define XY_SystemFont1                XY_Font(17)
#define XY_SystemFont2                XY_Font(15)
#define XY_SystemFont3                XY_Font(14)
#define XY_SystemFont4                XY_Font(13)
#define XY_SystemFont5                XY_Font(12)
#define XY_SystemFont6                XY_Font(10)

#define XY_HelveticaFont1           XY_HelveticaFont(17)
#define XY_HelveticaFont2           XY_HelveticaFont(15)
#define XY_HelveticaFont3           XY_HelveticaFont(14)
#define XY_HelveticaFont4           XY_HelveticaFont(13)
#define XY_HelveticaFont5           XY_HelveticaFont(12)
#define XY_HelveticaFont6           XY_HelveticaFont(10)


#endif /* XYUIKitMacro_h */
