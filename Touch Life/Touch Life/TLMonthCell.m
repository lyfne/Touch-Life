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
    
    monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 155, 26)];
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

- (void)hidePartOfCell:(CGFloat)partHeight
{
    self.layer.mask = [self visibleCell:partHeight / self.frame.size.height];
    self.layer.masksToBounds = YES;
}

- (CAGradientLayer *)visibleCell:(CGFloat)origin
{
    CAGradientLayer *mask = [CAGradientLayer layer];
    mask.frame = self.bounds;
    mask.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:1 alpha:0] CGColor], (id)[[UIColor colorWithWhite:1 alpha:1] CGColor], nil];
    mask.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:origin], [NSNumber numberWithFloat:origin], nil];
    return mask;
}

@end
