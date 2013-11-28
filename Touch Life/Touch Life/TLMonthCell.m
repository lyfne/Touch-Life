//
//  TLMonthCell.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-28.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLMonthCell.h"

@implementation TLMonthCell

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

- (void)setCell
{
    self.backgroundColor = [UIColor clearColor];
    
    monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 155, 26)];
    monthLabel.font = [UIFont systemFontOfSize:14];
    monthLabel.textColor = [UIColor blackColor];
    monthLabel.alpha = 0.6f;
    monthLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:monthLabel];
}

- (void)setMonth:(NSString *)month
{
    monthLabel.text = month;
}

@end
