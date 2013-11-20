//
//  TLPhotoViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-20.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLPhotoViewController.h"

@interface TLPhotoViewController ()

@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation TLPhotoViewController

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

- (IBAction)closeAction:(id)sender {
    [UIView animateWithDuration:0.5f animations:^{
        [self.detailView setY:self.view.frame.size.height];
    }completion:^(BOOL finish){
        [self.delegate closePhotoView];
    }];
}

- (IBAction)reTakeAction:(id)sender {
}

- (IBAction)deleteAction:(id)sender {
}

@end
