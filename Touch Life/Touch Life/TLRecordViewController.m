//
//  TLRecordViewController.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-19.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLRecordViewController.h"

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

@interface TLRecordViewController ()

@property (weak, nonatomic) IBOutlet UIView *actionView;
@property (weak, nonatomic) IBOutlet UIImageView *recordImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UIImageView *playButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *playView;
@property (weak, nonatomic) IBOutlet UILabel *playSumTimeLabel;

@end

@implementation TLRecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.5f animations:^{
        if (playOrRecord) {
            [self.playView setY:105];
        }else{
            [self.actionView setY:105];
        }
    }];
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

#pragma mark Init Method

- (void)initView
{
    recordTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addTime) userInfo:nil repeats:YES];
    time = 0;
    [self startAnimation];
}

- (void)initShadow
{
    [self.actionView.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.actionView.layer setShadowRadius:2];
    [self.actionView.layer setShadowOpacity:0.7f];
    [self.actionView.layer setShadowColor:[UIColor blackColor].CGColor];
    
    [self.playView.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.playView.layer setShadowRadius:2];
    [self.playView.layer setShadowOpacity:0.7f];
    [self.playView.layer setShadowColor:[UIColor blackColor].CGColor];
}

#pragma mark Public Method

- (void)setPlay:(BOOL)play
{
    playOrRecord = play;
}

- (void)startRecording
{
    [self initView];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = nil;
    [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
    if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
    [audioSession setActive:YES error:&err];
    err = nil;
    if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
    }
    
    recordSetting = [[NSMutableDictionary alloc] init];
    [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:8000.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *caldate = [now description];
    recorderFilePath = [NSString stringWithFormat:@"%@/%@.caf",DOCUMENTS_FOLDER,caldate];
    
    NSURL *url = [NSURL fileURLWithPath:recorderFilePath];
    err = nil;
    recorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&err];
    if(!recorder){
        NSLog(@"recorder: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
                                   message: [err localizedDescription]
                                  delegate: nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [recorder setDelegate:self];
    [recorder prepareToRecord];
    recorder.meteringEnabled = YES;
    
    BOOL audioHWAvailable = audioSession.isInputAvailable;
    if (! audioHWAvailable) {
        UIAlertView *cantRecordAlert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
                                   message: @"Audio input hardware not available"
                                  delegate: nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [cantRecordAlert show];
        return;
    }
    
    [recorder recordForDuration:(NSTimeInterval) 120];
}

- (void)showPlayView
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playAndStopRecord)];
    [self.playButton addGestureRecognizer:tapGesture];
}

#pragma mark IBAction Method

- (IBAction)finishAction:(id)sender {
    [recorder stop];
    [UIView animateWithDuration:0.5f animations:^{
        [self.actionView setY:-self.actionView.frame.size.height];
    }completion:^(BOOL finish){
        [self.delegate saveRecord];
        [self.delegate backToNoteView];
    }];
}

- (IBAction)cancelAction:(id)sender {
    [self stopRecording];
    [UIView animateWithDuration:0.5f animations:^{
        [self.actionView setY:-self.actionView.frame.size.height];
    }completion:^(BOOL finish){
        [self.delegate backToNoteView];
    }];
}

- (IBAction)deleteRecord:(id)sender {
    
}

- (IBAction)closePlayViewAction:(id)sender {
    [self stopPlay];
    [UIView animateWithDuration:0.5f animations:^{
        [self.playView setY:-self.actionView.frame.size.height];
    }completion:^(BOOL finish){
        [self.delegate backToNoteView];
    }];
}

#pragma mark Mini Function

- (void)playAndStopRecord
{
    
}

-(void) startAnimation
{
    CABasicAnimation *rotate;
    rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 2];
    rotate.duration=3.5;      //动画持续时间
    rotate.repeatCount=200;     //动画重复次数
    rotate.autoreverses=NO;  //是否自动重复
    rotate.fillMode = kCAFillModeForwards;
    rotate.removedOnCompletion = NO;
    [self.recordImageView.layer addAnimation:rotate forKey:@"rotatelayer"];
}

- (void)addTime{
    time++;
    if (time==120) {
        [recordTimer invalidate];
        [recorder stop];
        [self.delegate backToNoteView];
        time = 0;
    }else{
        self.timeLabel.text = [NSString stringWithFormat:@"%d:%.2i",time/60,time%60];
    }
}

- (void) stopRecording{
    [recorder stop];
    NSURL *url = [NSURL fileURLWithPath: recorderFilePath];
    NSError *err = nil;
    NSData *audioData = [NSData dataWithContentsOfFile:[url path] options: 0 error:&err];
    if(!audioData){
        NSLog(@"audio data: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
    }
    
    NSFileManager *fm = [NSFileManager defaultManager];
    err = nil;
    [fm removeItemAtPath:[url path] error:&err];
    if(err){
        NSLog(@"File Manager: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
    }
}

- (void)stopPlay
{
    
}

#pragma mark AVRecordDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *) aRecorder successfully:(BOOL)flag
{
    NSLog (@"audioRecorderDidFinishRecording:successfully:");
}

@end
