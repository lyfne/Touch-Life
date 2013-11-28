//
//  TLFileManager.h
//  Touch Life
//
//  Created by Apple Club on 13-11-23.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLFileManager : NSObject

+ (TLFileManager *)sharedFileManager;
- (void)serialze;
- (void)setBgImage:(NSString *)imageName;
- (NSString *)getBgImageName;
- (void)setPinCode:(NSString *)code;
- (NSString *)getPinCode;
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

@end
