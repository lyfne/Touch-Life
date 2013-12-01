//
//  TLRecordPlayer.m
//  Touch Life
//
//  Created by Fan's Mac on 13-12-1.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLRecordPlayer.h"

static TLRecordPlayer *musicPlayerInstance;

@implementation TLRecordPlayer

+ (TLRecordPlayer *)sharedRecordPlayer
{
    static dispatch_once_t TLFileManagerLock;
    dispatch_once(&TLFileManagerLock, ^{
        musicPlayerInstance = [[TLRecordPlayer alloc] init];
    });
    
    return musicPlayerInstance;
}

- (void)playRecorwWithName:(NSString *)name withDelegate:(id)delegate
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.caf",name]];
    NSURL* url = [NSURL fileURLWithPath:uniquePath];
    
    musicPlayerInstance = [musicPlayerInstance initWithContentsOfURL:url error:nil];
    musicPlayerInstance.delegate = delegate;
    musicPlayerInstance.volume = 1.0f;
    [musicPlayerInstance prepareToPlay];
    [musicPlayerInstance play];
}

- (void)playRecord
{
    [musicPlayerInstance play];
}

- (void)stopRecord
{
    [musicPlayerInstance stop];
}

@end
