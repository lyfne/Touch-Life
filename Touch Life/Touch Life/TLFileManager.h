//
//  TLFileManager.h
//  Touch Life
//
//  Created by Apple Club on 13-11-23.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLNoteList.h"
#import "TLNote.h"

@interface TLFileManager : NSObject

+ (TLFileManager *)sharedFileManager;
- (void)serialze;
- (NSMutableArray *)getListArrayWithYear:(int)year;
- (TLNoteList *)getListWithYear:(int)year andMonth:(int)month;
- (TLNoteList *)createNewList:(int)year andMonth:(int)month;
- (void)saveNote:(TLNote *)note;
- (int)getMinYear;
- (int)getCountOfYear:(int)year;

- (void)setBgImage:(NSString *)imageName;
- (NSString *)getBgImageName;
- (void)setPinCode:(NSString *)code;
- (NSString *)getPinCode;

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

@end
