//
//  RecordItemModel.h
//  DKPrecord
//
//  Created by mervin on 2016/11/12.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import <FMDBDataTable/FMDTObject.h>

@interface RecordItemModel : FMDTObject

/**
 角色名
 */
@property (nonatomic, copy) NSString *userName;
/**
 职业
 */
@property (nonatomic, copy) NSString *gameClass;
/**
 初始分
 */
@property (nonatomic, copy) NSNumber *initialScore;
/**
 最终分
 */
@property (nonatomic, copy) NSNumber *finalScore;
/**
 分数变化数组（-1、+1、—5、+5）等
 */
@property (nonatomic, copy) NSArray <NSNumber *>*ScoreChanges;


@end
