//
//  BFETimeTransformer.m
//  boxfish-english
//
//  Created by 李迪 on 16/6/1.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import "BFETimeTransformer.h"

@implementation BFETimeTransformer

+ (BOOL )isSameTimeZoneWithServer  {
    BOOL isSameTimeZone =NO;
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    if(timeZone && [@"Asia/Shanghai" isEqualToString:timeZone.name]) {
        isSameTimeZone=YES;
    } else {
        isSameTimeZone=NO;
    }
    
    return isSameTimeZone;
}


+ (NSString *)convertBeijingTimeToLocalTime :(NSString *)beijingTimeString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *serverTime = [formatter dateFromString:beijingTimeString];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSTimeInterval interval = [timeZone secondsFromGMT];
    NSDate *GMTTime = [serverTime dateByAddingTimeInterval:-interval];
    
    timeZone = [NSTimeZone systemTimeZone];
    interval = [timeZone secondsFromGMT];
    
    NSDate *localTime = [GMTTime dateByAddingTimeInterval:interval];
    NSString *localTimeString = [formatter stringFromDate:localTime];
    NSLog(@"server: %@   local: %@", beijingTimeString, localTimeString);
    
    return localTimeString;
}

+ (NSString *)convertLocalTimeToBeijingTime :(NSString *)localTimeString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *localTime = [formatter dateFromString:localTimeString];
    
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSTimeInterval interval = [timeZone secondsFromGMT];
    NSDate *GMTDate = [localTime dateByAddingTimeInterval:-interval];
    
    timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    interval = [timeZone secondsFromGMT];
    
    NSDate *beijingTime = [GMTDate dateByAddingTimeInterval:interval];
    NSString *beijingTimeString = [formatter stringFromDate:beijingTime];
    NSLog(@"server: %@   local: %@", beijingTimeString, localTimeString);
    
    return beijingTimeString;
}

+ (NSDate *) convertStringToDate:(NSString*)nsDateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:nsDateString];
    return date;
    
}

+ (NSString *)convertDateToString:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
    
}

+ (NSString *)convertLocalTimeToGMTTime:(NSString *)localTimeString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *localTime = [formatter dateFromString:localTimeString];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSTimeInterval interval = [timeZone secondsFromGMT];
    NSDate *GMTDate = [localTime dateByAddingTimeInterval:-interval];
    NSString *GMTDateString = [formatter stringFromDate:GMTDate];
    return GMTDateString;
}

+(NSString *)convertGMTTimeToLocalTime:(NSString *)GMTTimeString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *GMTTime = [formatter dateFromString:GMTTimeString];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSTimeInterval interval = [timeZone secondsFromGMT];
    NSDate *localTime = [GMTTime dateByAddingTimeInterval:interval];
    NSString *localTimeString = [formatter stringFromDate:localTime];
    return localTimeString;
}

+ (BOOL)iSShow24HoursTime {
    BOOL is24Hours = YES;
    NSString *dateStr = [[NSDate date] descriptionWithLocale:[NSLocale currentLocale]];
    NSArray  *sysbols = @[[[NSCalendar currentCalendar] AMSymbol],[[NSCalendar currentCalendar] PMSymbol]];
    for (NSString *symbol in sysbols) {
        if ([dateStr rangeOfString:symbol].location != NSNotFound) {
            is24Hours = NO;
            break;
        }
    }
    return is24Hours;
}

+ (NSString *)convert24HoursTo12Hours :(NSString *)twentyfourHoursString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate *beforeDate = [formatter dateFromString:twentyfourHoursString];
    [formatter setDateFormat:@"hh:mm:ss a"];
    NSString *twelveHoursString = [formatter stringFromDate:beforeDate];
    return twelveHoursString;
}

+ (NSString *)convert12HoursTo24Hours :(NSString *)twelveHoursString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss a"];
    NSDate *beforeDate = [formatter dateFromString:twelveHoursString];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *twentyfourHoursString = [formatter stringFromDate:beforeDate];
    return twentyfourHoursString;
}

@end
