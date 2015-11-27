//
//  ViewController.m
//  HPDotView
//
//  Created by 胡鹏 on 15/11/26.
//  Copyright © 2015年 胡鹏. All rights reserved.
//

#import "ViewController.h"
#import "HPPasswordStorage.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}
#pragma mark - UITableViewDataSource and UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @[@"HPDotView", @"HPFixedLengthPasscodeView", @"HPSecurityInputPasscodeView"][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [HPPasswordStorage defaultStorage].passcodeViewType = HPPasscodeViewTypeDot;
            break;
        case 1:
            [HPPasswordStorage defaultStorage].passcodeViewType = HPPasscodeViewTypeFixLength;
            break;
        case 2:
            [HPPasswordStorage defaultStorage].passcodeViewType = HPPasscodeViewTypeSecurityInput;
            break;
            
        default:
            break;
    }
    [self performSegueWithIdentifier:@"openSettingPage" sender:self];
//    [self performSegueWithIdentifier:[@"demo" stringByAppendingString:@(indexPath.row).stringValue] sender:self];
}

@end
