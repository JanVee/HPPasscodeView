//
//  HPSecurityInputPasscodeView.m
//  ILSPrivatePhoto
//
//  Created by hupeng on 15/4/8.
//  Copyright (c) 2015年 iLegendSoft. All rights reserved.
//

#import "HPSecurityInputPasscodeView.h"


@interface HPSecurityInputPasscodeView () <UITextFieldDelegate>

@end

@implementation HPSecurityInputPasscodeView

- (NSString *)currentPasscode
{
    return _inputField.text;
}

- (void)initPasscodeView
{
    [super initPasscodeView];
    
    _inputField.text = nil;
}

- (void)setInputField:(UITextField *)inputField
{
    _inputField = inputField;
    inputField.delegate = self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.isErrorStatus) {
        return FALSE;
    }
    if ([string isEqualToString:@"\n"]) {
        
        [self updatePasscodeViewStatus];
    }
    return TRUE;
}
@end
