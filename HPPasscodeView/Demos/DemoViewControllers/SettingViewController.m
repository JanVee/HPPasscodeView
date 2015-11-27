//
//  SettingViewController.m
//  HPPasscodeView
//
//  Created by Hu, Peng on 11/27/15.
//  Copyright © 2015 Hu, Peng. All rights reserved.
//

#import "SettingViewController.h"
#import "DemoViewController.h"
#import "HPPasswordStorage.h"

@interface SettingViewController ()
{
    NSInteger _type;
}
@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DemoViewController *demoVC = segue.destinationViewController;
    
    HPPasscodeStatusType type = HPPasscodeStatusTypeEnablePasscode;
    switch (_type) {
        case 0:
            type = HPPasscodeStatusTypeEnablePasscode;
            break;
        case 1:
            type = HPPasscodeStatusTypeResetPasscode;
            break;
        case 2:
            type = HPPasscodeStatusTypeDisablePasscode;
            break;
        case 3:
            type = HPPasscodeStatusTypeVerifyPasscode;
            break;
        default:
            break;
    }
    demoVC.type = type;
}


#pragma mark - UITableViewDataSource and UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @[@"EnablePasscode", @"ResetPasscode", @"DisablePasscode", @"Unlock"][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _type = indexPath.row;
    [self performSegueWithIdentifier:[@"demo" stringByAppendingString:@([HPPasswordStorage defaultStorage].passcodeViewType).stringValue] sender:self];
}

@end
