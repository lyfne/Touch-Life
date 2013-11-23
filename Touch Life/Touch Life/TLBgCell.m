//
//  TLBgCell.m
//  Touch Life
//
//  Created by Apple Club on 13-11-23.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLBgCell.h"

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
    
    UIButton *bgA = [UIButton buttonWithType:UIButtonTypeCustom];
    bgA.frame = CGRectMake(20, 10, 68, 120);
    [bgA setImage:[UIImage imageNamed:@"12"] forState:UIControlStateNormal];
    [scrollView addSubview:bgA];
    bgA.tag = 101;
    
    UIButton *bgB = [UIButton buttonWithType:UIButtonTypeCustom];
    bgB.frame = CGRectMake(100, 10, 68, 120);
    [bgB setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    [scrollView addSubview:bgB];
    bgB.tag = 102;
    
    UIButton *bgC = [UIButton buttonWithType:UIButtonTypeCustom];
    bgC.frame = CGRectMake(180, 10, 68, 120);
    [bgC setImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
    [scrollView addSubview:bgC];
    bgC.tag = 103;
    
    UIButton *bgD = [UIButton buttonWithType:UIButtonTypeCustom];
    bgD.frame = CGRectMake(260, 10, 68, 120);
    [bgD setImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
    [scrollView addSubview:bgD];
    bgD.tag = 104;
    
    UIButton *bgE = [UIButton buttonWithType:UIButtonTypeCustom];
    bgE.frame = CGRectMake(340, 10, 68, 120);
    [bgE setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
    [scrollView addSubview:bgE];
    bgE.tag = 105;
    
    bgArray = [[NSMutableArray alloc] initWithObjects:bgA,bgB,bgC,bgD,bgE, nil];
    
    for (UIButton *button in bgArray) {
        [button addTarget:self action:@selector(chooseBG:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)chooseBG:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"tag %d",btn.tag);
}

@end
