//
//  RecordGlobal.h
//  DKPrecord
//
//  Created by mervin on 2016/11/14.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordGlobal : NSObject

@property (nonatomic, assign) NSUInteger tableVersion;

SharedInstanceInterfaceBuilder(RecordGlobal)

@end
