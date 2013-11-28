//
//  TLNavigationViewController.h
//  Touch Life
//
//  Created by Fan's Mac on 13-11-12.
//  Copyright (c) 2013年 Fan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLNavigationDelegate

@optional
- (void)popBack;
- (void)moreAction;
- (void)showMonthView;

@end

@interface TLNavigationViewController : UIViewController

@property (weak, nonatomic) id<TLNavigationDelegate> delegate;

- (void)setBackButtonHidden:(BOOL)hidden;
- (void)setActionButtonHidden:(BOOL)hidden;
- (void)setHeaderTitle:(NSString *)title;
- (void)setActionButtonTitle:(NSString *)title;
- (void)setActionButtonBgImage:(UIImage *)image selectedImage:(UIImage *)selectedImage;
- (void)addGesture;

@end
