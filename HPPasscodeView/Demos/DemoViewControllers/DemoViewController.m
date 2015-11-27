//
//  DemoViewController.m
//  HPPasscodeView
//
//  Created by Hu, Peng on 11/27/15.
//  Copyright © 2015 Hu, Peng. All rights reserved.
//

#import "DemoViewController.h"
#import "HPSecurityInputPasscodeView.h"
#import "HPFixedLengthPasscodeView.h"
#import "UIColor+ColorExt.h"


@interface DemoViewController ()<HPPasscodeViewDelegate>
{
}

@property (weak, nonatomic) IBOutlet UILabel *statusDescLabel;
@property (weak, nonatomic) IBOutlet HPPasscodeView *passcodeView;

@end

@implementation DemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _passcodeView.passcodeStorePolicy = [HPPasswordStorage defaultStorage];
    _passcodeView.currentStateType = self.type;
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([_passcodeView isKindOfClass:[HPFixedLengthPasscodeView class]]) {
        HPFixedLengthPasscodeView *_flView = (HPFixedLengthPasscodeView *)_passcodeView;
        _flView.passcodeLength = 4;
        [_flView.hiddenField becomeFirstResponder];
    } else if ([_passcodeView isKindOfClass:[HPSecurityInputPasscodeView class]]) {
        HPSecurityInputPasscodeView *_siView = (HPSecurityInputPasscodeView *)_passcodeView;
        [_siView.inputField becomeFirstResponder];
    }
}

- (IBAction)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)showStatus:(NSString *)status isError:(BOOL)isError
{
    self.statusDescLabel.textColor = isError ? [UIColor hex:@"F26D5F"] : [UIColor hex:@"4E4749"];
    self.statusDescLabel.text = status;
}


#pragma mark - HPDotViewDelegate

- (void)passcodeViewDidBeginInput:(HPPasscodeView *)passcodeView
{
    [self showStatus:@"Release Finger When Done" isError:NO];
}

- (void)passcodeView:(HPPasscodeView *)passcodeView willChangeStatusFrom:(HPPasscodeStatusType)fromStatus to:(HPPasscodeStatusType)toStatus
{
    if (toStatus == HPPasscodeStatusTypeConfirmPasscode) {
        [self showStatus:@"Input Again to Confirm" isError:NO];
    } else  if (toStatus == HPPasscodeStatusTypeReEnablePasscode && fromStatus != HPPasscodeStatusTypeConfirmPasscode) {
        [self showStatus:@"Passcode length should be longger than 3" isError:YES];
    } else if (fromStatus == HPPasscodeStatusTypeResetPasscode && toStatus == HPPasscodeStatusTypeEnablePasscode) {
        [self showStatus:@"Input a new passcode" isError:NO];
    }
    
}

- (void)passcodeView:(HPPasscodeView *)passcodeView inputWrongPasscodeWithTryTime:(int)tryTime
{
    [self showStatus:@"Mismatch! Please Try Again" isError:YES];
}

- (void)passcodeViewDidEnablePasscode:(HPPasscodeView *)passcodeView
{
    [self backButtonClicked:nil];
}

- (void)passcodeViewDidVerifiedPasscode:(HPPasscodeView *)passcodeView
{
    [self backButtonClicked:nil];
}

- (void)passcodeViewDidDeletePasscode:(HPPasscodeView *)passcodeView
{
    [self backButtonClicked:nil];
}

@end
