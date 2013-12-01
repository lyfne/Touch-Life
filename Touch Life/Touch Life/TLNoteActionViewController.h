//
//  TLNoteActionViewController.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-13.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLPhotoViewController.h"

@protocol TLNoteActionDelegate

- (void)showPhotoView;
- (void)takePhoto;
- (void)startRecord;
- (void)deletePhoto;

@end

@interface TLNoteActionViewController : UIViewController<TLPhotoDelegate>

@property (weak, nonatomic) id<TLNoteActionDelegate> delegate;
@property (strong, nonatomic) TLPhotoViewController *photoVC;

- (void)setPhotoButtonTitle:(NSString *)title;
- (void)showEditButton;
- (void)addPhoto:(UIImage *)photo;

@end
