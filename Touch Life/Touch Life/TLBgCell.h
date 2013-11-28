//
//  TLBgCell.h
//  Touch Life
//
//  Created by Apple Club on 13-11-23.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLBgCell : UITableViewCell{
    UIScrollView *scrollView;
    NSMutableArray *bgArray;
    
    UIImageView *selectedImageView;
    UIButton *bgCurrent;
    UIButton *bgA;
    UIButton *bgB;
    UIButton *bgC;
    UIButton *bgD;
    
    BOOL isUsed;
}

- (void)setView;
- (void)hidePartOfCell:(CGFloat)partHeight;

@end
 