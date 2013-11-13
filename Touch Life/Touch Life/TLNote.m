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
    [coder encodeObject:self.date forKey:kDate];
    [coder encodeObject:self.note forKey:kNote];
    [coder encodeObject:self.detailImage forKey:kDetailImage];
}

- (id)initWithCoder:(NSCoder*)coder
{
    self = [super init];
    
    if (self) {
        self.date = [coder decodeObjectForKey:kDate];
        self.note = [coder decodeObjectForKey:kNote];
        self.detailImage = [coder decodeObjectForKey:kDetailImage];
    }
    
    return self;
}

+ (TLNote *)createNoteWithDate:(NSDate *)date note:(NSString *)note image:(UIImage *)image
{
    TLNote *tlNote = [[TLNote alloc] init];
    
    tlNote.date = date;
    tlNote.note = note;
    tlNote.detailImage = image;
    
    return tlNote;
}

@end
