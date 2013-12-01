//
//  TLPhotoViewController.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-20.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLPhotoDelegate

- (void)takePhoto;
- (void)deletePhoto;

@end

@interface TLPhotoViewController : UIViewController<UIActionSheetDelegate>{
    BOOL withPhoto;
}

@property (weak, nonatomic) id<TLPhotoDelegate> delegate;

- (void)addPhoto:(UIImage *)photo;

@end
