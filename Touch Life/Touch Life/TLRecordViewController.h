//
//  TLRecordViewController.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-19.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol TLRecordDelegate

- (void)backToNoteView;
- (void)saveRecord:(NSString *)name;

@end

@interface TLRecordViewController : UIViewController<AVAudioRecorderDelegate>{
    AVAudioRecorder *recorder;
    NSMutableDictionary *recordSetting;
    NSString *recorderFilePath;
    NSString *recordFileName;
    NSTimer *recordTimer;
    int time;
    int angle;
    BOOL playOrRecord;
}

@property (weak, nonatomic) id<TLRecordDelegate> delegate;

- (void)startRecording;
- (void)setPlay:(BOOL)play;
- (void)showPlayView;
- (void)playRecord:(NSString *)fileName;

@end
