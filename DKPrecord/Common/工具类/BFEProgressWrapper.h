//
//  ProgressWrapper.h
//  Metown
//
//  Created by user on 11-8-14.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

//MBProgressHUD的包装类，便于使用
@interface BFEProgressWrapper : NSObject <MBProgressHUDDelegate> {
    MBProgressHUD *_progress;
}

@property (nonatomic, strong) MBProgressHUD *progress;
//@property (nonatomic, copy) void(^wantToCancel)();

SharedInstanceInterfaceBuilder(BFEProgressWrapper)

- (void)addloadingAnimation:(UIView*)superView;
- (void)addloadingAnimation:(UIView*)superView andTitle:(NSString *)title;
- (void)addloadingAnimation:(UIView*)superView andTitle:(NSString *)title animated:(BOOL)animated;
- (void)hide;
- (void)setTitle:(NSString *)title;

@end
