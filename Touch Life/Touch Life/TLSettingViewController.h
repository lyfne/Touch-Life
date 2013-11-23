//
//  TLSettingViewController.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-12.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLNavigationViewController.h"
#import "TLSettingHeaderViewController.h"

@interface TLSettingViewController : UIViewController<TLNavigationDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) TLNavigationViewController *navigationVC;
@property (strong, nonatomic) TLSettingHeaderViewController *firstHeaderView;
@property (strong, nonatomic) TLSettingHeaderViewController *secondHeaderView;

@end
