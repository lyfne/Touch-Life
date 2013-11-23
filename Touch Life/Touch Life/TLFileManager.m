//
//  TLFileManager.m
//  Touch Life
//
//  Created by Apple Club on 13-11-23.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLFileManager.h"

@implementation TLFileManager

- (void)firstLoadList
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SettingList" ofType:@"plist"];
    NSMutableDictionary *settingData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    [settingData writeToFile:[[docPaths objectAtIndex:0] stringByAppendingString:@"SettingList.plist"] atomically:YES];
}

@end
