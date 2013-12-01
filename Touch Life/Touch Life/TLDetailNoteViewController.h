//
//  TLDetailNoteViewController.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-28.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLNavigationViewController.h"
#import "TLNote.h"

@interface TLDetailNoteViewController : UIViewController<TLNavigationDelegate>{
    TLNote *showNote;
    BOOL isShowPhoto;
    BOOL isPlaying;
}

@property (strong, nonatomic) TLNavigationViewController *navigationVC;

- (void)showNote:(TLNote *)note;

@end
