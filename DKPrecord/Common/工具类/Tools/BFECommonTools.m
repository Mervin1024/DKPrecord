//
//  BFECommonTools.m
//  operationalMaster
//
//  Created by 何何敬敬 on 2016/10/11.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import "BFECommonTools.h"
#import "BFEPathTools.h"

@implementation BFECommonTools

+ (NSString*)getAppDocumentFolder
{
    return [[self getAppClassPrefix] lowercaseString];
}

+ (NSString*)getAppClassPrefix
{
    return @"AppClassPrefix";
}

+ (BOOL)isEnterpriseVersion
{
    NSString *bundleId = [[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"];
    return [bundleId hasPrefix:@"com.boxfish."];
}


+ (NSString*)getBundleId
{
    NSString *identifier = [[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"];
    return identifier;
}

+ (BOOL)isAfterIOS8
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0;
}

+ (BOOL)isAfterIOS9
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0;
}


+ (BOOL)isEmptyObject:(id)object
{
    return (!object || [object isEqual:[NSNull null]]);
}


+ (BOOL)saveData:(NSData*)data toFile:(NSString*)filePath
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSString *parentPath = [filePath stringByDeletingLastPathComponent];
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:parentPath withIntermediateDirectories:YES attributes:nil error:&error]; //Create folder
        NSLog(@"create error is %@", error);
    } else {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        NSLog(@"create error is %@", error);
    }
    
    BOOL ret = [data writeToFile:filePath atomically:YES];
    return ret;
}


+ (void)showMsgBox:(NSString*)msgText title:(NSString*)title cancelText:(NSString*)cancelText
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[UIAlertView alloc]
          initWithTitle:title
          message:msgText
          delegate:nil
          cancelButtonTitle:cancelText
          otherButtonTitles:nil]
         show];
    });
}

+ (void)showMsgBox:(NSString*)msgText title:(NSString*)title
{
    [BFECommonTools showMsgBox:msgText title:title cancelText:@"OK"];
}

+ (void)showMsgBox:(NSString*)msgText
{
    [BFECommonTools showMsgBox:msgText title:nil];
}

#pragma mark 将数组乱序
+ (NSArray*)getShuffledArray:(NSArray*)sourceArray
{
    return [sourceArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return arc4random() % 2;
    }];
}

+ (void)resetViewFrame:(UIView *)view frameOption:(FrameOptions)option value:(CGFloat)value
{
    CGRect frame = view.frame;
    switch (option) {
        case FrameOptionsX:
            frame.origin.x = value;
            break;
        case FrameOptionsY:
            frame.origin.y = value;
            break;
        case FrameOptionsWidth:
            frame.size.width = value;
            break;
        case FrameOptionsHeight:
            frame.size.height = value;
            break;
        default:
            break;
    }
    view.frame = frame;
}

+ (NSString *)getPingFangFontNameByName:(NSString *)fontName
{
    NSString *realFontName = fontName;
    if (![BFECommonTools isAfterIOS9]) {
        if ([fontName isEqualToString:@"PingFangSC-Ultralight"]) {
            realFontName = @"STHeitiSC-Light";
        } else if ([fontName isEqualToString:@"PingFangSC-Light"]) {
            realFontName = @"STHeitiSC-Light";
        } else if ([fontName isEqualToString:@"PingFangSC-Thin"]) {
            realFontName = @"STHeitiSC-Light";
        } else if ([fontName isEqualToString:@"PingFangSC-Regular"]) {
            realFontName = @"Heiti SC";
        } else if ([fontName isEqualToString:@"PingFangSC-Medium"]) {
            realFontName = @"STHeitiSC-Medium";
        } else if ([fontName isEqualToString:@"PingFangSC-Semibold"]) {
            realFontName = @"STHeitiSC-Medium";
        }
    }
    return realFontName;
}

+ (UIFont *)getSanfranciscoSemiboldFontWithSize:(CGFloat)size {
    UIFont *font;
    if ([BFECommonTools isAfterIOS9]) {
        font = [UIFont systemFontOfSize:size
                                 weight:UIFontWeightSemibold];
    } else {
        font = HelveticaNeue_M(size);
    }
    return font;
}

+ (UIFont *)getSanfranciscoLightFontWithSize:(CGFloat)size {
    UIFont *font;
    if ([BFECommonTools isAfterIOS9]) {
        font = [UIFont systemFontOfSize:size
                                 weight:UIFontWeightLight];
    } else {
        font = HelveticaNeue_L(size);
    }
    return font;
}

+ (UIFont *)getSanfranciscoMediumFontWithSize:(CGFloat)size {
    UIFont *font;
    if ([BFECommonTools isAfterIOS9]) {
        font = [UIFont systemFontOfSize:size
                                 weight:UIFontWeightMedium];
    } else {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (UIFont *)getSanfranciscoThinFontWithSize:(CGFloat)size {
    UIFont *font;
    if ([BFECommonTools isAfterIOS9]) {
        font = [UIFont systemFontOfSize:size
                                 weight:UIFontWeightThin];
    } else {
        font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:size];
    }
    return font;
}

+ (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark 根据设备类型 自动获取 图片名和图片类型

+ (NSString *)getImageNameByDeviceBasedOnPad:(NSString *)imageName
{
    return [self getImageNameByDeviceBasedOnPad:imageName handleIPhone4:NO];
}

+ (NSString *)getImageNameByDeviceBasedOnPad:(NSString *)imageName handleTeacherVersion:(BOOL)handle
{
    return [self getImageNameByDeviceBasedOnPad:imageName
                                  handleIPhone4:NO
                           handleTeacherVersion:handle];
}

+ (NSString *)getImageNameByDeviceBasedOnPad:(NSString *)imageName handleIPhone4:(BOOL)handle
{
    return [self getImageNameByDeviceBasedOnPad:imageName handleIPhone4:handle handleTeacherVersion:NO];
}

+ (NSString *)getImageNameByDeviceBasedOnPad:(NSString *)imageName
                               handleIPhone4:(BOOL)handle
                        handleTeacherVersion:(BOOL)handleTeacher
{
    //    NSArray *suffixArray = @[@"png", @"jpg", @"jpeg"];
    NSString *realImageName;
    
    realImageName = [self getImagesNameByDeviceBasedOnPad:imageName
                                            handleIPhone4:handle
                                     handleTeacherVersion:handleTeacher];
    
    //    BOOL hasFoundFile = NO;
    //    for (NSString *suffix in suffixArray) {
    //        NSString *doubleSizeImageName = [NSString stringWithFormat:@"%@@2x", realImageName];
    //        NSString *tripleSizeImageName = [NSString stringWithFormat:@"%@@3x", realImageName];
    //        NSArray *realImageNameArray = @[realImageName, doubleSizeImageName, tripleSizeImageName];
    //
    //        for (NSString *imageName in realImageNameArray) {
    //            NSString *realImagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:suffix];
    //            if ([[NSFileManager defaultManager] fileExistsAtPath:realImagePath]) {
    //                realImageName = [NSString stringWithFormat:@"%@.%@", realImageName, suffix];
    //                hasFoundFile = YES;
    //                return realImageName;
    //            }
    //        }
    
    //    }
    //
    //    if (!hasFoundFile) {
    realImageName = [NSString stringWithFormat:@"%@.png", realImageName];
    //    }
    
    return realImageName;
}

+ (NSString *)getImagesNameByDeviceBasedOnPad:(NSString *)imageName
                                handleIPhone4:(BOOL)handleIPhone4
                         handleTeacherVersion:(BOOL)handleTeacher
{
    NSString *realImageName;
    
    if ([BFEDeviceTools isPad]) {

        realImageName = [NSString stringWithFormat:@"%@",imageName];

    } else {
        if (handleIPhone4) {
            if ([BFEDeviceTools is3p5InchPhone]) {
                realImageName = [NSString stringWithFormat:@"%@_iPhone4",imageName];
            } else {
                realImageName = [NSString stringWithFormat:@"%@_iPhone",imageName];
            }
        } else {
            realImageName = [NSString stringWithFormat:@"%@_iPhone",imageName];
        }
    }
    return realImageName;
}

@end
