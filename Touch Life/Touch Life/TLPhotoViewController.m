//
//  TLPhotoViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-20.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLPhotoViewController.h"

@interface TLPhotoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIButton *reTakeButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

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
    [self initGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Init Method

- (void)initGesture
{
    self.photoImageView.clipsToBounds = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takePhoto)];
    [self.photoImageView addGestureRecognizer:tapGesture];
}

#pragma mark Public Method

- (void)showEditButton
{
    self.reTakeButton.hidden = NO;
    self.deleteButton.hidden = NO;
    self.photoImageView.userInteractionEnabled = NO;
}

- (void)addPhoto:(UIImage *)photo
{
    [self.photoImageView setImage:photo];
}

#pragma mark Privite Method

- (void)takePhoto
{
    [self.delegate takePhoto];
}

#pragma mark IBAction Method

- (IBAction)reTakeAction:(id)sender {
    [self.delegate takePhoto];
}

- (IBAction)deleteAction:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"删除照片" message:@"确定删除照片？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        [self.photoImageView setImage:nil];
        self.photoImageView.userInteractionEnabled = YES;
        self.reTakeButton.hidden = YES;
        self.deleteButton.hidden = YES;
    }
}

@end
