//
//  TLNavigationViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-12.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLNavigationViewController.h"

@interface TLNavigationViewController ()

@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation TLNavigationViewController

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

#pragma mark IBAction Method

- (IBAction)backAction:(id)sender {
    
}

#pragma mark Public Method

- (void)setBackButtonHidden:(BOOL)hidden
{
    self.backButton.hidden = hidden;
}

- (void)setActionButtonHidden:(BOOL)hidden
{
    self.actionButton.hidden = hidden;
}

- (void)setHeaderTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

@end
