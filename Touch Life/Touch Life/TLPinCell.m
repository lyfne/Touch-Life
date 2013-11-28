//
//  TLPinCell.m
//  Touch Life
//
//  Created by Apple Club on 13-11-23.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLPinCell.h"

@implementation TLPinCell

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
    actionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 12, 150, 25)];
    actionLabel.backgroundColor = [UIColor clearColor];
    actionLabel.textColor = [UIColor blackColor];
    actionLabel.alpha = 0.6f;
    [self.contentView addSubview:actionLabel];
}

- (void)setActionTitle:(NSString *)title
{
    actionLabel.text = title;
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
