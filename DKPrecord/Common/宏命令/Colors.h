//
//  Colors.h
//  wallpaper-elf
//
//  Created by mervin on 16/7/12.
//  Copyright © 2016年 mervin. All rights reserved.
//

#pragma once

#define DefaultLinkColor @"#001cfe"

#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define ColorWithAlpha(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define Color_White     [UIColor whiteColor]        // 1.0 white
#define Color_Black     [UIColor blackColor]        // 0.0 white
#define Color_DarkGray  [UIColor darkGrayColor]     // 0.333 white
#define Color_LightGray [UIColor lightGrayColor]    // 0.667 white
#define Color_Gray      [UIColor grayColor]         // 0.5 white
#define Color_Red       [UIColor redColor]          // 1.0, 0.0, 0.0 RGB
#define Color_Green     [UIColor greenColor]        // 0.0, 1.0, 0.0 RGB
#define Color_Blue      [UIColor blueColor]         // 0.0, 0.0, 1.0 RGB
#define Color_Cyan      [UIColor cyanColor]         // 0.0, 1.0, 1.0 RGB
#define Color_Yellow    [UIColor yellowColor]       // 1.0, 1.0, 0.0 RGB
#define Color_Magenta   [UIColor magentaColor]      // 1.0, 0.0, 1.0 RGB
#define Color_Orange    [UIColor orangeColor]       // 1.0, 0.5, 0.0 RGB
#define Color_Purple    [UIColor purpleColor]       // 0.5, 0.0, 0.5 RGB
#define Color_Brown     [UIColor brownColor]        // 0.6, 0.4, 0.2 RGB
#define Color_Clear     [UIColor clearColor]

#define GRAYCOLOR(c) COLOR(c,c,c)
#define BACKGROUND_PINK_COLOR COLOR(255, 236, 238)
#define NAVIGATION_TINT_COLOR COLOR(131, 54, 53)

#define LightBlueColor COLOR(21,125,251)
#define LightBlueColor1 COLOR(15, 98, 254)

#define NewBlueColor COLOR(23, 126, 250)
#define NewPurpleColor COLOR(204, 115, 225)
#define NewYellowColor COLOR(240, 184, 0)
#define AchievementYellowColor COLOR(255, 216, 87)
#define NewBlackColor GRAYCOLOR(50)
#define NewYellowBorderColor COLOR(240, 216, 87)

#define RightAnswerItemColor COLOR(102, 177, 50)
#define WrongAnswerItemColor COLOR(255, 39, 18)

#define BlueStyleColor COLOR(74, 144, 266)
#define RedStyleColor COLOR(255, 97, 66)
#define GrayColor GRAYCOLOR(143)
