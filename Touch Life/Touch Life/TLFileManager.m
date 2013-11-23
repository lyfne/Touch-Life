//
//  TLFileManager.m
//  Touch Life
//
//  Created by Apple Club on 13-11-23.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLFileManager.h"
#import "NSArray+Data.h"

static TLFileManager *tlFileManagerInstance;

@interface TLFileManager()

@property (strong, nonatomic) NSMutableArray *noteLists;

@end

@implementation TLFileManager

#pragma mark Privite Method

- (NSMutableArray *)noteLists
{
    if (_noteLists == nil) {
        _noteLists = [[NSMutableArray alloc] initWithArray:[NSArray loadFromFile:kLocalListsFileName key:kLocalListsKey]];
    }
    return _noteLists;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initSetting];
    }
    return self;
}

- (void)initSetting
{
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"FirslLoad"]];
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLoad"];
    if ([number boolValue] == YES) {
        [self firstLoadList];
    }
}

- (void)firstLoadList
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SettingList" ofType:@"plist"];
    NSMutableDictionary *settingData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    [settingData writeToFile:[[docPaths objectAtIndex:0] stringByAppendingString:@"SettingList.plist"] atomically:YES];
}

#pragma mark Public Method

+ (TLFileManager *)sharedFileManager
{
    static dispatch_once_t TLFileManagerLock;
    dispatch_once(&TLFileManagerLock, ^{
        tlFileManagerInstance = [[TLFileManager alloc] init];
    });
    
    return tlFileManagerInstance;
}

- (void)serialze
{
    [self.noteLists saveToFile:kLocalListsFileName key:kLocalListsKey atomically:YES];
}

@end
