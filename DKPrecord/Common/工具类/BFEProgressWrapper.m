//
//  ProgressWrapper.m
//  Metown
//
//  Created by user on 11-8-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BFEProgressWrapper.h"

static BFEProgressWrapper* sharedProgressWrapper = nil;

@implementation BFEProgressWrapper
{
    UITapGestureRecognizer *_tap;
    UIButton *_cancelButton;
}

//单例函数
SharedInstanceBuilder(BFEProgressWrapper)

- (id)init
{
    if ((self = [super init])) {
        _progress = [[MBProgressHUD alloc] initWithFrame:[UIScreen mainScreen].bounds];        
        _progress.delegate = self;
        _progress.opacity = 0.3;
    }
    
    return self;
}

- (void)handleTap:(UITapGestureRecognizer*)tap
{
    [_progress.superview removeGestureRecognizer:_tap];
    _progress.labelText = @"正在取消中...";
    
    [self performSelector:@selector(cancelAction) withObject:nil afterDelay:.1];
}

- (void)cancelAction
{
    [self hide];
}

- (void)addloadingAnimation:(UIView*)superView
{
    [self addloadingAnimation:superView andTitle:nil];
}

- (void)addloadingAnimation:(UIView*)superView andTitle:(NSString *)title
{
    [_progress removeFromSuperview];
    [superView addSubview: _progress];
    _progress.center = CGPointMake(superView.frame.size.width/2, superView.frame.size.height/2);
    
    _progress.labelText = title;
    [superView bringSubviewToFront:_progress];
    [_progress show:YES];
}

- (void)addloadingAnimation:(UIView*)superView andTitle:(NSString *)title animated:(BOOL)animated {
    [_progress removeFromSuperview];
    [superView addSubview: _progress];
    _progress.center = CGPointMake(superView.frame.size.width/2, superView.frame.size.height/2);
    
    _progress.labelText = title;
    [superView bringSubviewToFront:_progress];
    [_progress show:NO];
}

- (void)setTitle:(NSString *)title
{
    _progress.labelText = title;    
}

- (void)hide
{
    [_progress removeGestureRecognizer:_tap];
    [_progress hide:NO];
}

- (void)dealloc
{
    [_progress removeFromSuperview];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    [_progress removeFromSuperview];
}

@end
