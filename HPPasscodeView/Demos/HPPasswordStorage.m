//
//  HPPasswordStorage.m
//  ILSPrivatePhoto
//
//  Created by  on 15/4/16.
//  Copyright (c) 2015年 iLegendSoft. All rights reserved.
//

#import "HPPasswordStorage.h"
#import "HPCommonMacro.h"

@interface HPPasswordStorage ()
{

}
@end

@implementation HPPasswordStorage


+ (instancetype)defaultStorage
{
    CREATE_SINGLETON_INSTANCE([[HPPasswordStorage alloc] init]);
}

- (NSString *)key
{
    NSString *_key;
    
    switch (_passcodeViewType) {
        case HPPasscodeViewTypeDot:
            _key = @"HPPasscodeViewTypeDot";
            break;
        case HPPasscodeViewTypeFixLength:
            _key = @"HPPasscodeViewTypeFixLength";
            break;
        case HPPasscodeViewTypeSecurityInput:
            _key = @"HPPasscodeViewTypeSecurityInput";
            break;
        default:
            break;
    }
    return _key;
}

#pragma mark - HPPasscodeStorePolicy

- (BOOL)hasPasscode
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:[self key]] != nil;
}

- (void)savePasscode:(NSString *)passcode
{
    [[NSUserDefaults standardUserDefaults] setObject:passcode forKey:[self key]];
}

// not used in this demo
- (void)deletePasscode
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[self key]];
}

- (NSString *)passcode
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:[self key]];
}

- (NSString *)passcodeFromInput:(id)passcode
{
    if (_passcodeViewType == HPPasscodeViewTypeDot && [passcode isKindOfClass:[NSArray class]]) {
        return [(NSArray *)passcode componentsJoinedByString:@"-"];
    } else {
        return passcode;
    }
}

- (BOOL)passcodeToVerifyIsValid:(NSString *)passcode
{
    return [passcode isEqualToString:[self passcode]];
}

- (BOOL)inputPasscodeIsValid:(NSString *)passcode
{
    return [passcode stringByReplacingOccurrencesOfString:@"-" withString:@""].length >= 3;
}

#pragma mark - private methods

+ (NSArray *)passcodeChainFromString:(NSString *)sPasscode
{
    return [sPasscode componentsSeparatedByString:@"-"];
}

@end
