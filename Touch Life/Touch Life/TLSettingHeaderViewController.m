//
//  TLSettingHeaderViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-20.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLSettingHeaderViewController.h"

@interface TLSettingHeaderViewController ()

@end

@implementation TLSettingHeaderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Public Method

- (void)setHeaderTitle:(NSString *)title
{
    self.headerLabel.text = title;
}

@end
