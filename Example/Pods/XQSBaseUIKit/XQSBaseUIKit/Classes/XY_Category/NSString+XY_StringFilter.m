//
//  NSString+XY_StringFilter.m
//  xiaoqishen
//
//  Created by 金泉斌 on 2017/6/27.
//  Copyright © 2017年 xiaoyuxiaoyu. All rights reserved.
//

#import "NSString+XY_StringFilter.h"

@implementation NSString (XY_StringFilter)

- (BOOL)isContainsEmoji
{
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              // surrogate pair
                              if (0xd800 <= hs && hs <= 0xdbff)
                              {
                                  if (substring.length > 1)
                                  {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f918)
                                      {
                                          returnValue = YES;
                                      }
                                  }
                              }
                              else if (substring.length > 1)
                              {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3 || ls == 0xFE0F || ls == 0xd83c)
                                  {
                                      returnValue = YES;
                                  }
                              }
                              else
                              {
                                  // non surrogate
                                  if (0x2100 <= hs && hs <= 0x27ff)
                                  {
                                      if (0x278b <= hs && 0x2792 >= hs)
                                      {
                                          returnValue = NO;
                                      }
                                      else
                                      {
                                          returnValue = YES;
                                      }
                                  }
                                  else if (0x2B05 <= hs && hs <= 0x2b07)
                                  {
                                      returnValue = YES;
                                  }
                                  else if (0x2934 <= hs && hs <= 0x2935)
                                  {
                                      returnValue = YES;
                                  }
                                  else if (0x3297 <= hs && hs <= 0x3299)
                                  {
                                      returnValue = YES;
                                  }
                                  else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50 || hs == 0xd83e)
                                  {
                                      returnValue = YES;
                                  }
                              }
                          }];
    return returnValue;
}

-(BOOL) isMobile{
    static NSPredicate *mobilePredicate;
    if (!mobilePredicate) {
        mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(\\d){11}$"];
    }
    
    return [mobilePredicate evaluateWithObject:self];
}

-(BOOL) isValidName{
    static NSPredicate *namePredicate;
    if (!namePredicate) {
        namePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[\u4E00-\u9FA5]{2,6}$"];
    }
    return [namePredicate evaluateWithObject:self];
}

- (BOOL)isValidPassword{
    static NSPredicate *namePredicate;
    if (!namePredicate) {
        namePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[a-zA-Z0-9]{6,16}$"];
    }
    return [namePredicate evaluateWithObject:self];
}

@end
