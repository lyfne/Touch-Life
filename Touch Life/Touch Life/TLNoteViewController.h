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
#import "TLNote.h"

@interface TLNoteViewController : UIViewController<TLNavigationDelegate,TLNoteActionDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,AVAudioRecorderDelegate>{
    BOOL keyboardWasShown;
    AVAudioRecorder *recorder;
    NSMutableDictionary *recordSetting;
    NSString *recorderFilePath;
}

@property (strong, nonatomic) TLNavigationViewController *navigationVC;
@property (strong, nonatomic) TLNoteActionViewController *noteActionVC;

@end
