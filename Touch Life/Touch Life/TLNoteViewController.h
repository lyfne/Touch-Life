//
//  TLNoteViewController.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-12.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TLNavigationViewController.h"
#import "TLNoteActionViewController.h"
#import "TLRecordViewController.h"
#import "TLNote.h"

@interface TLNoteViewController : UIViewController<TLNavigationDelegate,TLNoteActionDelegate,TLRecordDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>{
    BOOL keyboardWasShown;
    UIImageView *photoImageView;
    UIImage *savedImage;
}

@property (strong, nonatomic) TLRecordViewController *recordVC;
@property (strong, nonatomic) TLNavigationViewController *navigationVC;
@property (strong, nonatomic) TLNoteActionViewController *noteActionVC;

@end
