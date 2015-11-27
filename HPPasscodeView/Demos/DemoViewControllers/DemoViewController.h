//
//  DemoViewController.h
//  HPPasscodeView
//
//  Created by Hu, Peng on 11/27/15.
//  Copyright © 2015 Hu, Peng. All rights reserved.
//

#import "HPPasswordStorage.h"

@interface DemoViewController : UIViewController

@property (nonatomic, assign) HPPasscodeStatusType type;

- (void)showStatus:(NSString *)status isError:(BOOL)isError;

@end
