//
//  DeviceTools.m
//  CommonLib
//
//  Created by dev on 13-7-15.
//  Copyright (c) 2013年 boxfishedu. All rights reserved.
//

#import "BFEDeviceTools.h"
#import <AdSupport/AdSupport.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "BFECommonTools.h"

@implementation BFEDeviceTools

+ (BOOL)isPhone {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

+ (BOOL)isPad {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+ (BOOL)is3p5InchPhone {
    return [self toDecideDeviceSize:480];
}

+ (BOOL)is4InchPhone {
    return [self toDecideDeviceSize:568];
}

+(BOOL)is4p7InchPhone {
    return [self toDecideDeviceSize:667];
}

+(BOOL)is5p5InchPhone {
    return [self toDecideDeviceSize:736];
}

+ (BOOL)toDecideDeviceSize:(CGFloat)deviceHeight {
    CGFloat height = MAX(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    return ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && deviceHeight == height);
}

+ (BOOL)isSimulator {
    return ([[[UIDevice currentDevice].model lowercaseString] rangeOfString:@"simulator"].location != NSNotFound);
}

+ (BOOL)isTouch {
    return ([[[UIDevice currentDevice].model lowercaseString] rangeOfString:@"touch"].location != NSNotFound);
}

+ (float)getUIScale {
    if ([self isPhone]) {
        return 0.5f;
    } else {
        return 1.0f;
    }
}

+ (CGRect)getDeviceViewHorizontalFrame {
    if ([BFEDeviceTools isPad]) {
        return CGRectMake(0, 0, 1024, 768);
    } else {
        if ([BFEDeviceTools is3p5InchPhone]) {
            return CGRectMake(0, 0, 960 / 2, 640 / 2);
        } else if ([BFEDeviceTools is4InchPhone]) {
            return CGRectMake(0, 0, 1136 / 2, 640 / 2);
        } else if ([BFEDeviceTools is4p7InchPhone]) {
            return CGRectMake(0, 0, 1334 / 2, 750 / 2);
        } else {
            return CGRectMake(0, 0, 2208 / 3, 1242 / 3);
        }
    }
}

+ (CGRect)getDeviceViewVeticalFrame {
    if ([BFEDeviceTools isPad]) {
        return CGRectMake(0, 0, 768, 1024);
    } else {
        if ([BFEDeviceTools is3p5InchPhone]) {
            return CGRectMake(0, 0, 640 / 2, 960 / 2);
        } else if ([BFEDeviceTools is4InchPhone]) {
            return CGRectMake(0, 0, 640 / 2, 1136 / 2);
        } else if ([BFEDeviceTools is4p7InchPhone]) {
            return CGRectMake(0, 0, 750 / 2, 1334 / 2);
        } else {
            return CGRectMake(0, 0, 1242 / 3, 2208 / 3);
        }
    }
}

+ (CGRect)getDeviceViewWithNaviationBarHorizontalFrame {
    CGRect frame = [BFEDeviceTools getDeviceViewHorizontalFrame];
    frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame) - StatusBarHeight);
    return frame;
}

+ (CGFloat)getDeviceViewHorizontalWidth {
    if ([BFEDeviceTools isPad]) {
        return 1024;
    } else {
        if ([BFEDeviceTools is3p5InchPhone]) {
            return 480;
        } else if ([BFEDeviceTools is4InchPhone]) {
            return 568;
        } else if ([BFEDeviceTools is4p7InchPhone]) {
            return 667;
        } else {
            return 736;
        }
    }
}

+ (CGFloat)getDeviceViewHorizontalHeight {
    if ([BFEDeviceTools isPad]) {
        return 768;
    } else {
        if ([BFEDeviceTools is3p5InchPhone]) {
            return 320;
        } else if ([BFEDeviceTools is4InchPhone]) {
            return 320;
        } else if ([BFEDeviceTools is4p7InchPhone]) {
            return 375;
        } else {
            return 414;
        }
    }
}

+ (BOOL)isStatusBarHorizontal {
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    return (UIInterfaceOrientationLandscapeRight == interfaceOrientation
            || UIInterfaceOrientationLandscapeLeft == interfaceOrientation);
}

+ (NSString*)getIdentifier {
    UIDevice *device = [UIDevice currentDevice];
    if ([device respondsToSelector:@selector(identifierForVendor)] && [NSUUID class]) {
        NSUUID *uuid = [device identifierForVendor];
        return [uuid UUIDString];
    } else {
        return [self getMacAddress];
    }
}

+ (BOOL) isChineseLanguageEnv {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:0];
    BOOL isChineseEnv=NO;
    if(   ([preferredLang rangeOfString:@"zh-Hans"].location != NSNotFound)
       || ([preferredLang rangeOfString:@"zh-Hant"].location != NSNotFound)
       || ([preferredLang rangeOfString:@"zh-HK"].location != NSNotFound)
       || ([preferredLang rangeOfString:@"zh-TW"].location != NSNotFound)
       || ([preferredLang rangeOfString:@"yue-"].location != NSNotFound) ){
        isChineseEnv =YES;
    } else {
        isChineseEnv =NO;
    }
    return isChineseEnv;
}

+ (NSString*)getMacAddress {
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
}

+ (NSString *)getAPPIDFA {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (void)checkIsAllowNotification {
    if ([BFECommonTools isAfterIOS8]) {
        if (![[UIApplication sharedApplication] isRegisteredForRemoteNotifications]) {
            [self showAlertToAllowNotification];
        }
    }else{
        if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes] == UIUserNotificationTypeNone) {
            [self showAlertToAllowNotification];
        }
    }
}

+ (void)showAlertToAllowNotification {
    NSString *title = NSLocalizedString(@"MessageBoxTitle", @"Reminder");
    NSString *msg = @"请到手机-设置-通知-BOXFISH内打开「通知」，以便接收提醒。";
}

@end
