//
//  TLMonthViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-28.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLMonthViewController.h"
#import "TLMonthCell.h"
#import "TLFileManager.h"

@interface TLMonthViewController ()

@property (weak, nonatomic) IBOutlet UITableView *monthTableView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation TLMonthViewController

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
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Init Method

- (void)initView
{
    self.view.clipsToBounds = YES;
    self.monthTableView.delegate = self;
    self.monthTableView.dataSource = self;
}

#pragma mark Privite Method

- (NSString *)getMonth
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int month = [dateComponent month];
    return [NSString stringWithFormat:@"%d",month];
}

- (int)getYear
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    return [dateComponent year];
}

#pragma mark TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self getYear]-[[TLFileManager sharedFileManager] getMinYear]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
    label.text = [NSString stringWithFormat:@"%d",[[TLFileManager sharedFileManager] getMinYear]+section];
    [headerView addSubview:label];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *monthCellIdStr = @"TLMonthCell";
    TLMonthCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:monthCellIdStr];
    if (cell == nil) {
        cell = [[TLMonthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:monthCellIdStr];
    }
    
    [cell setCell];
    [cell setMonth:[NSString stringWithFormat:@"%d 月",indexPath.row+1]];
    
    return cell;
}

#pragma mark TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TLNoteList *list = [[TLFileManager sharedFileManager] getListWithYear:[self getYear] andMonth:indexPath.row+1];
    if (list != nil) {
        NSLog(@"list %@",list);
    }else{
        NSLog(@"hehe");
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (TLMonthCell *cell in self.monthTableView.visibleCells) {
        CGFloat hiddenFrameHeight = scrollView.contentOffset.y + 35 - cell.frame.origin.y;
        if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
            [cell hidePartOfCell:hiddenFrameHeight];
        }
    }
}

@end
