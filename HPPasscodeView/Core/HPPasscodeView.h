//
//  HPPasscodeView.h
//  ILSPrivatePhoto
//
//  Created by hupeng on 15/4/7.
//  Copyright (c) 2015年 iLegendSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    
    HPPasscodeStatusTypeEnablePasscode, // start enable a passcode
    HPPasscodeStatusTypeReEnablePasscode, //
    HPPasscodeStatusTypeConfirmPasscode, // u set a passcode once, then u confirm it
    HPPasscodeStatusTypeResetPasscode,
    HPPasscodeStatusTypeDisablePasscode,
    HPPasscodeStatusTypeVerifyPasscode, // u have setted a passcode, then u unlock it
    HPPasscodeStatusTypeShowPasscode // present a static image of ur passcode view
} HPPasscodeStatusType;


@protocol HPPasscodeViewImp <NSObject>

- (void)initPasscodeView;

- (NSString *)currentPasscode;
- (void)prepareForErrorStatus;
- (void)updatePasscodeViewStatus;
- (void)didEndInputing;

@end

@class HPPasscodeView;

@protocol HPPasscodeViewDelegate <NSObject>

@optional

// tryTime start from 1
- (void)passcodeView:(HPPasscodeView *)passcodeView inputWrongPasscodeWithTryTime:(int)tryTime;
- (void)passcodeView:(HPPasscodeView *)passcodeView willChangeStatusFrom:(HPPasscodeStatusType)fromStatus to:(HPPasscodeStatusType)toStatus;

- (BOOL)checkInputPasscode:(NSString *)passcode;
- (void)passcodeViewDidBeginInput:(HPPasscodeView *)passcodeView;
- (void)passcodeViewDidEnablePasscode:(HPPasscodeView *)passcodeView;
- (void)passcodeViewDidDeletePasscode:(HPPasscodeView *)passcodeView;
- (void)passcodeViewDidVerifiedPasscode:(HPPasscodeView *)passcodeView;

@end

@protocol HPPasscodeStorePolicy <NSObject>

@required

- (BOOL)hasPasscode;

- (void)savePasscode:(NSString *)passcode;

- (void)deletePasscode;

- (NSString *)passcode;

//
// params:
//     passcode : input passcode, this passcode may be an array , a string or some other types
// return:
//     this method should implement a way to convert those types to a string
//     because the passcode stored is string type
//
- (NSString *)passcodeFromInput:(id)passcode;

@optional

//
// this method is used to implement some extra verify logic, which
// will only be called when currentStateType is HPPasscodeStatusTypeVerifyPasscode
//
// this plugin itself only compares the passcode inputted this time to
// what stored in passcodestorage.
// If you need some special verify logic , just implement this method to add your logic
//

- (BOOL)passcodeToVerifyIsValid:(NSString *)passcode;

//
// this method is used to implement some extra verify logic, which
// will only be called when currentStateType is
// HPPasscodeStatusTypeEnablePasscode or HPPasscodeStatusTypeReEnablePasscode
//
// this plugin itself don't do any check for this passcode inputted to store in passcodestorage.
// If you need some special verify logic, such as passcode length must be longger than four,
// then you should implement this method to add this kind of logic
//
- (BOOL)inputPasscodeIsValid:(NSString *)passcode;

@end

@interface HPPasscodeView : UIView <HPPasscodeViewImp>

@property (nonatomic, assign) IBOutlet id<HPPasscodeViewDelegate> delegate;

@property (nonatomic, assign) IBOutlet id<HPPasscodeStorePolicy> passcodeStorePolicy;

@property (nonatomic, assign) HPPasscodeStatusType currentStateType;

@property (nonatomic, assign) BOOL isErrorStatus;

@end
