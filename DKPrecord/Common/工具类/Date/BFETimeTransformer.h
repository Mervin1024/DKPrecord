//
//  BFETimeTransformer.h
//  boxfish-english
//
//  Created by 李迪 on 16/6/1.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFETimeTransformer : NSObject

+ (BOOL )isSameTimeZoneWithServer;
+ (NSString *)convertBeijingTimeToLocalTime :(NSString *)beijingTimeString;
+ (NSString *)convertLocalTimeToBeijingTime :(NSString *)localTimeString;

+ (NSDate *)convertStringToDate:(NSString *)nsDateString;
+ (NSString *)convertDateToString:(NSDate *)date;

+ (NSString *)convertGMTTimeToLocalTime:(NSString *)GMTTimeString;
+ (NSString *)convertLocalTimeToGMTTime:(NSString *)localTimeString;

+ (BOOL)iSShow24HoursTime;//系统是否开启24小时制显示方式
+ (NSString *)convert24HoursTo12Hours :(NSString *)twentyfourHoursString;//将“00：00”的24小时制转为“00：00 AM”的12小时制
+ (NSString *)convert12HoursTo24Hours :(NSString *)twelveHoursString;//与上面相反

@end
