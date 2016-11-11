//
//  StringTools.m
//  boxfish-english
//
//  Created by echo on 14-11-18.
//  Copyright (c) 2014年 boxfish. All rights reserved.
//

#import "BFEStringTools.h"
#import "NSData+Base64.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>
#import "NSDate+Category.h"
#import "NSDateFormatter+Category.h"

static NSString *const annotationMarkPattern = @"\\[\\d\\]";

@implementation BFEStringTools

+ (NSString *)lowercaseMd5:(NSString *)str
{
    return [[BFEStringTools md5:str] lowercaseString];
}

+ (NSString *)md5:(NSString *)str
{
    if (!str) {
        return nil;
    }
    
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)base64hmacsha1:(NSString *)text key:(NSString *)secret
{
    NSData *data = [self hmacsha1:text key:secret];
    NSString *base64EncodedResult = [data base64EncodedString];
    return base64EncodedResult;
}

+ (NSData *)hmacsha1:(NSString *)text key:(NSString *)secret
{
    NSData *secretData = [secret dataUsingEncoding:NSUTF8StringEncoding];
    NSData *clearTextData = [text dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[20];
    CCHmac(kCCHmacAlgSHA1, [secretData bytes], [secretData length], [clearTextData bytes], [clearTextData length], result);
    
    NSData *data = [NSData dataWithBytes:result length:20];
    return data;
}

+ (NSString *)uuid
{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef cfStr = CFUUIDCreateString(NULL, uuid);
    
    NSString *ret = [NSString stringWithString:(__bridge NSString *)cfStr];
    
    CFRelease(uuid);
    CFRelease(cfStr);
    
    return ret;
}

//利用正则表达式验证
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (NSArray *)splitTextToWords:(NSString *)text
{
    __block NSMutableArray *wordArray = [[NSMutableArray alloc] init];
    
    // 处理掉非词库单词和复数，名词所有格，保留其他的例如ing，ed等
    NSRange stringRange = NSMakeRange(0, text.length);
    NSDictionary* languageMap = @{@"Latn" : @[@"en"]};
    [text enumerateLinguisticTagsInRange:stringRange
                                  scheme:NSLinguisticTagSchemeLemma
                                 options:NSLinguisticTaggerOmitWhitespace
                             orthography:[NSOrthography orthographyWithDominantScript:@"Latn" languageMap:languageMap]
                              usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
                                  // Log info to console for debugging purposes
                                  NSString *currentEntity = [text substringWithRange:tokenRange];
                                  
                                  NSString *word = [currentEntity copy];
                                  
                                  NSArray *suffixArray = @[@"'s", @"s'", @"s", @"es", @"es'"];
                                  for (NSString *suffix in suffixArray) {
                                      if (![currentEntity isEqualToString:tag] && [currentEntity hasSuffix:suffix]) {
                                          word = tag;
                                      }
                                  }
                                  
                                  if ([tag length] > 0) {
                                      [wordArray addObject:word];
                                  }

                                  //只记录词干
//                                  if ([tag length] > 0) {
//                                      [wordArray addObject:tag];
//                                  }
                                  
                                  NSLog(@"%@ is a %@, tokenRange (%lu,%lu)",currentEntity,tag,(unsigned long)tokenRange.length,(unsigned long)tokenRange.location);
                              }];

    return wordArray;
}

+ (NSString *)extrudeInvalidContent:(NSString *)text
{
    NSString *pattern = @"[0-9,.\\/?!;:\"\\r\\n%%@()<>^_—+-]|[']{1}+[s]{1}";

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:NULL];

    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}

#pragma mark - method 1
+ (NSMutableArray *)matchLinkWithStr:(NSString *)str withMatchStr:(NSString *)matchRegex;
{
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:matchRegex
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:NULL];
    NSArray *match = [reg matchesInString:str
                                  options:NSMatchingReportCompletion
                                    range:NSMakeRange(0, [str length])];
    
    NSMutableArray *rangeArr = [NSMutableArray array];
    // 取得所有的NSRange对象
    if(match.count != 0)
    {
        for (NSTextCheckingResult *matc in match)
        {
            NSRange range = [matc range];
            NSValue *value = [NSValue valueWithRange:range];
            [rangeArr addObject:value];
        }
    }
    // 将要匹配的值取出来,存入数组当中
    __block NSMutableArray *mulArr = [NSMutableArray array];
    [rangeArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSValue *value = (NSValue *)obj;
        NSRange range = [value rangeValue];
        
        NSString *subString = [str substringWithRange:range];
        
        if (![mulArr containsObject:subString]) {
            [mulArr addObject:subString];
        }
        
    }];
    return mulArr;
}

#pragma mark - 对于[^的形式不要替换

+ (NSString *)getTextWithoutLogicTreeCharacater:(NSString *)sourceString
{
    if (sourceString) {
        NSString *pattern = @"[*_^>]|[(]{2}|[)]{2}";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:NULL];
        NSString *modifiedString = [regex stringByReplacingMatchesInString:sourceString options:0 range:NSMakeRange(0, [sourceString length]) withTemplate:@""];
        __block NSString *modifiedAnnotationString = @"";
        NSRegularExpression *AnnotationRegex = [NSRegularExpression regularExpressionWithPattern:annotationMarkPattern options:0 error:nil];
        NSUInteger matchs = [AnnotationRegex numberOfMatchesInString:modifiedString options:0 range:NSMakeRange(0, [modifiedString length])];
        if (matchs > 1) {
            NSArray *array = [self matchLinkWithStr:modifiedString withMatchStr:annotationMarkPattern];
            for (NSString *index in array) {
                NSMutableString *mutableIndex = [index mutableCopy];
                [mutableIndex insertString:@"^" atIndex:1];
                modifiedString = [modifiedString stringByReplacingOccurrencesOfString:index withString:mutableIndex];
            }
            modifiedAnnotationString = modifiedString;
        }else{
            [AnnotationRegex enumerateMatchesInString:modifiedString
                                              options:0 range:NSMakeRange(0, [modifiedString length])
                                           usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                               NSString *annotationIndex = [[modifiedString substringWithRange:result.range] substringWithRange:NSMakeRange(1, 1)];
                                               modifiedAnnotationString = [modifiedString stringByReplacingCharactersInRange:result.range withString:[NSString stringWithFormat:@"[^%@]",annotationIndex]];
                                           }];
        }
        return [modifiedAnnotationString isEqualToString:@""] ? modifiedString : modifiedAnnotationString;
    } else {
        return nil;
    }
}

//移除掉所有Html的tag
+ (NSString *)filtHtmlTag:(NSString *)string
{
    if (!string) {
        return @"";
    }
    
    NSString* startTag = @"<";
    NSString* endTag = @">";
    
    NSString* regularExpressionString  = [[NSString alloc] initWithFormat:@"%@.*?%@", startTag, endTag];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regularExpressionString
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:NULL];
    NSString* result = [regex stringByReplacingMatchesInString:string
                                                       options:0
                                                         range:NSMakeRange(0, string.length)
                                                  withTemplate:@"$2"];
    
    return result;
}

+ (NSString *)filterString:(NSString *)string
{
    if (string != nil) {
        if ([string isEqual: [NSNull null]]) {
            return @"";
        }
    }
    
    return string;
}

+ (NSString *)getDateTimeString:(NSDate *)dateTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日 HH:mm";
    NSString *str = [formatter stringFromDate:dateTime];
    return str;
}

+ (NSString*)getTimeTextFromInterval:(NSTimeInterval)interval
{
    long min = (long)interval / 60;    // divide two longs, truncates
    long sec = (long)interval % 60;    // remainder of long divide
    NSString* str = [NSString stringWithFormat:@"%02ld:%02ld", min, sec];
    return str;
}

+ (NSString *)filterFullWidthSpace:(NSString*)text
{
    NSMutableString *tempText = [text mutableCopy];
    [tempText replaceOccurrencesOfString:@"\u00a0"
                              withString:@" "
                                 options:NSLiteralSearch
                                   range:NSMakeRange(0, [tempText length])];
    return [tempText copy];
}

+ (BOOL)isEmptyString:(NSString *)string
{
    if (!string) {
        return YES;
    }
    
    if ((NSNull *)string == [NSNull null]) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSString class]]) {
        return [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""];
    } else {
        return YES;
    }
}

+ (NSString *)trimString:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

//判断是否含有表情符
+ (BOOL)checkStringIsContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

+ (BOOL)checkStringIsContainSpecialCharacters:(NSString *)string
{
    NSString *specialString = @"，。、；‘【】、＝－·《》？：“｛｝｜＋——）（×＆……％￥＃＠！～，。、；’【】=-·《》？：”{}|+——）（*&……%￥#@！~,./;'[]\\=-`<>?:{}|+_)(*&^%$#@!~";
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:specialString];
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:set];
    if (trimmedString.length != string.length) {
        return YES;
    } else if (string.length != [BFEStringTools trimString:string].length) {
        return YES;
    }
    return NO;
}

+ (CGFloat)getTextRealLength:(NSString *)string
{
    CGFloat length = 0;
    for(int i = 0; i < string.length; i++) {
        NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
        if ([str isEqualToString:@"\n"]) {
            continue;
        } else {
            if ([str lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3) {
                length += 1;
            } else {
                length += 0.5;
            }
        }
    }
    return length;
}

+ (BOOL)hasEndSymbolOfASentence:(NSString *)sentence
{
    if (!sentence) {
        return NO;
    }
    
    NSString *newSentence = [sentence stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *pattern= @"[.!?(.\")(?\")(!\")]$";
    NSRange range = [newSentence rangeOfString:pattern options:NSRegularExpressionSearch];
    return (range.location != NSNotFound);
}

+ (CGSize)labelStringSize:(NSString *)titleString font:(UIFont *)font {
    CGRect rect = [titleString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                            options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:font}
                                            context:nil];
    
    return rect.size;
}

//数据检查判断
+ (BOOL)isValidObject:(id)obj class:(Class)class {
    BOOL isValid = YES;
    if (!obj || ![obj isKindOfClass:class]) {
        isValid = NO;
    }
    return isValid;
}

+ (BOOL)isNullObject:(id)obj {
    BOOL isNull = YES;
    if (obj && ![obj isKindOfClass:[NSNull class]]) {
        isNull = NO;
    }
    return isNull;
}

+ (NSString *)describeForDateFormatterString:(NSString *)formatterString {
    NSDateFormatter *formatter = [NSDateFormatter defaultDateFormatter];
    NSDate *date = [formatter dateFromString:formatterString];
    return [date formattedTime];
}

+ (NSString *)minuteDescripForDateFormatterString:(NSString *)formatterString{
    NSDateFormatter *formatter = [NSDateFormatter defaultDateFormatter];
    NSDate *date = [formatter dateFromString:formatterString];
    return [date monthAndMinuteDescription];
}

@end
