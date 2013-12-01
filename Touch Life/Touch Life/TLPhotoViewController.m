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
    withPhoto = NO;
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

- (void)addPhoto:(UIImage *)photo
{
    withPhoto = YES;
    [self.photoImageView setImage:photo];
}

#pragma mark Privite Method

- (void)takePhoto
{
    if (withPhoto == YES) {
        UIActionSheet *sheet;
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"重新拍照",@"删除照片", nil];
        sheet.tag = 255;
        [sheet showInView:self.view];
    }else{
        [self.delegate takePhoto];
    }
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        switch (buttonIndex) {
            case 0:
                return;
            case 1:
                [self.delegate takePhoto];
                break;
            case 2:
                withPhoto = NO;
                [self.delegate deletePhoto];
                [self.photoImageView setImage:nil];
                break;
        }
    }
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
    }
}

@end
