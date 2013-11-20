//
//  TLPhotoViewController.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-20.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLPhotoDelegate

- (void)closePhotoView;

@end

@interface TLPhotoViewController : UIViewController

@property (weak, nonatomic) id<TLPhotoDelegate> delegate;

@end
