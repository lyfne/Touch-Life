//
//  TLBgCell.m
//  Touch Life
//
//  Created by Apple Club on 13-11-23.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLBgCell.h"
#import "TLFileManager.h"

@implementation TLBgCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setView
{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
    scrollView.contentSize = CGSizeMake(420, 140);
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:scrollView];
    
    bgCurrent = [UIButton buttonWithType:UIButtonTypeCustom];
    bgCurrent.frame = CGRectMake(20, 10, 68, 120);
    [bgCurrent setImage:[UIImage imageNamed:[self getMonth]] forState:UIControlStateNormal];
    [scrollView addSubview:bgCurrent];
    bgCurrent.tag = 100;
    
    bgA = [UIButton buttonWithType:UIButtonTypeCustom];
    bgA.frame = CGRectMake(100, 10, 68, 120);
    [bgA setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [scrollView addSubview:bgA];
    bgA.tag = 1;
    
    bgB = [UIButton buttonWithType:UIButtonTypeCustom];
    bgB.frame = CGRectMake(180, 10, 68, 120);
    [bgB setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    [scrollView addSubview:bgB];
    bgB.tag = 2;
    
    bgC= [UIButton buttonWithType:UIButtonTypeCustom];
    bgC.frame = CGRectMake(260, 10, 68, 120);
    [bgC setImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
    [scrollView addSubview:bgC];
    bgC.tag = 3;
    
    bgD = [UIButton buttonWithType:UIButtonTypeCustom];
    bgD.frame = CGRectMake(340, 10, 68, 120);
    [bgD setImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
    [scrollView addSubview:bgD];
    bgD.tag = 4;
    
    bgArray = [[NSMutableArray alloc] initWithObjects:bgCurrent,bgA,bgB,bgC,bgD, nil];
    
    for (UIButton *button in bgArray) {
        [button addTarget:self action:@selector(chooseBG:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)chooseBG:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 100) {
        [[TLFileManager sharedFileManager] setBgImage:@"currentMonth"];
    }else{
        [[TLFileManager sharedFileManager] setBgImage:[NSString stringWithFormat:@"%d",btn.tag]];
    }
    
    [scrollView scrollRectToVisible:btn.frame animated:YES];
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

@end
