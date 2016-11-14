//
//  RecordGlobal.m
//  DKPrecord
//
//  Created by mervin on 2016/11/14.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "RecordGlobal.h"

@implementation RecordGlobal

SharedInstanceBuilder(RecordGlobal)

- (instancetype)init{
    if (self = [super init]) {
        _tableVersion = 0;
    }
    return self;
}

@end
