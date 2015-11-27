//
//  HPDotViewAppearance.h
//  ILSPrivatePhoto
//
//  Created by hupeng on 15/5/28.
//  Copyright (c) 2015年 iLegendSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HPDotViewAppearance : NSObject

+ (instancetype)appearance;

@property (nonatomic, assign) int space;

@property (nonatomic, assign) int circleRadius;
@property (nonatomic, assign) int lineWidth;

@property (nonatomic, strong) UIColor *defaultColor;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *errorColor;
@property (nonatomic, strong) UIColor *selectedMsakColor;
@property (nonatomic, strong) UIColor *errorMaskColor;

@end
