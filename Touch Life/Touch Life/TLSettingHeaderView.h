//
//  TLSettingHeaderView.h
//  Touch Life
//
//  Created by Apple Club on 13-11-23.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLSettingHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *headerLabel;

- (void)setHeaderTitle:(NSString *)title;

@end
