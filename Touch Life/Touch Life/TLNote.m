//
//  TLNote.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-13.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLNote.h"

@implementation TLNote

- (void)encodeWithCoder:(NSCoder*)coder
{
    [coder encodeObject:self.detailDate forKey:kDetailDate];
    [coder encodeObject:self.detailNote forKey:kDetailNote];
    [coder encodeObject:self.recordName forKey:kRecordName];
    [coder encodeObject:self.imageData forKey:kImageData];
}

- (id)initWithCoder:(NSCoder*)coder
{
    self = [super init];
    
    if (self) {
        self.detailDate = [coder decodeObjectForKey:kDetailDate];
        self.detailNote = [coder decodeObjectForKey:kDetailNote];
        self.recordName = [coder decodeObjectForKey:kRecordName];
        self.imageData = [coder decodeObjectForKey:kImageData];
    }
    
    return self;
}

+ (TLNote *)createNoteWithDate:(NSDate *)date note:(NSString *)note
{
    TLNote *tlNote = [[TLNote alloc] init];
    tlNote.detailDate = date;
    tlNote.detailNote = note;
    tlNote->withPhoto = NO;
    tlNote->withRecord = NO;
    return tlNote;
}

- (void)addImageData:(NSData *)data
{
    withPhoto = YES;
    self.imageData = data;
}

- (void)addRecordToNote:(NSString *)name
{
    withRecord = YES;
    self.recordName = name;
}

- (BOOL)withImage
{
    return withPhoto;
}

- (BOOL)withRecord
{
    return withRecord;
}

- (int)getYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self.detailDate];
    return [dateComponent year];
}

- (int)getMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self.detailDate];
    return [dateComponent month];
}

- (int)getDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self.detailDate];
    return [dateComponent day];
}

@end
