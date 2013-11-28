//
//  TLMonthViewController.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-28.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLMonthViewDelegate

- (void)backToTimeLine;
- (void)switchToMonth:(NSString *)month;

@end

@interface TLMonthViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) id<TLMonthViewDelegate> delegate;

@end
