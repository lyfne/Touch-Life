//
//  TLNote.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-13.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLNote : NSObject

@property (copy, nonatomic) NSDate *detailDate;
@property (copy, nonatomic) NSString *detailNote;
@property (copy, nonatomic) NSString *recordName;
@property (copy, nonatomic) NSData *imageData;

+ (TLNote *)createNoteWithDate:(NSDate *)date note:(NSString *)note;
- (void)addImageData:(NSData *)data;
- (void)addRecordToNote:(NSString *)name;
- (BOOL)withImage;
- (BOOL)withRecord;

- (int)getMonth;
- (int)getYear;
- (int)getDay;

@end
