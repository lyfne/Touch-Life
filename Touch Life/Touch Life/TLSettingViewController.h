//
//  TLSettingViewController.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-12.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLNavigationViewController.h"

@interface TLSettingViewController : UIViewController<TLNavigationDelegate>

@property (strong, nonatomic) TLNavigationViewController *navigationVC;

@end
