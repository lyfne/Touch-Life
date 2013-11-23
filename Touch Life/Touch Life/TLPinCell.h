//
//  TLPinCell.h
//  Touch Life
//
//  Created by Apple Club on 13-11-23.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLPinCell : UITableViewCell{
    UILabel *actionLabel;
}

- (void)setCell;
- (void)setActionTitle:(NSString *)title;

@end
