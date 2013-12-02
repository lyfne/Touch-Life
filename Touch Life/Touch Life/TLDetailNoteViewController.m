//
//  TLDetailNoteViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-28.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLDetailNoteViewController.h"
#import "TLFileManager.h"
#import "TLRecordPlayer.h"

#define kWithOutPhotoOffset 204
#define kPhotoShowHeight 468

@interface TLDetailNoteViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UITextView *detailText;
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UIView *textAndActionView;
@property (weak, nonatomic) IBOutlet UIImageView *textViewBgImageView;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *pinButton;

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
    isShowPhoto = NO;
    isPlaying = NO;
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

#pragma mark IBAction Method

- (IBAction)playRecord:(id)sender {
    if (isPlaying == NO) {
        [[TLRecordPlayer sharedRecordPlayer] playRecorwWithName:showNote.recordName withDelegate:self];
        [self.recordButton setTitle:@"停止播放" forState:UIControlStateNormal];
    }else{
        [[TLRecordPlayer sharedRecordPlayer] stopRecord];
        [self.recordButton setTitle:@"播放音频" forState:UIControlStateNormal];
    }
    isPlaying = !isPlaying;
}

- (IBAction)lockAction:(id)sender {
    if ([showNote withPinOrNot]) {
        [showNote addPinCode:NO];
        [self.pinButton setTitle:@"上锁" forState:UIControlStateNormal];
    }else{
        [showNote addPinCode:YES];
        [self.pinButton setTitle:@"解锁" forState:UIControlStateNormal];
    }
}

- (IBAction)shareAction:(id)sender {
    UIActionSheet *sheet;
    sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"分享到人人",@"分享到微博",@"分享到QQ空间", nil];
    
    sheet.tag = 255;
    [sheet showInView:self.view];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        switch (buttonIndex) {
            case 0:
                return;
            case 1:{
                UIAlertView *alertView= [[UIAlertView alloc] initWithTitle:@"分享" message:@"分享到人人成功" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [alertView show];
            }
                break;
            case 2:{
                UIAlertView *alertView= [[UIAlertView alloc] initWithTitle:@"分享" message:@"分享到微博成功" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [alertView show];
            }
                break;
            case 3:{
                UIAlertView *alertView= [[UIAlertView alloc] initWithTitle:@"分享" message:@"分享到QQ空间成功" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
                [alertView show];
            }
                break;
        }
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
    if ([showNote withImage] == NO) {
        [self.textAndActionView setY:50];
        [self.textAndActionView setHeight:self.textAndActionView.frame.size.height+kWithOutPhotoOffset];
        [self.textViewBgImageView setHeight:self.textAndActionView.frame.size.height];
        [self.detailText setHeight:self.detailText.frame.size.height+kWithOutPhotoOffset];
    }else{
        [self.detailImage setImage:[UIImage imageWithData:showNote.imageData]];
    }
    [self initImageView];
    
    if([showNote withRecord] == NO){
        self.recordButton.hidden = YES;
    }
    
    if (![[[TLFileManager sharedFileManager] getPinCode] isEqualToString:kPinCodeStr]) {
        if ([showNote withPinOrNot]) {
            [self.pinButton setTitle:@"解锁" forState:UIControlStateNormal];
        }else{
            [self.pinButton setTitle:@"上锁" forState:UIControlStateNormal];
        }
    }
}

#pragma mark TLNavigationDelegate

- (void)popBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag{
    [self.recordButton setTitle:@"播放音频" forState:UIControlStateNormal];
}

@end
