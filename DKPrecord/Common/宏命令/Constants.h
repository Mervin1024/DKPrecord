//
//  Constants.h
//  boxfish-english
//
//  Created by echo on 14-11-18.
//  Copyright (c) 2014年 boxfish. All rights reserved.
//

#pragma once

#import "Colors.h"
#import "Enums.h"
#import "Strings.h"
#import "Macros.h"
#import "ViewHelper.h"
#import "KeyConstants.h"
#import "MessageConstants.h"
//test
#import "AppDelegate.h"
#import "BFECommonTools.h"
#import "BFEDeviceTools.h"
#import "Masonry.h"


#define CachedDataFolder [[NSHomeDirectory() stringByAppendingPathComponent:@"/Library"] stringByAppendingPathComponent:@"/Caches/data"]

//以下定义Keychain中的键值
#define BoxfisheduKeyInKeyChain [[[NSBundle mainBundle] infoDictionary] objectForKey:@"BoxfisheduKeyInKeyChain"]
#define KeyUserName @"com.boxfishedu.app.username"

#define Heiti_L(fontSize) [UIFont fontWithName:@"STHeitiSC-Light" size:fontSize]
#define Sanfrancisco_L(fontSize) ([BFECommonTools getSanfranciscoLightFontWithSize:fontSize])

#define CellTextLabelDefaultFont ([BFEDeviceTools is4InchPhone] ? [UIFont systemFontOfSize:17] : [UIFont systemFontOfSize:LayoutForFitIPhone6P(17 * 0.854, 17)])

#define Helvetica_L(fontSize) [UIFont fontWithName:@"Helvetica-Light" size:fontSize]
#define HelveticaNeue_L(fontSize) [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize]
#define HelveticaNeue_M(fontSize) [UIFont fontWithName:@"HelveticaNeue-Medium" size:fontSize]
#define HelveticaNeue(fontSize) [UIFont fontWithName:@"HelveticaNeue" size:fontSize]

#define PingFang_T(fontSize) [UIFont fontWithName:([BFECommonTools getPingFangFontNameByName:@"PingFangSC-Thin"]) size:fontSize]
#define PingFang_L(fontSize) [UIFont fontWithName:([BFECommonTools getPingFangFontNameByName:@"PingFangSC-Light"]) size:fontSize]
#define PingFang_R(fontSize) [UIFont fontWithName:([BFECommonTools getPingFangFontNameByName:@"PingFangSC-Regular"]) size:fontSize]
#define PingFang_M(fontSize) [UIFont fontWithName:([BFECommonTools getPingFangFontNameByName:@"PingFangSC-Medium"]) size:fontSize]
#define PingFang_U(fontSize) [UIFont fontWithName:([BFECommonTools getPingFangFontNameByName:@"PingFangSC-UItralight"]) size:fontSize]
#define PingFang_S(fontSize) [UIFont fontWithName:([BFECommonTools getPingFangFontNameByName:@"PingFangSC-Semibold"]) size:fontSize]

#define SanFranciscoDisplay_R(fontSize) [UIFont systemFontOfSize:fontSize]
#define SanFranciscoDisplay_B(fontSize) [UIFont boldSystemFontOfSize:fontSize]
#define SanFranciscoDisplay_L(fontSize) [BFECommonTools getSanfranciscoLightFontWithSize:fontSize]
#define SanFranciscoDisplay_T(fontSize) [BFECommonTools getSanfranciscoThinFontWithSize:fontSize]
#define SanFranciscoDisplay_M(fontSize) [BFECommonTools getSanfranciscoMediumFontWithSize:fontSize]
#define SanFranciscoDisplay_S(fontSize) [BFECommonTools getSanfranciscoSemiboldFontWithSize:fontSize]

#define LevelList @[@"小学",@"初中",@"高中",@"托福",@"精选"]
#define LevelListText @[@"小 学",@"初 中",@"高 中",@"托 福",@"精 选"]

#define DeviceToolsIsPad [BFEDeviceTools isPad]
#define DeviceIpadAndOther(iPadValue,otherValue) (DeviceToolsIsPad ? (iPadValue) : (otherValue))
#define DeviceiPhone6And6PAndiPad(valueForIPhone6,valueForIphone6P,valueForiPad) (DeviceToolsIsPad ? (valueForiPad) : ([BFEDeviceTools is5p5InchPhone] ? (valueForIphone6P) : (valueForIPhone6)))
#define BFEUIScale [BFEDeviceTools getUIScale]

//以下定义数据库相关的版本
#define WordListDbVersion 1
#define WordListLevelDbVersion 1


#define Language(string) NSLocalizedString(@#string,nil)
