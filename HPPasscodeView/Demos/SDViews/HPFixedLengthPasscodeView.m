//
//  HPPasscodeInputView.m
//  ILSPrivatePhoto
//
//  Created by hupeng on 15/4/7.
//  Copyright (c) 2015年 iLegendSoft. All rights reserved.
//

#define HP_LINE_COLOR (_isErrorState ? [UIColor colorWithR:242 g:109 b:95 a:1] : [UIColor colorWithWhite:149 / 255.f alpha:1])


#import "HPFixedLengthPasscodeView.h"
#import "UIColor+ColorExt.h"
#import "HPCommonMacro.h"
#import "HPLine.h"

@interface HPFixedLengthPasscodeView () <UITextFieldDelegate>
{
    NSMutableArray *_dots;
    NSMutableArray *_lines;
    NSInteger _currentInputIndex;
}
@end

@implementation HPFixedLengthPasscodeView

- (void)initPasscodeView
{
    [super initPasscodeView];
    
    // 1.clear subviews
    for (UIView *subView in [self subviews]) {
        [subView removeFromSuperview];
    }
    
    self.layer.borderWidth = HP_ONE_PX_SIZE;
    self.layer.borderColor = HP_LINE_COLOR.CGColor;
    self.layer.cornerRadius = 1;
    self.clipsToBounds = YES;
    _hiddenField.text = nil;
    _currentInputIndex = 0;
    self.passcodeLength = _passcodeLength;
}

- (void)prepareForErrorStatus
{
    [super prepareForErrorStatus];
}

- (NSString *)currentPasscode
{
    return _hiddenField.text;
}

- (void)setHiddenField:(UITextField *)hiddenField
{
    _hiddenField = hiddenField;
    hiddenField.delegate = self;
}

- (void)setIsErrorState:(BOOL)isErrorState {
    _isErrorState = isErrorState;
    
    self.layer.borderColor = HP_LINE_COLOR.CGColor;
    for (HPLine *line in _lines) {
        line.backgroundColor = HP_LINE_COLOR;
    }
}

- (void)setPasscodeLength:(NSInteger)passcodeLength
{
    _passcodeLength = passcodeLength;
    
    for (UIView *line in self.subviews) {
        [line removeFromSuperview];
    }
    
    // 1.draw seperator line
    
    float h = CGRectGetHeight(self.bounds);
    float w = CGRectGetWidth(self.bounds);
    float cellWidth = w/passcodeLength;
    
    if (!_lines) {
        _lines = @[].mutableCopy;
    } else {
        [_lines removeAllObjects];
    }
    
    for (int i = 1; i < passcodeLength; i++) {
        HPLine *line = [HPLine verticalLineWithHeight:h];
        line.center = CGPointMake(i * cellWidth, h * 0.5);
        line.backgroundColor = HP_LINE_COLOR;
        [_lines addObject:line];
        [self addSubview:line];
    }
    
    // 2.draw dots
    
    if (!_dots) {
        _dots = @[].mutableCopy;
    } else {
        [_dots removeAllObjects];
    }
    
    float dotSize = 0.2 * cellWidth;
    
    for (int i = 0; i < passcodeLength; i++) {
        UIView *dot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dotSize, dotSize)];
        dot.clipsToBounds = TRUE;
        dot.backgroundColor = [UIColor colorWithR:78 g:71 b:73 a:1];
        dot.layer.cornerRadius = dotSize * 0.5;
        dot.center = CGPointMake((2 * i + 1) * cellWidth /2, h/2);
        dot.hidden = self.currentStateType != HPPasscodeStatusTypeShowPasscode;
        [self addSubview:dot];
        [_dots addObject:dot];
    }
}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (_currentInputIndex == _passcodeLength) {
        return FALSE;
    }
    if ([string isEqualToString:@"\n"]) {
        //...数字键盘 没有这一项
    } else if ([string isEqualToString:@""]) {
        // fix hockey app's crash
        // https://rink.hockeyapp.net/manage/apps/35398/app_versions/53/crash_reasons/41290565
        // 理论上不应该有这个问题
        NSInteger index = --_currentInputIndex;
        if (index < 0) {
            index = 0;
            _currentInputIndex = 0;
        }
        UIView *dot = _dots[index];
        dot.hidden = TRUE;

    } else {
        
        UIView *dot = _dots[_currentInputIndex++];
        dot.hidden = FALSE;
        if (_currentInputIndex == _passcodeLength) {
            
            [self performSelector:@selector(updatePasscodeViewStatus) withObject:nil afterDelay:0.2];
        }
    }
    return TRUE;
}

@end
