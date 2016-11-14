//
//  RecordDailyModel.h
//  DKPrecord
//
//  Created by mervin on 2016/11/12.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import <FMDBDataTable/FMDTObject.h>
#import "RecordItemModel.h"

@interface RecordDailyModel : FMDTObject

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSNumber *version;
@property (nonatomic, copy) NSString *schedule;

@end
