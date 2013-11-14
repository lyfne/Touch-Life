//
//  TLViewController.h
//  Touch Life
//
//  Created by Fan's Mac on 13-10-31.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLNavigationViewController.h"
#import "TLNoteViewController.h"
#import "TLSettingViewController.h"

@interface TLViewController : UIViewController<TLNavigationDelegate>

@property (strong, nonatomic) TLNavigationViewController *navigationVC;
@property (strong, nonatomic) TLNoteViewController *noteVC;
@property (strong, nonatomic) TLSettingViewController *settingVC;

@end