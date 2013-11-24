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
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"FirstLoad"]];
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLoad"];
    if ([number boolValue] == YES) {
        [self firstLoadList];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstLoad"];
    }
}

- (void)firstLoadList
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"SettingList" ofType:@"plist"];
    NSMutableDictionary *settingData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    [settingData writeToFile:[[docPaths objectAtIndex:0] stringByAppendingString:@"/SettingList.plist"] atomically:YES];
}

- (NSString *)getFilePathWithName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingString:[@"/" stringByAppendingString:name]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return path;
    }else
    {
        NSLog(@"No File Exists");
        return nil;
    }
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

- (void)setBgImage:(NSString *)imageName
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self getFilePathWithName:@"SettingList.plist"]];
    [dic setObject:imageName forKey:kBgImageKey];
    [dic writeToFile:[self getFilePathWithName:@"SettingList.plist"] atomically:YES];
}

- (NSString *)getBgImageName
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self getFilePathWithName:@"SettingList.plist"]];
    return [dic objectForKey:kBgImageKey];
}

- (void)setPinCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self getFilePathWithName:@"SettingList.plist"]];
    [dic setObject:code forKey:kPinKey];
    [dic writeToFile:[self getFilePathWithName:@"SettingList.plist"] atomically:YES];
}

- (NSString *)getPinCode
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self getFilePathWithName:@"SettingList.plist"]];
    return [dic objectForKey:kPinKey];
}

@end
