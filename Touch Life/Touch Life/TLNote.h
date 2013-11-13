//
//  TLNote.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-13.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLNote : NSObject

@property (copy, nonatomic) NSDate *date;
@property (copy, nonatomic) NSString *note;
@property (copy, nonatomic) UIImage *detailImage;

+ (TLNote *)createNoteWithDate:(NSDate *)date note:(NSString *)note image:(UIImage *)image;

@end
