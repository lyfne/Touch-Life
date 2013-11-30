//
//  TLViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-10-31.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLViewController.h"
#import "TLFileManager.h"

@interface TLViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;

@end

@implementation TLViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self setBgImage];
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

#pragma mark Init 

- (void)setBgImage
{
    if ([[[TLFileManager sharedFileManager] getBgImageName] isEqualToString:kCurrentMonthStr]) {
        [self.bgImageView setImage:[[TLFileManager sharedFileManager] blurryImage:[UIImage imageNamed:[self getMonth]] withBlurLevel:0.2f]];
    }else{
        [self.bgImageView setImage:[[TLFileManager sharedFileManager] blurryImage:[UIImage imageNamed:[[TLFileManager sharedFileManager] getBgImageName]] withBlurLevel:0.2f]];
    }
}

- (void)initTableView
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setShowList];
}

- (void)initNavigationView
{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationVC = [self.storyboard instantiateViewControllerWithIdentifier:kTLNavigationViewController];
    self.navigationVC.delegate = self;
    [self.navigationVC.view setX:0 Y:0];
    [self.navigationVC.view setHeight:50];
    [self.navigationVC setBackButtonHidden:YES];
    [self.navigationVC setHeaderTitle:[[self getMonth] stringByAppendingString:@" 月"]];
    [self.navigationVC setActionButtonTitle:@"新建日记"];
    [self.navigationVC addGesture];
    [self.view addSubview:self.navigationVC.view];
}

#pragma mark IBAction Method

- (IBAction)settingAction:(id)sender {
    self.settingVC = [self.storyboard instantiateViewControllerWithIdentifier:kTLSettingViewController];
    [self.navigationController pushViewController:self.settingVC animated:YES];
}

#pragma mark Privite Method

- (void)setShowList
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int month = [dateComponent month];
    int year = [dateComponent year];
    showList = [[TLFileManager sharedFileManager] getListWithYear:year andMonth:month];
}

- (NSString *)getMonth
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    int month = [dateComponent month];
    return [NSString stringWithFormat:@"%d",month];
}

- (void)addGesture
{
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [swipeGesture setDirection:UISwipeGestureRecognizerDirectionUp];
    [self.view addGestureRecognizer:swipeGesture];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    if (recognizer.direction==UISwipeGestureRecognizerDirectionUp){
        [self removeMonthView];
    }
}

- (void)removeMonthView
{
    [UIView animateWithDuration:0.2f animations:^{
        [self.monthVC.view setY:-440];
        [self.navigationVC.view setAlpha:1];
        [self.tableView setAlpha:1];
    }completion:^(BOOL finish){
        [self.monthVC.view removeFromSuperview];
    }];
}

#pragma mark TableView DataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [showList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer = @"TLTimeLineCell";
    
    TLTimeLineCell * cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[TLTimeLineCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:identifer];
    }
    
    cell.delegate = self;
    cell.dateLabel.text = [NSString stringWithFormat:@"%d日",[[showList getNoteWithIndex:indexPath.row] getDay]];
    cell.previewTextView.text = [showList getNoteWithIndex:indexPath.row].detailNote;
    cell.tag = indexPath.row;
    [cell addGesture];
    
    return cell;
}

#pragma mark TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailNoteVC = [self.storyboard instantiateViewControllerWithIdentifier:kTLDetailNoteViewController];
    [self.detailNoteVC.view setX:0 Y:0 Width:320 Height:568];
    [self.detailNoteVC showNote:[showList getNoteWithIndex:indexPath.row]];
    [self.navigationController pushViewController:self.detailNoteVC animated:YES];
}

#pragma mark TLNoteDelegate

- (void)reloadTableView
{
    [self setShowList];
    [self.navigationVC setHeaderTitle:[[self getMonth] stringByAppendingString:@" 月"]];
    [self.tableView reloadData];
}

#pragma mark TLNavigationDelegate

- (void)popBack
{
    [self setShowList];
    [self setBgImage];
    [self.tableView reloadData];
}

- (void)moreAction
{
    self.noteVC = [self.storyboard instantiateViewControllerWithIdentifier:kTLNoteViewController];
    self.noteVC.delegate = self;
    [self.navigationController pushViewController:self.noteVC animated:YES];
}

- (void)showMonthView
{
    self.monthVC = [self.storyboard instantiateViewControllerWithIdentifier:kTLMonthViewController];
    [self.monthVC.view setX:0 Y:-440 Width:320 Height:440];
    self.monthVC.delegate = self;
    [self.view addSubview:self.monthVC.view];
    [UIView animateWithDuration:0.2f animations:^{
        [self.monthVC.view setY:0];
        [self.navigationVC.view setAlpha:0];
        [self.tableView setAlpha:0];
    }completion:^(BOOL finish){
        [self addGesture];
    }];
}

#pragma mark TLMonthViewDelegate

- (void)backToTimeLineWithList:(TLNoteList *)list
{
    showList = list;
    [self.navigationVC setHeaderTitle:[NSString stringWithFormat:@"%d年%d月",[list getYear],[list getMonth]]];
    [self.bgImageView setImage:[[TLFileManager sharedFileManager] blurryImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",[list getMonth]]] withBlurLevel:0.2f]];
    [self.navigationVC setBackButtonHidden:NO];
    [self.tableView reloadData];
    [self removeMonthView];
}

#pragma mark TLTimeCellDelegate

- (void)addDetailViewToMainViewWithTag:(int)tag
{
    self.detailNoteVC = [self.storyboard instantiateViewControllerWithIdentifier:kTLDetailNoteViewController];
    [self.detailNoteVC.view setX:0 Y:0 Width:320 Height:568];
    [self.detailNoteVC showNote:[showList getNoteWithIndex:tag]];
    [self.navigationController pushViewController:self.detailNoteVC animated:YES];
}

@end
