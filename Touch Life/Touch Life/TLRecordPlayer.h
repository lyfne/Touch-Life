//
//  TLRecordPlayer.h
//  Touch Life
//
//  Created by Fan's Mac on 13-12-1.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface TLRecordPlayer : AVAudioPlayer

+ (TLRecordPlayer *)sharedRecordPlayer;
- (void)playRecorwWithName:(NSString *)name withDelegate:(id)delegate;
- (void)playRecord;
- (void)stopRecord;

@end
