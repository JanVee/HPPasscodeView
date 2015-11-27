//
//  UIColor+ColorKit.m
//  LittleBook
//
//  Created by 胡鹏 on 15/3/7.
//  Copyright (c) 2015年 hupeng. All rights reserved.
//

#import "UIColor+ColorExt.h"

@implementation UIColor (ColorExt)

+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue a:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor *)iR:(int)r g:(int)g b:(int)b {
    return [UIColor iR:r g:g b:b a:1];
}

+ (UIColor *)iR:(int)r g:(int)g b:(int)b a:(CGFloat)a {
    return [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:a];
}

+ (UIColor *)fR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b {
    return [UIColor fR:r g:g b:b a:1];
}

+ (UIColor *)fR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a {
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

+ (UIColor *)hex:(NSString *)hex {
    return [UIColor hex:hex alpha:1.f];
}

+ (UIColor *)hex:(NSString *)hex alpha:(CGFloat)alpha {
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
@end
