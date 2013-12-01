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
    [self initShadow];
    [self initPhotoView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Init Method

- (void)initPhotoView
{
    self.photoVC = [self.storyboard instantiateViewControllerWithIdentifier:kTLPhotoViewController];
    [self.photoVC.view setX:0 Y:50 Width:320 Height:216];
    self.photoVC.delegate = self;
    [self.view addSubview:self.photoVC.view];
}

- (void)initShadow
{
    [self.view.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.view.layer setShadowRadius:2];
    [self.view.layer setShadowOpacity:0.7f];
    [self.view.layer setShadowColor:[UIColor blackColor].CGColor];
}

#pragma mark IBAction Method

- (IBAction)takePhotoAction:(id)sender {
    [self.delegate showPhotoView];
}

- (IBAction)recordAction:(id)sender {
    [self.delegate startRecord];
}

#pragma mark Public Method

- (void)setPhotoButtonTitle:(NSString *)title
{
    [self.takePhotoButton setTitle:title forState:UIControlStateNormal];
}

- (void)addPhoto:(UIImage *)photo
{
    [self.photoVC addPhoto:photo];
}

#pragma mark TLPhotoDelegate

- (void)takePhoto
{
    [self.delegate takePhoto];
}

- (void)deletePhoto
{
    [self.delegate deletePhoto];
}

@end
