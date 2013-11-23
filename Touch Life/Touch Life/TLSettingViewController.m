//
//  TLSettingViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-12.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLSettingViewController.h"
#import "TLPinCell.h"
#import "TLBgCell.h"

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
    [self initNavigationView];
    [self initTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Init Method

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
    }else{
        return 2;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 140;
    }else{
        return 100;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
    headerView.backgroundColor = [UIColor clearColor];
    
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
    }else{
        label.text = @"密码";
    }
    [headerView addSubview:label];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *bgImageCellIdStr = @"TLBgCell";
    static NSString *pinCellIdStr = @"TLPinCell";
    if (indexPath.section == 0) {
        TLBgCell *cell = [tableView dequeueReusableCellWithIdentifier:bgImageCellIdStr];
        if (cell == nil) {
            cell = [[TLBgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:bgImageCellIdStr];
        }
        
        [cell setView];
        
        return cell;
    }else{
        [tableView registerClass:[TLPinCell class] forCellReuseIdentifier:pinCellIdStr];
        TLPinCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:pinCellIdStr];
        if (cell == nil) {
            cell = [[TLPinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pinCellIdStr];
        }
        
        cell.pinLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
        
        return cell;
    }
}

@end
