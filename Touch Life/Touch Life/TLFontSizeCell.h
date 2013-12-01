//
//  TLFontSizeCell.h
//  Touch Life
//
//  Created by Apple Club on 13-12-1.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLFontSizeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *preShowLabel;
@property (weak, nonatomic) IBOutlet UIStepper *changeSizeStepper;

- (void)hidePartOfCell:(CGFloat)partHeight;

@end
