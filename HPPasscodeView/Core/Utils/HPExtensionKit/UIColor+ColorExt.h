//
//  UIColor+ColorKit.h
//  LittleBook
//
//  Created by 胡鹏 on 15/3/7.
//  Copyright (c) 2015年 hupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorExt)

+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue a:(CGFloat)alpha;

+ (UIColor *)iR:(int)r g:(int)g b:(int)b;

+ (UIColor *)iR:(int)r g:(int)g b:(int)b a:(CGFloat)a;

+ (UIColor *)fR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;

+ (UIColor *)fR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;

+ (UIColor *)hex:(NSString *)hex;

+ (UIColor *)hex:(NSString *)hex alpha:(CGFloat)alpha;
@end
