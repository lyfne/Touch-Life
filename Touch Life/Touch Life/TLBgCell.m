//
//  TLBgCell.m
//  Touch Life
//
//  Created by Apple Club on 13-11-23.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLBgCell.h"
#import "TLFileManager.h"

#define kButtonXBasic 20
#define kButtonXOffset 10
#define kButtonY 12
#define kButtonWidth 70 
#define kButtonHeight 124

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
    if (isUsed != YES) {
        isUsed = YES;
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, kButtonHeight+20)];
        scrollView.contentSize = CGSizeMake(420, kButtonHeight+20);
        scrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:scrollView];
        
        bgCurrent = [UIButton buttonWithType:UIButtonTypeCustom];
        bgCurrent.frame = CGRectMake(kButtonXBasic, kButtonY, kButtonWidth, kButtonHeight);
        [bgCurrent setImage:[UIImage imageNamed:[self getMonth]] forState:UIControlStateNormal];
        [scrollView addSubview:bgCurrent];
        bgCurrent.tag = 100;
        
        bgA = [UIButton buttonWithType:UIButtonTypeCustom];
        bgA.frame = CGRectMake(kButtonXBasic+(kButtonWidth+kButtonXOffset), kButtonY, kButtonWidth, kButtonHeight);
        [bgA setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        [scrollView addSubview:bgA];
        bgA.tag = 1;
        
        bgB = [UIButton buttonWithType:UIButtonTypeCustom];
        bgB.frame = CGRectMake(kButtonXBasic+2*(kButtonWidth+kButtonXOffset), kButtonY, kButtonWidth, kButtonHeight);
        [bgB setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        [scrollView addSubview:bgB];
        bgB.tag = 2;
        
        bgC= [UIButton buttonWithType:UIButtonTypeCustom];
        bgC.frame = CGRectMake(kButtonXBasic+3*(kButtonWidth+kButtonXOffset), kButtonY, kButtonWidth, kButtonHeight);
        [bgC setImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
        [scrollView addSubview:bgC];
        bgC.tag = 3;
        
        bgD = [UIButton buttonWithType:UIButtonTypeCustom];
        bgD.frame = CGRectMake(kButtonXBasic+4*(kButtonWidth+kButtonXOffset), kButtonY, kButtonWidth, kButtonHeight);
        [bgD setImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
        [scrollView addSubview:bgD];
        bgD.tag = 4;
        
        bgArray = [[NSMutableArray alloc] initWithObjects:bgCurrent,bgA,bgB,bgC,bgD, nil];
        
        for (UIButton *button in bgArray) {
            [button addTarget:self action:@selector(chooseBG:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        selectedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SelectedBg"]];
        if ([[[TLFileManager sharedFileManager] getBgImageName] isEqualToString:kCurrentMonthStr]) {
            bgCurrent.userInteractionEnabled = NO;
            selectedImageView.frame = bgCurrent.frame;
        }else{
            int index = [[[TLFileManager sharedFileManager] getBgImageName] intValue];
            UIButton *btn = (UIButton *)[bgArray objectAtIndex:index];
            btn.userInteractionEnabled = NO;
            selectedImageView.frame = btn.frame;
        }
        [scrollView addSubview:selectedImageView];
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
    [self enableAllButton];
    btn.userInteractionEnabled = NO;
    selectedImageView.frame = btn.frame;
}

- (void)enableAllButton
{
    for (UIButton *btn in bgArray) {
        btn.userInteractionEnabled = YES;
    }
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
