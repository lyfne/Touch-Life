//
//  TLFileManager.m
//  Touch Life
//
//  Created by Apple Club on 13-11-23.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <Accelerate/Accelerate.h>
#import "TLFileManager.h"
#import "NSArray+Data.h"

static TLFileManager *tlFileManagerInstance;

@interface TLFileManager()

@property (strong, nonatomic) NSMutableArray *noteLists;

@end

@implementation TLFileManager

#pragma mark Privite Method

- (NSMutableArray *)noteLists
{
    if (_noteLists == nil) {
        _noteLists = [[NSMutableArray alloc] initWithArray:[NSArray loadFromFile:kLocalListsFileName key:kLocalListsKey]];
    }
    return _noteLists;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initSetting];
    }
    return self;
}

- (void)initSetting
{
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"FirstLoad"]];
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLoad"];
    if ([number boolValue] == YES) {
        NSArray *tempMyLists = [NSArray arrayWithObjects:nil];
        [tempMyLists saveToFile:kLocalListsFileName key:kLocalListsKey atomically:YES];
        [self firstLoadList:@"SettingList"];
        [self firstLoadList:@"NoteList"];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:[NSDate date]];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self getFilePathWithName:@"SettingList.plist"]];
        [dic setObject:[NSString stringWithFormat:@"%d",[dateComponent year]] forKey:kMinYearKey];
        [dic writeToFile:[self getFilePathWithName:@"SettingList.plist"] atomically:YES];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstLoad"];
    }
}

- (void)firstLoadList:(NSString *)name
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    NSMutableDictionary *settingData = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    [settingData writeToFile:[[docPaths objectAtIndex:0] stringByAppendingString:[NSString stringWithFormat:@"/%@.plist",name]] atomically:YES];
}

- (NSString *)getFilePathWithName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingString:[@"/" stringByAppendingString:name]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return path;
    }else
    {
        NSLog(@"No File Exists");
        return nil;
    }
}

#pragma mark Public Method

+ (TLFileManager *)sharedFileManager
{
    static dispatch_once_t TLFileManagerLock;
    dispatch_once(&TLFileManagerLock, ^{
        tlFileManagerInstance = [[TLFileManager alloc] init];
    });
    
    return tlFileManagerInstance;
}

- (void)serialze
{
    [self.noteLists saveToFile:kLocalListsFileName key:kLocalListsKey atomically:YES];
}

- (TLNoteList *)getListWithYear:(int)year andMonth:(int)month
{
    for (TLNoteList *list in self.noteLists) {
        if (([list getYear] == year)&&([list getMonth] == month)) {
            return list;
        }
    }
    return nil;
}

- (TLNoteList *)createNewList:(int)year andMonth:(int)month
{
    for (TLNoteList *list in self.noteLists) {
        if (([list getYear] == year)&&([list getMonth] == month)) {
            return list;
        }
    }
    TLNoteList *newList = [TLNoteList createNoteList];
    newList.listDate = [NSDate date];
    [self.noteLists addObject:newList];
    [self serialze];
    return newList;
}

- (void)saveNote:(TLNote *)note
{
    [[self.noteLists lastObject] addNote:note];
    [self serialze];
}

- (int)getMinYear
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self getFilePathWithName:@"SettingList.plist"]];
    return [[dic objectForKey:kMinYearKey] intValue];
}

- (void)setBgImage:(NSString *)imageName
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self getFilePathWithName:@"SettingList.plist"]];
    [dic setObject:imageName forKey:kBgImageKey];
    [dic writeToFile:[self getFilePathWithName:@"SettingList.plist"] atomically:YES];
}

- (NSString *)getBgImageName
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self getFilePathWithName:@"SettingList.plist"]];
    return [dic objectForKey:kBgImageKey];
}

- (void)setPinCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self getFilePathWithName:@"SettingList.plist"]];
    [dic setObject:code forKey:kPinKey];
    [dic writeToFile:[self getFilePathWithName:@"SettingList.plist"] atomically:YES];
}

- (NSString *)getPinCode
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self getFilePathWithName:@"SettingList.plist"]];
    return [dic objectForKey:kPinKey];
}

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    /*
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

@end
