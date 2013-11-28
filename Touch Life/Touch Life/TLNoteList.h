//
//  TLNoteList.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-13.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLNote.h"

@interface TLNoteList : NSObject

@property (copy, nonatomic) NSDate *listDate;

+ (TLNoteList *)createNoteList;
- (NSInteger)count;
- (void)addNote:(TLNote *)note;
- (TLNote *)getNoteWithIndex:(int)index;

- (int)getMonth;
- (int)getYear;

@end
