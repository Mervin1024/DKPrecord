//
//  MERHTTPServer.m
//  DKPrecord
//
//  Created by mervin on 2016/11/11.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "MERHTTPServerManager.h"

@implementation MERHTTPServerManager

- (void)getTestTextSuccess:(RequestCallBlock)success faild:(RequestCallBlock)faild{
    NSString *url = @"www.baidu.com";
    [self get:url requestType:BFERequestTypeJSON needLoadView:NO needAccessToken:NO success:success faild:faild];
}

@end
