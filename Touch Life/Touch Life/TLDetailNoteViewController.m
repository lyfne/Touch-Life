//
//  TLDetailNoteViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-28.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLDetailNoteViewController.h"
#import "TLFileManager.h"

#define kWithOutPhotoOffset 204
#define kPhotoShowHeight 468

@interface TLDetailNoteViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UITextView *detailText;
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UIView *textAndActionView;

@end

@implementation TLDetailNoteViewController

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
    [self initNavigationView];
    [self setTextView];
    isShowPhoto = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Init Method

- (void)initNavigationView
{
    self.navigationController.navigationBar.hidden = YES;
    self.navigationVC = [self.storyboard instantiateViewControllerWithIdentifier:kTLNavigationViewController];
    self.navigationVC.delegate = self;
    [self.navigationVC.view setX:0 Y:0];
    [self.navigationVC.view setHeight:50];
    [self.navigationVC setActionButtonHidden:YES];
    [self.view addSubview:self.navigationVC.view];
}

- (void)initShadow
{
    [self.textAndActionView.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.textAndActionView.layer setShadowRadius:2];
    [self.textAndActionView.layer setShadowOpacity:0.7f];
    [self.textAndActionView.layer setShadowColor:[UIColor blackColor].CGColor];
}

- (void)initImageView
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageAction)];
    [self.detailImage addGestureRecognizer:tapGesture];
}

- (void)setTextView
{
    if ([showNote withImage] == NO) {
        [self.textAndActionView setY:50];
        [self.textAndActionView setHeight:self.textAndActionView.frame.size.height+kWithOutPhotoOffset];
        [self.detailText setHeight:self.detailText.frame.size.height+kWithOutPhotoOffset];
    }
}

#pragma mark Privite Method

- (void)tapImageAction
{
    if (isShowPhoto) {
        [UIView animateWithDuration:0.3f animations:^{
            [self.detailImage setHeight:204];
            [self.textAndActionView setY:254];
        }];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            [self.detailImage setHeight:468];
            [self.textAndActionView setY:518];
        }];
    }
    isShowPhoto = !isShowPhoto;
}

#pragma mark Public Method

- (void)showNote:(TLNote *)note
{
    showNote = note;
    [self.navigationVC setHeaderTitle:[NSString stringWithFormat:@"%d月%d日",[showNote getMonth],[showNote getDay]]];
    [self.bgImageView setImage:[[TLFileManager sharedFileManager] blurryImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",[showNote getMonth]]] withBlurLevel:0.3f]];
    
    self.detailText.text = showNote.detailNote;
    self.detailText.font = [UIFont systemFontOfSize:[[[TLFileManager sharedFileManager] getFontSize] floatValue]];
    [self.detailImage setImage:[UIImage imageWithData:showNote.imageData]];
    [self initImageView];
}

#pragma mark TLNavigationDelegate

- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
