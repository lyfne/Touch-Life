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

#pragma mark Public Method

- (void)showNote:(TLNote *)note
{
    showNote = note;
    [self.navigationVC setHeaderTitle:[NSString stringWithFormat:@"%d月%d日",[showNote getMonth],[showNote getDay]]];
    [self.bgImageView setImage:[[TLFileManager sharedFileManager] blurryImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",[showNote getMonth]]] withBlurLevel:0.2f]];
}

#pragma mark TLNavigationDelegate

- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
