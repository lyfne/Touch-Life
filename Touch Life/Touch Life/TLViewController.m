//
//  TLViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-10-31.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLViewController.h"
#import "TLNoteCell.h"

@interface TLViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation TLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Init 

- (void)initTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)initNavigationView
{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationVC = [self.storyboard instantiateViewControllerWithIdentifier:kTLNavigationViewController];
}

#pragma mark TableView DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer = @"TLNoteCell";
    
    TLNoteCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[TLNoteCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:identifer];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}

#pragma mark TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
