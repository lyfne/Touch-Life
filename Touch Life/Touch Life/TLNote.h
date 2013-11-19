//
//  TLNote.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-13.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLNote : NSObject{
    BOOL withPhoto;
    BOOL withRecord;
}

@property (copy, nonatomic) NSDate *detailDate;
@property (copy, nonatomic) NSString *detailNote;
@property (copy, nonatomic) UIImage *detailImage;
@property (copy, nonatomic) NSString *recordName;

+ (TLNote *)createNoteWithDate:(NSDate *)date note:(NSString *)note;
- (void)addImageToNote:(UIImage *)image;
- (void)addRecordToNote:(NSString *)name;

@end
