//
//  RecordDBSet.h
//  DKPrecord
//
//  Created by mervin on 2016/11/12.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import <FMDBDataTable/FMDTManager.h>

@interface RecordDBSet : FMDTManager

@property (nonatomic, strong, readonly) FMDTContext *dailyModel;
@property (nonatomic, strong, readonly) FMDTContext *itemModel;

@end
