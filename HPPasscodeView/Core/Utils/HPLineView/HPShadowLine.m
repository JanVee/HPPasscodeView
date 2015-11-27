//
//  HPShadowLine.m
//  ILSPrivatePhoto
//
//  Created by hupeng on 15/4/14.
//  Copyright (c) 2015年 iLegendSoft. All rights reserved.
//

#import "HPShadowLine.h"

@implementation HPShadowLine

+(instancetype)verticalLineWithHeight:(float)height
{
    HPShadowLine *line = [[HPShadowLine alloc] initWithFrame:CGRectMake(0, 0, 1.0/[UIScreen mainScreen].scale, height)];
    return line;
}

+(instancetype)horizontalLineWithWidth:(float)width
{
    HPShadowLine *line = [[HPShadowLine alloc] initWithFrame:CGRectMake(0, 0, width, 1.0/[UIScreen mainScreen].scale)];
    return line;
}

- (void)awakeFromNib
{
    float w  = CGRectGetWidth(self.bounds);
    float h  = CGRectGetHeight(self.bounds);
    float oX = CGRectGetMinX(self.frame);
    float oY = CGRectGetMinY(self.frame);
    if (w > h) {
        self.frame = CGRectMake(oX, oY, w, 1.0/[UIScreen mainScreen].scale);
    } else {
        self.frame = CGRectMake(oX, oY, 1.0/[UIScreen mainScreen].scale, h);
    }
    
    [self applyShadow];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self applyShadow];
    }
    return self;
}

- (void)applyShadow
{
//    self.layer.shadowColor = [UIColor colorWithR:<#(CGFloat)#> g:<#(CGFloat)#> b:<#(CGFloat)#> a:<#(CGFloat)#>]
}
@end
