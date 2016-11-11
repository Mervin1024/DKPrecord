//
//  BFEHTTPServerManager.m
//  boxfish-english
//
//  Created by mike on 2016/10/11.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import "BFEHTTPServerManager.h"
#import "BFEHTTPServer.h"
#import "BFETimeTransformer.h"
#import "NSString+Extension.h"

#define KEY_WINDOW [UIApplication sharedApplication].keyWindow

@implementation BFEHTTPServerManager


- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpServer = [BFEHTTPServer sharedManager];
    }
    return self;
}

- (void)setTag:(NSInteger)tag
{
    _tag = tag;
    _taskDescription = nil;
}

- (void)cancelRequest {
    [_httpServer cancelRequest];
    self.delegate = nil;
}

#pragma mark -- get
- (BFEURLSessionTask *)get:(NSString*)urlString
               requestType:(BFERequestType)requestType
              needLoadView:(BOOL)needLoadView
           needAccessToken:(BOOL)needAccessToken
                   success:(RequestCallBlock)success
                     faild:(RequestCallBlock)faild
{
    return [self get:urlString
         requestType:requestType
          parameters:nil
    loadingOnTheView:nil
        loadingTitle:nil
        needLoadView:needLoadView
     needAccessToken:needAccessToken
             success:success
               faild:faild];
}

- (BFEURLSessionTask *)get:(NSString*)urlString
               requestType:(BFERequestType)requestType
                parameters:(NSDictionary *)patameters
          loadingOnTheView:(UIView *)view
              loadingTitle:(NSString *)title
              needLoadView:(BOOL)needLoadView
           needAccessToken:(BOOL)needAccessToken
                   success:(RequestCallBlock)success
                     faild:(RequestCallBlock)faild
{
    @synchronized (self) {
        if (needAccessToken) {
             
        }
        NSString *requestTag = nil;
        if (self.taskDescription.length) {
            requestTag = [self.taskDescription copy];
        }else{
            requestTag = [NSString stringWithFormat:@"%@", @(self.tag)];
        }
        __weak typeof(self)weakSelf = self;
        BFEURLSessionTask *task = [_httpServer GET:urlString
                                        requestTag:requestTag
                                       requestType:requestType
                                        parameters:patameters
                                  loadingOnTheView:view
                                      loadingTitle:title
                                      needLoadView:needLoadView
                                           success:^(id bfeHttpServer) {
                                               __strong typeof(weakSelf)strongSelf = weakSelf;
                                               BFEHTTPServer *server = (BFEHTTPServer *)bfeHttpServer;
                                               [strongSelf requestFinished:server callBlock:success];
                                           } error:^(id bfeHttpServer) {
                                               __strong typeof(weakSelf)strongSelf = weakSelf;
                                               BFEHTTPServer *server = (BFEHTTPServer *)bfeHttpServer;
                                               [strongSelf requestFailed:server callBlock:faild];
                                           }];
        return task;
    }
    return nil;
}

#pragma mark -- post

- (BFEURLSessionTask *)post:(NSString*)urlString
                requestType:(BFERequestType)requestType
                 parameters:(NSDictionary *)patameters
               needLoadView:(BOOL)needLoadView
            needAccessToken:(BOOL)needAccessToken
                    success:(RequestCallBlock)success
                      faild:(RequestCallBlock)faild
{
    return [self post:urlString
          requestType:requestType
           parameters:patameters
     loadingOnTheView:nil
         loadingTitle:nil
         needLoadView:needLoadView
      needAccessToken:needAccessToken
              success:success
                faild:faild];
}

- (BFEURLSessionTask *)post:(NSString*)urlString
                requestType:(BFERequestType)requestType
                 parameters:(NSDictionary *)patameters
           loadingOnTheView:(UIView *)view
               loadingTitle:(NSString *)title
               needLoadView:(BOOL)needLoadView
            needAccessToken:(BOOL)needAccessToken
                    success:(RequestCallBlock)success
                      faild:(RequestCallBlock)faild
{
    @synchronized (self) {
        if (needAccessToken) {
             
        }
        NSString *requestTag = nil;
        if (self.taskDescription.length) {
            requestTag = [self.taskDescription copy];
        }else{
            requestTag = [NSString stringWithFormat:@"%@",@(self.tag)];
        }
        __weak typeof(self)weakSelf = self;
        BFEURLSessionTask *task = [_httpServer POST:urlString
                                         requestTag:requestTag
                                        requestType:requestType
                                         parameters:patameters
                                   loadingOnTheView:view
                                       loadingTitle:title
                                       needLoadView:needLoadView
                                            success:^(id bfeHttpServer) {
                                                __strong typeof(weakSelf)strongSelf = weakSelf;
                                                BFEHTTPServer *server = (BFEHTTPServer *)bfeHttpServer;
                                                [strongSelf requestFinished:server callBlock:success];
                                            } error:^(id bfeHttpServer) {
                                                __strong typeof(weakSelf)strongSelf = weakSelf;
                                                BFEHTTPServer *server = (BFEHTTPServer *)bfeHttpServer;
                                                [strongSelf requestFailed:server callBlock:faild];
                                            }
                                   
                                   /*
                                            success:^(id bfeHttpServer) {
                                                __strong typeof(weakSelf)strongSelf = weakSelf;
                                                BFEHTTPServer *server = (BFEHTTPServer *)bfeHttpServer;
                                                if ([strongSelf.delegate respondsToSelector:@selector(handleRequestCompletion:)]) {
                                                    [strongSelf.delegate handleRequestCompletion:server];
                                                    NSLog(@"===foreignCommentSuccess%@",server);
                                                }else {
                                                    if(success) {
                                                        success(server);
                                                    }
                                                }
                                            } error:^(id bfeHttpServer) {
                                                __strong typeof(weakSelf)strongSelf = weakSelf;
                                                BFEHTTPServer *server = (BFEHTTPServer *)bfeHttpServer;
                                                if ([strongSelf.delegate respondsToSelector:@selector(handleRequestFail:)]) {
                                                    [strongSelf.delegate handleRequestFail:server];
                                                    NSLog(@"===foreignCommentError%@",server.error.userInfo);
                                                }else {
                                                    if(faild) {
                                                        faild(server);
                                                    }
                                                }
                                            }
                                    */
                                            ];
        return task;
    }
    return nil;
}

#pragma mark -- PUT

- (BFEURLSessionTask *)put:(NSString*)urlString
               requestType:(BFERequestType)requestType
                parameters:(NSDictionary *)patameters
          loadingOnTheView:(UIView *)view
              loadingTitle:(NSString *)title
              needLoadView:(BOOL)needLoadView
           needAccessToken:(BOOL)needAccessToken
                   success:(RequestCallBlock)success
                     faild:(RequestCallBlock)faild
{
    @synchronized (self) {
        if (needAccessToken) {
             
        }
        NSString *requestTag = nil;
        if (self.taskDescription.length) {
            requestTag = [self.taskDescription copy];
        }else{
            requestTag = [NSString stringWithFormat:@"%@",@(self.tag)];
        }
        __weak typeof(self)weakSelf = self;
        BFEURLSessionTask *task = [_httpServer PUT:urlString
                                         requestTag:requestTag
                                        requestType:requestType
                                         parameters:patameters
                                   loadingOnTheView:view
                                       loadingTitle:title
                                       needLoadView:needLoadView
                                            success:^(id bfeHttpServer) {
                                                __strong typeof(weakSelf)strongSelf = weakSelf;
                                                BFEHTTPServer *server = (BFEHTTPServer *)bfeHttpServer;
                                                [strongSelf requestFinished:server callBlock:success];
                                            } error:^(id bfeHttpServer) {
                                                __strong typeof(weakSelf)strongSelf = weakSelf;
                                                BFEHTTPServer *server = (BFEHTTPServer *)bfeHttpServer;
                                                [strongSelf requestFailed:server callBlock:faild];
                                            } ];
        return task;
    }
    return nil;
}

- (BFEURLSessionTask *)put:(NSString*)urlString
               requestType:(BFERequestType)requestType
                parameters:(NSDictionary *)patameters
              needLoadView:(BOOL)needLoadView
           needAccessToken:(BOOL)needAccessToken
                   success:(RequestCallBlock)success
                     faild:(RequestCallBlock)faild
{
    return [self put:urlString
         requestType:requestType
          parameters:patameters
    loadingOnTheView:nil
        loadingTitle:nil
        needLoadView:needLoadView
     needAccessToken:needAccessToken
             success:success
               faild:faild];
}

#pragma mark -- Delete

- (BFEURLSessionTask *)Delete:(NSString*)urlString
                  requestType:(BFERequestType)requestType
                   parameters:(NSDictionary *)patameters
             loadingOnTheView:(UIView *)view
                 loadingTitle:(NSString *)title
                 needLoadView:(BOOL)needLoadView
              needAccessToken:(BOOL)needAccessToken
                      success:(RequestCallBlock)success
                        faild:(RequestCallBlock)faild
{
    if (needAccessToken) {
          
    }
    NSString *requestTag = nil;
    if (self.taskDescription.length) {
        requestTag = [self.taskDescription copy];
    }else{
        requestTag = [NSString stringWithFormat:@"%@",@(self.tag)];
    }
    __weak typeof(self)weakSelf = self;
    BFEURLSessionTask *task = [_httpServer DELETE:urlString
                                       requestTag:requestTag
                                      requestType:requestType
                                       parameters:patameters
                                 loadingOnTheView:view
                                     loadingTitle:title
                                     needLoadView:needLoadView
                                          success:^(id bfeHttpServer) {
                                              __strong typeof(weakSelf)strongSelf = weakSelf;
                                              BFEHTTPServer *server = (BFEHTTPServer *)bfeHttpServer;
                                              [strongSelf requestFinished:server callBlock:success];
                                          } error:^(id bfeHttpServer) {
                                              __strong typeof(weakSelf)strongSelf = weakSelf;
                                              BFEHTTPServer *server = (BFEHTTPServer *)bfeHttpServer;
                                              [strongSelf requestFailed:server callBlock:faild];
                                          }];
    return task;
}

- (BFEURLSessionTask *)Delete:(NSString*)urlString
                  requestType:(BFERequestType)requestType
                   parameters:(NSDictionary *)patameters
                 needLoadView:(BOOL)needLoadView
              needAccessToken:(BOOL)needAccessToken
                      success:(RequestCallBlock)success
                        faild:(RequestCallBlock)faild
{
    return [self Delete:urlString
            requestType:requestType
             parameters:patameters
       loadingOnTheView:nil
           loadingTitle:nil
           needLoadView:needLoadView
        needAccessToken:needAccessToken
                success:success
                  faild:faild];
}


#pragma mark -- Download
- (BFEURLSessionTask *)DownloadFrom:(NSString *)urlString
                             toFile:(NSString *)localFilePath
                        requestType:(BFERequestType)requestType
                         parameters:(NSDictionary *)paramaeters
                    needAccessToken:(BOOL)needAccessToken
                           progress:(ProgressCallBack)progress
                            success:(RequestCallBlock)success
                              faild:(RequestCallBlock)faild
{
    if (needAccessToken) {
          
    }
    NSString *requestTag = nil;
    if (self.taskDescription.length) {
        requestTag = [self.taskDescription copy];
    }else{
        requestTag = [NSString stringWithFormat:@"%@",@(self.tag)];
    }
    __weak typeof(self)weakSelf = self;
    BFEURLSessionTask *task = [_httpServer DownloadFrom:urlString
                                             requestTag:requestTag
                                                 toFile:localFilePath
                                            requestType:requestType
                                             parameters:paramaeters
                                               progress:progress
                                                success:^(id bfeHttpServer) {
                                                    __strong typeof(weakSelf)strongSelf = weakSelf;
                                                    BFEHTTPServer *server = (BFEHTTPServer *)bfeHttpServer;
                                                    [strongSelf requestFinished:server callBlock:success];
                                                } error:^(id bfeHttpServer) {
                                                    __strong typeof(weakSelf)strongSelf = weakSelf;
                                                    BFEHTTPServer *server = (BFEHTTPServer *)bfeHttpServer;
                                                    [strongSelf requestFailed:server callBlock:faild];
                                                }];
    return task;
}

#pragma mark -- request result
- (void)requestFinished:(BFEHTTPServer *)request  callBlock:(RequestCallBlock)callBlock
{
    if(!request) {
        return;
    }
    
    NSLog(@"AFN requestFinished url is %@, tag %@ request finished. http status code is %@", request.urlString, @(request.tag), @(request.responseStatusCode));
    
    if (206 == request.responseStatusCode) {
        NSLog(@"发生了断点续传。");
    }
    // 2XX的返回码认为是成功返回
    if ((request.responseStatusCode >= 200 && request.responseStatusCode < 300)) {
        if (self.additionalInfo) {
            if ([self.delegate respondsToSelector:@selector(handleRequestCompletion:additionalInfo:)]) {
                [self.delegate handleRequestCompletion:request additionalInfo:self.additionalInfo];
            }else {
                if(callBlock) {
                    callBlock(request);
                }
            }
            
        } else {
            if ([self.delegate respondsToSelector:@selector(handleRequestCompletion:)]) {
                [self.delegate handleRequestCompletion:request];
            }else {
                if(callBlock) {
                    callBlock(request);
                }
            }
        }
    } else if (401 == request.responseStatusCode) {
//        NSLog(@"授权失败。");
//        [self handleUnauthorizedWithRequest:request];
//        ///        [[BFEDataCollector sharedInstance] recordUserWasKickedOutDueTo:request.urlString];
    } else {
        [self requestFailed:request callBlock:nil];
        
        if (304 == request.responseStatusCode) {
            NSLog(@"return 304，请求的信息没有改变。");
        } else if (400 == request.responseStatusCode) {
            NSLog(@"修改失败。");
        } else if (404 == request.responseStatusCode) {
            NSLog(@"资源未找到。");
        } else if (500 ==  request.responseStatusCode) {
            NSLog(@"服务器错误。tag is %@", request.taskDescription);
        } else {
            NSLog(@"返回了未对应操作的状态码 %@", @(request.responseStatusCode));
        }
    }
}

- (void)requestFailed:(BFEHTTPServer *)request  callBlock:(RequestCallBlock)callBlock
{
    if(!request) {
        return;
    }
    
    NSLog(@"AFN requestFailed url is %@, tag %@ request failed. http status code is %@", request.urlString, @(request.tag), @(request.responseStatusCode));
    NSError *error = [request error];
    if (error) {
        if (2 == error.code) {
            NSLog(@"系统超时");
        }
        NSLog(@"error is %@", error);
    }
    
//    if (401 == request.responseStatusCode) {
//        [self handleUnauthorizedWithRequest:request];
//    } else {
        if (403 == request.responseStatusCode) {
            NSLog(@"AccessDenied.");
        }
        if (self.additionalInfo) {
            if ([self.delegate respondsToSelector:@selector(handleRequestFail:additionalInfo:)]) {
                [self.delegate handleRequestFail:request additionalInfo:self.additionalInfo];
            }else {
                if(callBlock) {
                    callBlock(request);
                }
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(handleRequestFail:)]) {
                [self.delegate handleRequestFail:request];
            }else {
                if(callBlock) {
                    callBlock(request);
                }
            }
        }
//    }
}

//- (void)handleUnauthorizedWithRequest:(BFEHTTPServer *)request {
//    NSString *message = NSLocalizedString(@"MultipleAccountLoginning", @"Your account has been logged in on another device. Please make sure this was your operation.");
//    if (request) {
//        id obj = [BFEHTTPServerManager parseObjectFromRequest:request];
//        if ([obj isKindOfClass:[NSDictionary class]]) {
//            NSDictionary *dict = (NSDictionary *)obj;
//            NSString *msg = dict[@"error"];
//            if (msg && [msg isKindOfClass:[NSString class]] && msg.length > 0) {
//                message = msg;
//            }
//        }
//    }
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Unauthorized object:nil];
//}


#pragma mark -- commonMethod
+ (id)parseObjectFromRequest:(BFEHTTPServer *)request
{
    if (request.responseData) {
        id returnInfo = [NSJSONSerialization JSONObjectWithData:request.responseData
                                                        options:kNilOptions
                                                          error:NULL];
        return returnInfo;
    } else {
        return nil;
    }
}

- (NSString*)urlEncode:(NSString*)urlPara
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)urlPara, nil,  (CFStringRef)@",+", kCFStringEncodingUTF8));
}

- (NSString*)getServerAddress
{
    return nil;
}

#pragma mark Help Method
+ (NSString *)notNil:(NSString *)sender {
    if(sender) {
        return sender;
    }
    return @"";
}

+ (NSString *)reportTimeString {
    NSString *beijingTimeString = [BFETimeTransformer convertLocalTimeToBeijingTime:[BFETimeTransformer convertDateToString:[NSDate date]]];
    return beijingTimeString;
}

@end
