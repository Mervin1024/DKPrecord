//
//  BFEUserCommunicationRecordItem.m
//  operationalMaster
//
//  Created by mervin on 2016/10/18.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import "BFEUserCommunicationRecordItem.h"

@implementation BFEUserCommunicationRecordItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"userId":@"userId",
             @"tags":@"tags",
             @"time":@"time",
             @"school":@"school",
             @"classViewStatus":@"classViewStatus",
             @"payViewStatus":@"payViewStatus",
             @"userHeadUrl":@"userHeadUrl",
             @"realName":@"realName",
             @"comment":@"comment"};
}

@end
