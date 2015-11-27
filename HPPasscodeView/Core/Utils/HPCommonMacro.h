//
//  HPCommonMacro.h
//  ILSPrivatePhoto
//
//  Created by hupeng on 15/3/31.
//  Copyright (c) 2015年 iLegendSoft. All rights reserved.
//
#import <UIKit/UIKit.h>

#define HP_ONE_PX_SIZE (1.0/[UIScreen mainScreen].scale)

#define CREATE_SINGLETON_INSTANCE(instance) \
            static dispatch_once_t token = 0; \
            static id _sharedObject = nil; \
            dispatch_once(&token, ^{ \
                _sharedObject = instance; \
            }); \
            return _sharedObject; \

//common params
#define HP_COMMON_CORNER_RADIUS  5.0

#define HP_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]