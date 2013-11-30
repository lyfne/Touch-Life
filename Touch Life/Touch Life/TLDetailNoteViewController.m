//
//  TLDetailNoteViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-28.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLDetailNoteViewController.h"
#import "TLFileManager.h"

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

#pragma mark Public Method

- (void)showNote:(TLNote *)note
{
    showNote = note;
    [self.navigationVC setHeaderTitle:[NSString stringWithFormat:@"%d月%d日",[showNote getMonth],[showNote getDay]]];
    [self.bgImageView setImage:[[TLFileManager sharedFileManager] blurryImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",[showNote getMonth]]] withBlurLevel:0.3f]];
    
    self.detailText.text = showNote.detailNote;
}

#pragma mark TLNavigationDelegate

- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
