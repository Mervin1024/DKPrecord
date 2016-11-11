//
//  BFEUserCommunicationRecordItem.h
//  operationalMaster
//
//  Created by mervin on 2016/10/18.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BFEUserCommunicationRecordItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *school;
@property (nonatomic, assign) BOOL classViewStatus;
@property (nonatomic, assign) BOOL payViewStatus;
@property (nonatomic, copy) NSString *userHeadUrl;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *comment;

@end
