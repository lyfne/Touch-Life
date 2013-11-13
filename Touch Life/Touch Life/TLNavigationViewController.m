//
//  TLNavigationViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-12.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLNavigationViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TLNavigationViewController ()

@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

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
    [self initShadow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark IBAction Method

- (IBAction)backAction:(id)sender {
    
}

- (IBAction)moreAction:(id)sender {
    
}

#pragma mark Init Method

- (void)initShadow
{
    [self.view.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.view.layer setShadowRadius:2];
    [self.view.layer setShadowOpacity:0.7f];
    [self.view.layer setShadowColor:[UIColor blackColor].CGColor];
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
