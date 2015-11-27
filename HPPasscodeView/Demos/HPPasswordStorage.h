//
//  HPPasswordStorage.h
//  ILSPrivatePhoto
//
//  Created by hupeng on 15/4/16.
//  Copyright (c) 2015年 iLegendSoft. All rights reserved.
//

#import "HPPasscodeView.h"

typedef enum {
    HPPasscodeViewTypeDot,
    HPPasscodeViewTypeFixLength,
    HPPasscodeViewTypeSecurityInput
    
} HPPasscodeViewType;

@interface HPPasswordStorage : NSObject <HPPasscodeStorePolicy>

@property (nonatomic, assign) HPPasscodeViewType passcodeViewType;

+ (instancetype)defaultStorage;

// ...
+ (NSArray *)passcodeChainFromString:(NSString *)sPasscode;

@end
