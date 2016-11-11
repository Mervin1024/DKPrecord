//
//  BFECommonTools.h
//  operationalMaster
//
//  Created by 何何敬敬 on 2016/10/11.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BFECommonTools : NSObject

+ (NSString*)getAppDocumentFolder;
+ (NSString*)getAppClassPrefix;

+ (BOOL)isEnterpriseVersion;
+ (NSString*)getBundleId;
+ (BOOL)isAfterIOS8;
+ (BOOL)isAfterIOS9;


+ (BOOL)isEmptyObject:(id)object;

+ (BOOL)saveData:(NSData*)data toFile:(NSString*)filePath;

+ (void)showMsgBox:(NSString*)msgText;
+ (void)showMsgBox:(NSString*)msgText title:(NSString*)title;
+ (void)showMsgBox:(NSString*)msgText title:(NSString*)title cancelText:(NSString*)cancelText;

+ (NSArray*)getShuffledArray:(NSArray*)sourceArray;

+ (void)resetViewFrame:(UIView *)view frameOption:(FrameOptions)option value:(CGFloat)value;

+ (NSString *)getPingFangFontNameByName:(NSString *)fontName;

+ (UIFont *)getSanfranciscoSemiboldFontWithSize:(CGFloat)size;
+ (UIFont *)getSanfranciscoLightFontWithSize:(CGFloat)size;
+ (UIFont *)getSanfranciscoThinFontWithSize:(CGFloat)size;
+ (UIFont *)getSanfranciscoMediumFontWithSize:(CGFloat)size;

+ (void)setExtraCellLineHidden: (UITableView *)tableView;

#pragma mark 根据设备类型 自动获取 图片名和图片类型

+ (NSString *)getImageNameByDeviceBasedOnPad:(NSString *)imageName;
+ (NSString *)getImageNameByDeviceBasedOnPad:(NSString *)imageName
                               handleIPhone4:(BOOL)handle;
+ (NSString *)getImageNameByDeviceBasedOnPad:(NSString *)imageName
                        handleTeacherVersion:(BOOL)handle;

@end
