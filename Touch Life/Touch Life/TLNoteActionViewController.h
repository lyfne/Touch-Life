//
//  TLNoteActionViewController.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-13.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLNoteActionDelegate

- (void)takePhoto;

@end

@interface TLNoteActionViewController : UIViewController

@property (strong, nonatomic) id<TLNoteActionDelegate> delegate;

@end
