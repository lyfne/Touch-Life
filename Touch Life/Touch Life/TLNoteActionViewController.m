//
//  TLNoteActionViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-13.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLNoteActionViewController.h"

@interface TLNoteActionViewController ()

@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;

@end

@implementation TLNoteActionViewController

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

- (IBAction)takePhotoAction:(id)sender {
    [self.delegate takePhoto];
}

- (IBAction)recordAction:(id)sender {
    [self.delegate startRecord];
}

#pragma mark Public Method

- (void)setPhotoButtonTitle:(NSString *)title
{
    [self.takePhotoButton setTitle:title forState:UIControlStateNormal];
}

@end
