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
#import "NSDate+Category.h"
#import "RecordGlobal.h"

#define RECORD_DB_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define RECORD_IDENTIFIER @"翡翠梦魇"

@implementation RecordDBSet

- (FMDTContext *)dailyModel{
    NSString *dateStr = [[NSDate date] monthAndDayDescription];
    NSString *tableName = [dateStr stringByAppendingFormat:@"-%@",@([RecordGlobal sharedInstance].tableVersion)];
    return [self cacheWithClass:[RecordDailyModel class] tableName:tableName dbPath:[NSString stringWithFormat:@"%@/%@.db", RECORD_DB_PATH, RECORD_IDENTIFIER]];
}

- (FMDTContext *)itemModel{
    NSString *dateStr = [[NSDate date] monthAndDayDescription];
    return [self cacheWithClass:[RecordItemModel class] tableName:dateStr dbPath:[NSString stringWithFormat:@"%@/%@.db", RECORD_DB_PATH, RECORD_IDENTIFIER]];
}

@end
