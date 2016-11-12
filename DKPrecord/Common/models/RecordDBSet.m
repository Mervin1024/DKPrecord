//
//  RecordDBSet.m
//  DKPrecord
//
//  Created by mervin on 2016/11/12.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "RecordDBSet.h"
#import "RecordItemModel.h"
#import "RecordDailyModel.h"
#import "NSDateFormatter+Category.h"

#define RECORD_DB_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define RECORD_IDENTIFIER @"翡翠梦魇"

@implementation RecordDBSet

- (FMDTContext *)dailyModel{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    return [self cacheWithClass:[RecordDailyModel class] tableName:dateStr dbPath:[NSString stringWithFormat:@"%@/%@.db", RECORD_DB_PATH, RECORD_IDENTIFIER]];
}

- (FMDTContext *)itemModel{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    return [self cacheWithClass:[RecordItemModel class] tableName:dateStr dbPath:[NSString stringWithFormat:@"%@/%@.db", RECORD_DB_PATH, RECORD_IDENTIFIER]];
}

@end
