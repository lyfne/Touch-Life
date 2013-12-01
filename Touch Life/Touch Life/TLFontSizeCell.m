//
//  TLFontSizeCell.m
//  Touch Life
//
//  Created by Apple Club on 13-12-1.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLFontSizeCell.h"
#import "TLFileManager.h"

@implementation TLFontSizeCell

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

- (IBAction)changeSize:(id)sender {
    UIStepper *st = (UIStepper *)sender;
    self.preShowLabel.font = [UIFont systemFontOfSize:st.value];
    [[TLFileManager sharedFileManager] setFontSize:[NSString stringWithFormat:@"%f",st.value]];
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
