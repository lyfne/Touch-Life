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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
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
}

#pragma mark Public Method

- (void)startRecording
{
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
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityLow] forKey:AVEncoderAudioQualityKey];
    
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

#pragma mark Mini Function

-(void) startAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    self.recordImageView.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}

-(void)endAnimation
{
    angle += 10;
    [self startAnimation];
}

- (void)addTime{
    time++;
    if (time==120) {
        [recordTimer invalidate];
        [recorder stop];
        [self.delegate backToNoteView];
        time = 0;
    }else{
        self.timeLabel.text = [NSString stringWithFormat:@"%d:%.1i",time/60,time%60];
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

#pragma mark AVRecordDelegate

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *) aRecorder successfully:(BOOL)flag
{
    NSLog (@"audioRecorderDidFinishRecording:successfully:");
}

@end
