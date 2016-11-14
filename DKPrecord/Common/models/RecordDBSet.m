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
#define DateString [[NSDate date] monthAndDayDescription]
#define DataBaseName [RECORD_IDENTIFIER stringByAppendingFormat:@"-%@",[[NSDate date] monthAndDayDescription]]

@implementation RecordDBSet

- (FMDTContext *)dailyModel{
    NSString *tableName = @"Comprehensive";
    tableName = [tableName stringByAppendingFormat:@"-%@",DateString];
    return [self cacheWithClass:[RecordDailyModel class] tableName:tableName dbPath:[NSString stringWithFormat:@"%@/%@.db", RECORD_DB_PATH, RECORD_IDENTIFIER]];
}

- (FMDTContext *)itemModel{
    NSString *tableName = @"RecordItems";
    tableName = [tableName stringByAppendingFormat:@"-%@-Version:%@",DateString,@([RecordGlobal sharedInstance].tableVersion+1)];
    return [self cacheWithClass:[RecordItemModel class] tableName:tableName dbPath:[NSString stringWithFormat:@"%@/%@.db", RECORD_DB_PATH, RECORD_IDENTIFIER]];
}

@end
