//
//  HPPasscodeInputView.h
//  ILSPrivatePhoto
//
//  Created by hupeng on 15/4/7.
//  Copyright (c) 2015年 iLegendSoft. All rights reserved.
//

#import "HPPasscodeView.h"

@interface HPFixedLengthPasscodeView : HPPasscodeView

@property(nonatomic, strong) IBOutlet UITextField *hiddenField;

@property(nonatomic, assign) NSInteger passcodeLength;

@property (nonatomic) BOOL isErrorState;

@end
