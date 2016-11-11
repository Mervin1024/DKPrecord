//
//  Macros.h
//  boxfish-english
//
//  Created by echo on 14-11-19.
//  Copyright (c) 2014年 boxfish. All rights reserved.
//

#pragma once

//添加快速构建weakSelf的宏
#define WS(weakSelf)                __weak __typeof(&*self)weakSelf = self;
#define SS(strongSelf, weakSelf)    __strong __typeof(&*weakSelf)strongSelf = weakSelf;
//定义构造单例的宏
#define SharedInstanceInterfaceBuilder(ClassName) \
+ (ClassName*)sharedInstance;

#define SharedInstanceBuilder(ClassName) \
+ (ClassName*)sharedInstance\
{\
static dispatch_once_t onceToken;\
static ClassName* instance;\
dispatch_once(&onceToken, ^{\
instance = [[ClassName alloc] init];\
});\
return instance;\
}

// 横屏设定的宏
#define SetTeacherScreenOrientation \
- (BOOL)shouldAutorotate\
{\
    return YES;\
}\
\
- (UIInterfaceOrientationMask)supportedInterfaceOrientations\
{\
    return UIInterfaceOrientationMaskLandscape;\
}\

// 混合设定的宏
#define SetPhoneMixScreenOrientation \
- (BOOL)shouldAutorotate\
{\
    return YES;\
}\
\
- (UIInterfaceOrientationMask)supportedInterfaceOrientations\
{\
    if ([BFEDeviceTools isPhone]) {\
        return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);\
    } else {\
        return UIInterfaceOrientationMaskLandscape;\
    }\
}\
// 竖屏设定的宏
#define SetStudentScreenOrientation \
- (BOOL)shouldAutorotate\
{\
    return YES;\
}\
\
- (UIInterfaceOrientationMask)supportedInterfaceOrientations\
{\
    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);\
}\


#define SetBlackBackGroundWhiteForgroundStyle \
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];\
[self.navigationController.navigationBar setBarTintColor:NewBlackColor];\
NSDictionary* textAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]}; \
[self.navigationController.navigationBar setTitleTextAttributes:textAttributes];\
[[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:0];

#define SetWhiteBackGroundBlackForgroundStyle \
[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];\
[self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];\
NSDictionary* textAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]}; \
[self.navigationController.navigationBar setTitleTextAttributes:textAttributes];\
[[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:0];

#define SetBlackBackGroundWhiteForgroundStyleWhenViewWillAppear \
- (void)viewWillAppear:(BOOL)animated\
{\
    [super viewWillAppear:animated];\
    SetBlackBackGroundWhiteForgroundStyle\
}

#define SetWhiteBackGroundBlackForgroundStyleWhenViewWillAppear \
- (void)viewWillAppear:(BOOL)animated\
{\
    [super viewWillAppear:animated];\
    SetWhiteBackGroundBlackForgroundStyle\
}\

#define StrokeView(view) StrokeViewWithColorAndWidth(view, [UIColor redColor], 1)

#define StrokeViewWithColorAndWidth(view, color, width) \
if(DebugMode) {\
view.layer.borderColor = color.CGColor;\
view.layer.borderWidth = width;\
}

// 测试UI空间的布局用，添加边框
#define AddBorderToView(view) \
view.layer.borderWidth = 1; \
view.layer.borderColor = COLOR(arc4random()%256, arc4random()%256, arc4random()%256).CGColor;

// 用来处理大部分网络请求失败回调
#define MERHTTPRequestFaild(string)\
NSDictionary *dic = [BFEHTTPServerManager parseObjectFromRequest:bfeHttpServer];\
NSString *msg = dic[@"returnMsg"]?:bfeHttpServer.error.localizedDescription;\
NSLog(@"==== %@  ：  %@",string,msg);\
NSLog(@"==== requestFaildUrl  ：  %@",bfeHttpServer.urlString);\
if (msg)\
[AutoRemoveMessageView show:msg];\


