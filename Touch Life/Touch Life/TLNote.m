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
    [coder encodeObject:self.detailImage forKey:kDetailImage];
    [coder encodeObject:self.recordName forKey:kRecordName];
}

- (id)initWithCoder:(NSCoder*)coder
{
    self = [super init];
    
    if (self) {
        self.detailDate = [coder decodeObjectForKey:kDetailDate];
        self.detailNote = [coder decodeObjectForKey:kDetailNote];
        self.detailImage = [coder decodeObjectForKey:kDetailImage];
        self.recordName = [coder decodeObjectForKey:kRecordName];
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


- (void)addImageToNote:(UIImage *)image
{
    withPhoto = YES;
    self.detailImage = image;
}

- (void)addRecordToNote:(NSString *)name
{
    withRecord = YES;
    self.recordName = name;
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
