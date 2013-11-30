//
//  TLTimeLineCell.h
//  Touch Life
//
//  Created by Apple Club on 13-11-23.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLTimeCellDelegate

- (void)addDetailViewToMainViewWithTag:(int)tag;

@end

@interface TLTimeLineCell : UITableViewCell

@property (weak, nonatomic) id<TLTimeCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *previewTextView;
@property (weak, nonatomic) IBOutlet UIButton *lockButton;

- (IBAction)lockAction:(id)sender;
- (void)addGesture;

@end
