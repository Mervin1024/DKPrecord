//
//  StringTools.h
//  boxfish-english
//
//  Created by echo on 14-11-18.
//  Copyright (c) 2014年 boxfish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFEStringTools : NSObject

+ (NSString *)lowercaseMd5:(NSString *)str;
+ (NSString *)md5:(NSString *)str;
+ (NSString *)base64hmacsha1:(NSString *)text key:(NSString *)secret;
+ (NSData *)hmacsha1:(NSString *)text key:(NSString *)secret;
+ (NSString *)uuid;

+ (BOOL)isValidateEmail:(NSString *)email;
+ (NSArray *)splitTextToWords:(NSString *)text;
+ (NSString *)extrudeInvalidContent:(NSString *)text;
+ (NSString *)getTextWithoutLogicTreeCharacater:(NSString *)sourceString;

+ (NSString *)filtHtmlTag:(NSString *)string;
+ (NSString *)filterString:(NSString *)string;

+ (NSString *)getDateTimeString:(NSDate *)dateTime;
+ (NSString *)getTimeTextFromInterval:(NSTimeInterval)interval;

+ (NSString *)filterFullWidthSpace:(NSString *)text;

+ (BOOL)isEmptyString:(NSString *)string;
+ (NSString *)trimString:(NSString *)string;

+ (BOOL)checkStringIsContainsEmoji:(NSString *)string;
+ (BOOL)checkStringIsContainSpecialCharacters:(NSString *)string;
+ (CGFloat)getTextRealLength:(NSString *)string;
+ (BOOL)hasEndSymbolOfASentence:(NSString *)sentence;
+ (CGSize)labelStringSize:(NSString *)titleString font:(UIFont *)font;

+ (BOOL)isValidObject:(id)obj class:(Class)class;
+ (BOOL)isNullObject:(id)obj;
+ (NSString *)describeForDateFormatterString:(NSString *)formatterString;
+ (NSString *)minuteDescripForDateFormatterString:(NSString *)formatterString;
@end
