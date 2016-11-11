//
//  MERHTTPServer.h
//  DKPrecord
//
//  Created by mervin on 2016/11/11.
//  Copyright © 2016年 mervin. All rights reserved.
//

#import "BFEHTTPServerManager.h"

@interface MERHTTPServerManager : BFEHTTPServerManager

- (void)getTestTextSuccess:(RequestCallBlock)success faild:(RequestCallBlock)faild;

@end
