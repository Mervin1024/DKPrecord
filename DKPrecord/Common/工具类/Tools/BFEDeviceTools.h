//
//  DeviceTools.h
//  CommonLib
//
//  Created by dev on 13-7-15.
//  Copyright (c) 2013年 boxfishedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFEDeviceTools : NSObject

+ (BOOL)isPhone;
+ (BOOL)isPad;
+ (BOOL)is3p5InchPhone;
+ (BOOL)is4InchPhone;
+ (BOOL)is4p7InchPhone;
+ (BOOL)is5p5InchPhone;
+ (BOOL)isSimulator;
+ (BOOL)isTouch;

+ (float)getUIScale;
+ (BOOL)isStatusBarHorizontal;
+ (NSString *)getIdentifier;
+ (BOOL) isChineseLanguageEnv;
+ (NSString *)getMacAddress;
+ (NSString *)getAPPIDFA;

+ (CGRect)getDeviceViewHorizontalFrame;
+ (CGRect)getDeviceViewVeticalFrame;
+ (CGRect)getDeviceViewWithNaviationBarHorizontalFrame;
+ (CGFloat)getDeviceViewHorizontalWidth;
+ (CGFloat)getDeviceViewHorizontalHeight;

+ (void)checkIsAllowNotification;

@end
