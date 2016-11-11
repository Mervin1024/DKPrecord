//
//  ViewHelper.h
//  wallpaper-elf
//
//  Created by mervin on 16/7/29.
//  Copyright © 2016年 mervin. All rights reserved.
//

#pragma once
// UiView 属性
#define WIDTH_FROM_VIEW(UIView) UIView.frame.size.width
#define HEIGHT_FROM_VIEW(UIView) UIView.frame.size.height
#define SIZE_FROM_VIEW(UIView) UIView.frame.size
#define ORIGIN_FROM_VIEW(UIView) UIView.frame.origin
#define ORIGIN_X_FROM_VIEW(UIView) UIView.frame.origin.x
#define ORIGIN_Y_FROM_VIEW(UIView) UIView.frame.origin.y

#define SCREEN_BOUNDS       ([UIScreen mainScreen].bounds)
#define SCREEN_SIZE         ([UIScreen mainScreen].bounds.size)
#define SCREEN_WIDTH        ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT       ([UIScreen mainScreen].bounds.size.height)


#define StatisticReductionConstant 10

#define StatusBarHeight 20
#define NavigationBarHeight 44
#define NavigationAndStatusHeight 64
#define TabBarHeight 49


// 弧度与角度互相转换
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
