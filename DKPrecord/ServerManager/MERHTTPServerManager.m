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
//    NSString *url = @"https://raw.githubusercontent.com/Mervin1024/DKPrecord/master/test.json";
    NSString *url = @"https://mervin001-1252884373.file.myqcloud.com/mervin001/feicuimengyan/9f2f070828381f307ddfc615a1014c086f06f04c.jpg";
    [self get:url requestType:BFERequestTypeJSON needLoadView:NO needAccessToken:NO success:success faild:faild];
}

@end
