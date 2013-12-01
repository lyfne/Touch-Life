//
//  TLSettingViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-12.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLSettingViewController.h"
#import "TLFileManager.h"
#import "TLPinCell.h"
#import "TLBgCell.h"
#import "TLFontSizeCell.h"

@interface TLSettingViewController ()

@property (weak, nonatomic) IBOutlet UITableView *settingTableView;

@end

@implementation TLSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initNavigationView];
    [self initTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Init Method

- (void)initData
{
    if ([[[TLFileManager sharedFileManager] getPinCode] isEqualToString:kPinCodeStr]) {
        withPin = NO;
    }else{
        withPin = YES;
    }
}

- (void)initTableView
{
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;
}

- (void)initNavigationView
{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationVC = [self.storyboard instantiateViewControllerWithIdentifier:kTLNavigationViewController];
    self.navigationVC.delegate = self;
    [self.navigationVC.view setX:0 Y:0];
    [self.navigationVC.view setHeight:50];
    [self.navigationVC setActionButtonHidden:YES];
    [self.navigationVC setHeaderTitle:@"设置"];
    [self.view addSubview:self.navigationVC.view];
}

#pragma mark TLNavigationDelegate

- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark TableView DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        if (withPin == NO) {
            return 1;
        }else{
            return 2;
        }
    }else{
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 144;
    }else if(indexPath.section == 1){
        return 50;
    }else{
        return 100;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
    headerView.backgroundColor = [UIColor clearColor];
    
//    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
//    [bgImageView setImage:[UIImage imageNamed:@"HeaderBg"]];
//    bgImageView.backgroundColor = [UIColor blueColor];
//    //bgImageView.alpha = 0.6f;
//    [headerView addSubview:bgImageView];
    
    UIImageView *bgLine = [[UIImageView alloc] initWithFrame:CGRectMake(55, 17, 265, 1)];
    bgLine.backgroundColor = [UIColor blackColor];
    bgLine.alpha = 0.6f;
    [headerView addSubview:bgLine];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 7, 55, 20)];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    label.alpha = 0.6f;
    label.textAlignment = NSTextAlignmentCenter;
    if (section == 0) {
        label.text = @"壁纸";
    }else if(section == 1){
        label.text = @"密码";
    }else{
        label.text = @"字体";
    }
    [headerView addSubview:label];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *bgImageCellIdStr = @"TLBgCell";
    static NSString *pinCellIdStr = @"TLPinCell";
    static NSString *fontSizeCellIdStr = @"TLFontSizeCell";
    if (indexPath.section == 0) {
        TLBgCell *cell = [tableView dequeueReusableCellWithIdentifier:bgImageCellIdStr];
        if (cell == nil) {
            cell = [[TLBgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bgImageCellIdStr];
        }

        [cell setView];

        return cell;
    }else if(indexPath.section == 1){
        TLPinCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:pinCellIdStr];
        if (cell == nil) {
            cell = [[TLPinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pinCellIdStr];
        }
        
        [cell setCell];
        if (withPin == NO) {
            [cell setActionTitle:@"设置密码"];
        }else{
            if (indexPath.row == 0) {
                [cell setActionTitle:@"修改密码" ];
            }else{
                [cell setActionTitle:@"取消密码"];
            }
        }
        
        return cell;
    }else{
        TLFontSizeCell *cell = [tableView dequeueReusableCellWithIdentifier:fontSizeCellIdStr];
        if (cell == nil) {
            cell = [[TLFontSizeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fontSizeCellIdStr];
        }
        
        cell.preShowLabel.font = [UIFont systemFontOfSize:[[[TLFileManager sharedFileManager] getFontSize] floatValue]];
        cell.changeSizeStepper.value = [[[TLFileManager sharedFileManager] getFontSize] floatValue];
        return cell;
    }
}

#pragma mark TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (withPin == NO) {
            PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionSet];
            passcodeViewController.delegate = self;
            passcodeViewController.simple = YES;
            [self presentViewController:passcodeViewController animated:YES completion:nil];
        }else{
            if (indexPath.row == 0) {
                PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionChange];
                passcodeViewController.delegate = self;
                passcodeViewController.passcode = [[TLFileManager sharedFileManager] getPinCode];
                passcodeViewController.simple = YES;
                [self presentViewController:passcodeViewController animated:YES completion:nil];
            }else{
                PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionEnter];
                passcodeViewController.delegate = self;
                passcodeViewController.passcode = [[TLFileManager sharedFileManager] getPinCode];
                passcodeViewController.simple = YES;
                [self presentViewController:passcodeViewController animated:YES completion:nil];
            }
        }
    }
}

#pragma mark - PAPasscodeViewControllerDelegate

- (void)PAPasscodeViewControllerDidCancel:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)PAPasscodeViewControllerDidEnterPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        [[TLFileManager sharedFileManager] setPinCode:kPinCodeStr];
        [self initData];
        [self.settingTableView reloadData];
    }];
}

- (void)PAPasscodeViewControllerDidSetPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        [[TLFileManager sharedFileManager] setPinCode:controller.passcode];
        [self initData];
        [self.settingTableView reloadData];
    }];
}

- (void)PAPasscodeViewControllerDidChangePasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        [[TLFileManager sharedFileManager] setPinCode:controller.passcode];
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (TLBgCell *cell in self.settingTableView.visibleCells) {
        CGFloat hiddenFrameHeight = scrollView.contentOffset.y + 35 - cell.frame.origin.y;
        if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
            [cell hidePartOfCell:hiddenFrameHeight];
        }
    }
    for (TLPinCell *cell in self.settingTableView.visibleCells) {
        CGFloat hiddenFrameHeight = scrollView.contentOffset.y + 35 - cell.frame.origin.y;
        if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
            [cell hidePartOfCell:hiddenFrameHeight];
        }
    }
}

@end
