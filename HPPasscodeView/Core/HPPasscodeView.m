//
//  HPPasscodeView.m
//  ILSPrivatePhoto
//
//  Created by hupeng on 15/4/7.
//  Copyright (c) 2015年 iLegendSoft. All rights reserved.
//

#import "HPPasscodeView.h"

@interface HPPasscodeView ()
{
    NSString *_previousPasscode;
    int _passcodeTryTime;
}
@end

@implementation HPPasscodeView

#pragma mark - init methods

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"frame"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"frame"]) {
        [self refreshSubviews];
    }
}

- (void)refreshSubviews
{
    [self initPasscodeView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initPasscodeView];
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}


- (void)awakeFromNib
{
    [self initPasscodeView];
    [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (void)initPasscodeView
{
    self.isErrorStatus = FALSE;
    self.userInteractionEnabled = TRUE;
    //...
}

- (void)prepareForErrorStatus
{
    self.isErrorStatus = TRUE;
    //...
}

- (NSString *)currentPasscode
{
    //...
    return nil;
}

- (void)didEndInputing
{
    //...
}

- (void)setCurrentStateType:(HPPasscodeStatusType)currentStateType
{
    _currentStateType = currentStateType;
    [self initPasscodeView];
}

- (void)performStatusWithError:(HPPasscodeStatusType)performType
{
    [self prepareForErrorStatus];
    [self performSelector:@selector(performStatusType:) withObject:@(performType) afterDelay:0.5];
}

- (void)performStatusType:(NSNumber *)type
{
    HPPasscodeStatusType nextType = (HPPasscodeStatusType)type.integerValue;
    if (self.delegate && [self.delegate respondsToSelector:@selector(passcodeView:willChangeStatusFrom:to:)]) {
        [self.delegate passcodeView:self willChangeStatusFrom:_currentStateType to:nextType];
    }
    self.currentStateType = nextType;
}

- (void)updatePasscodeViewStatus
{
    if (self.currentStateType == HPPasscodeStatusTypeEnablePasscode || self.currentStateType == HPPasscodeStatusTypeReEnablePasscode) {
        
        _previousPasscode = [self currentPasscode];
        
        BOOL passcodeIsValid = TRUE;
        
        if (self.passcodeStorePolicy && [self.passcodeStorePolicy respondsToSelector:@selector(inputPasscodeIsValid:)]) {
            passcodeIsValid = [self.passcodeStorePolicy inputPasscodeIsValid:_previousPasscode];
        }
        
        HPPasscodeStatusType toStatus = HPPasscodeStatusTypeConfirmPasscode;
        
        if (!passcodeIsValid) {
            toStatus = HPPasscodeStatusTypeReEnablePasscode;
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(passcodeView:willChangeStatusFrom:to:)]) {
            [self.delegate passcodeView:self willChangeStatusFrom:_currentStateType to:toStatus];
        }
        self.currentStateType = toStatus;
        return;
    }
    
    if (self.currentStateType == HPPasscodeStatusTypeConfirmPasscode) {
        
        NSString *confirmPasscodeString = [self currentPasscode];
        
        if ([confirmPasscodeString isEqualToString:_previousPasscode]) {
            
            [self didEndInputing];
            
            [self.passcodeStorePolicy savePasscode:confirmPasscodeString];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(passcodeViewDidEnablePasscode:)]) {
                [self.delegate passcodeViewDidEnablePasscode:self];
            }
            
        } else {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(passcodeView:inputWrongPasscodeWithTryTime:)]) {
                [self.delegate passcodeView:self inputWrongPasscodeWithTryTime:++_passcodeTryTime];
            }
            
            [self performStatusWithError:HPPasscodeStatusTypeReEnablePasscode];
        }
        return;
    }
    
    if (self.currentStateType == HPPasscodeStatusTypeResetPasscode) {
        NSString *passcode = [self.passcodeStorePolicy passcode];
        NSString *confirmPasscodeString = [self currentPasscode];
        if ([confirmPasscodeString isEqualToString:passcode]) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(passcodeView:willChangeStatusFrom:to:)]) {
                [_delegate passcodeView:self willChangeStatusFrom:_currentStateType to:HPPasscodeStatusTypeEnablePasscode];
            }
            
            self.currentStateType = HPPasscodeStatusTypeEnablePasscode;
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(passcodeView:inputWrongPasscodeWithTryTime:)]) {
                [self.delegate passcodeView:self inputWrongPasscodeWithTryTime:++_passcodeTryTime];
            }
            
            [self performStatusWithError:HPPasscodeStatusTypeResetPasscode];
        }
        return;
    }
    
    if (self.currentStateType == HPPasscodeStatusTypeDisablePasscode) {
        
        NSString *passcode = [self.passcodeStorePolicy passcode];
        NSString *confirmPasscodeString = [self currentPasscode];
        
        if ([confirmPasscodeString isEqualToString:passcode]) {
            [self didEndInputing];
            [self.passcodeStorePolicy deletePasscode];
            if (_delegate && [_delegate respondsToSelector:@selector(passcodeViewDidDeletePasscode:)]) {
                [_delegate passcodeViewDidDeletePasscode:self];
            }
            return;
        } else {
            if (self.delegate && [self.delegate respondsToSelector:@selector(passcodeView:inputWrongPasscodeWithTryTime:)]) {
                [self.delegate passcodeView:self inputWrongPasscodeWithTryTime:++_passcodeTryTime];
            }
            [self performStatusWithError:HPPasscodeStatusTypeDisablePasscode];
            
        }
        return;
    }
    
    if (self.currentStateType == HPPasscodeStatusTypeVerifyPasscode) {
        
        NSString *passcode = [self.passcodeStorePolicy passcode];
        NSString *confirmPasscodeString = [self currentPasscode];
        
        BOOL passcodeIsValid = FALSE;
        
        if (self.passcodeStorePolicy && [self.passcodeStorePolicy respondsToSelector:@selector(passcodeToVerifyIsValid:)]) {
            passcodeIsValid = [self.passcodeStorePolicy passcodeToVerifyIsValid:confirmPasscodeString];
        } else {
            passcodeIsValid = [confirmPasscodeString isEqualToString:passcode];
        }
        
        if (passcodeIsValid) {
            [self didEndInputing];
            if (self.delegate && [self.delegate respondsToSelector:@selector(passcodeViewDidVerifiedPasscode:)]) {
                [self.delegate passcodeViewDidVerifiedPasscode:self];
            }
            return;
        } else {

            if (self.delegate && [self.delegate respondsToSelector:@selector(passcodeView:inputWrongPasscodeWithTryTime:)]) {
                [self.delegate passcodeView:self inputWrongPasscodeWithTryTime:++_passcodeTryTime];
            }
            [self performStatusWithError:HPPasscodeStatusTypeVerifyPasscode];
        }
        return;
    }
}

@end
