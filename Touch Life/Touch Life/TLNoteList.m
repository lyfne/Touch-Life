//
//  TLNoteList.m
//  Touch Life
//
//  Created by Fan's Mac on 13-11-13.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import "TLNoteList.h"

@interface TLNoteList()
@property (strong, nonatomic) NSMutableArray *noteArray;
@end

@implementation TLNoteList
@synthesize noteArray = _noteArray;

- (void)encodeWithCoder:(NSCoder*)coder
{
    [coder encodeObject:self.noteArray forKey:kNoteArrayData];
    [coder encodeObject:self.listDate forKey:kListData];
}

- (id)initWithCoder:(NSCoder*)coder
{
    self = [super init];
    
    if (self) {
        self.noteArray = [coder decodeObjectForKey:kNoteArrayData];
        self.listDate = [coder decodeObjectForKey:kListData];
    }
    
    return self;
}

- (NSMutableArray *)noteArray
{
    if (_noteArray == nil) {
        _noteArray = [[NSMutableArray alloc] init];
    }
    return _noteArray;
}

#pragma mark Public Method

+ (TLNoteList *)createNoteList
{
    return [[TLNoteList alloc] init];
}

- (NSInteger)count
{
    return [self.noteArray count];
}

- (void)addNote:(TLNote *)note
{
    [self.noteArray addObject:note];
}

- (int)getYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self.listDate];
    return [dateComponent year];
}

- (int)getMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:self.listDate];
    return [dateComponent month];
}

@end
