//
//  HPDotViewAppearance.m
//  ILSPrivatePhoto
//
//  Created by hupeng on 15/5/28.
//  Copyright (c) 2015年 iLegendSoft. All rights reserved.
//

#import "HPDotViewAppearance.h"
#import "UIColor+ColorExt.h"
#import "HPCommonMacro.h"


@implementation HPDotViewAppearance

+ (instancetype)appearance
{
    CREATE_SINGLETON_INSTANCE([[HPDotViewAppearance alloc] init]);
}

- (instancetype)init
{
    if (self = [super init]) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            _circleRadius = 32;
            _lineWidth    = 1.0;
            _space        = 30;
        } else {
            _circleRadius = 45;
            _lineWidth = 1;
            _space = 60;
        }
        
        _defaultColor  = [UIColor colorWithR:91 g:153 b:238 a:1.0];
        _selectedColor = [UIColor colorWithR:53 g:183 b:127 a:1.0];
        _errorColor    = [UIColor colorWithR:255 g:78 b:78 a:1.0];
        
        _selectedMsakColor = [UIColor colorWithR:53 g:183 b:127 a:0.3];
        _errorMaskColor    = [UIColor colorWithR:255 g:78 b:78 a:0.3];
    }
    return self;
}


@end
