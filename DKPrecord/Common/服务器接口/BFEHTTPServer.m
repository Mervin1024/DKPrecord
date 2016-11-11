//
//  BFEHTTPServer.m
//  boxfish-english
//
//  Created by 杨琦 on 16/2/26.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import "BFEHTTPServer.h"
#import "BFECommonTools.h"
#import "MBProgressHUD.h"
#import "BFEDeviceTools.h"
#import "BFECommonTools.h"

static CGFloat const JPEG_COMPRESSION_QUALITY = 1.0;
static BFEResponseType bfe_responseType = BFEResponseTypeDATA;
static BFERequestType  bfe_requestType  = BFERequestTypeJSON;
static NSTimeInterval const REQUEST_TIMEOUT_DURATION = 30;

#define KEY_WINDOW [UIApplication sharedApplication].keyWindow

@interface BFEHTTPServer()

@property (nonatomic, strong) BFEHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableDictionary *loadViewDictionary;

@end

@implementation BFEHTTPServer

+ (instancetype)sharedManager
{
    static BFEHTTPServer *server = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        server = [[super allocWithZone:NULL] init];
    });
    return server;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedManager];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        bfe_responseType = BFEResponseTypeDATA;
        _manager = [BFEHTTPServer manager];
    }
    return self;
}

+ (BFEHTTPSessionManager *)manager
{
    BFEHTTPSessionManager *manager = [BFEHTTPSessionManager manager];
    
    switch (bfe_requestType) {
        case BFERequestTypeJSON: {
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
        } break;
        case BFERequestTypePlainText: {
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        } break;
        default:
            break;
    }
    
    switch (bfe_responseType) {
        case BFEResponseTypeJSON: {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
        } break;
        case BFEResponseTypeXML: {
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
        } break;
        case BFEResponseTypeDATA: {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        } break;
        default:
            break;
    }
    
    NSString *releaseMethod;
    
    if (DebugMode) {
        releaseMethod = @"DEBUG";
    } else {
        releaseMethod = @"RELEASE";
    }
        
    if([BFEDeviceTools isChineseLanguageEnv]) {
        [manager.requestSerializer setValue:@"zh-CN" forHTTPHeaderField:@"Accept-Language"];
    }else {
        [manager.requestSerializer setValue:@"en-US" forHTTPHeaderField:@"Accept-Language"];
    }
    
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",
                                                           @"text/html",
                                                           @"text/json",
                                                           @"text/plain",
                                                           @"text/javascript",
                                                           @"text/xml",
                                                           @"image/*", nil]];
    // 设置允许同时最大并发数量，过大容易出问题
    manager.operationQueue.maxConcurrentOperationCount = 3;
    // 设置请求超时
    manager.requestSerializer.timeoutInterval = REQUEST_TIMEOUT_DURATION;
    
    return manager;
}

- (BFEHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [BFEHTTPServer manager];
    }
    return _manager;
}

- (void)cancelRequest
{
    if (self.manager) {
        [self.manager.operationQueue cancelAllOperations];
    }
}

- (void)configResponseType:(BFEResponseType)responseType
{
    if (bfe_responseType != responseType) {
        bfe_responseType = responseType;
        [self updateResponseSerializer];
    }
}

- (void)updateRequestSerializer
{
    switch (bfe_requestType) {
        case BFERequestTypeJSON: {
            _manager.requestSerializer = [AFJSONRequestSerializer serializer];
            [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [_manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
        } break;
        case BFERequestTypePlainText: {
            _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        } break;
        default:
            break;
    }
}

- (void)updateResponseSerializer
{
    switch (bfe_responseType) {
        case BFEResponseTypeJSON: {
            _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        } break;
        case BFEResponseTypeXML: {
            _manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
        } break;
        case BFEResponseTypeDATA: {
            _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        } break;
        default:
            break;
    }
}

#pragma nark -- realize
- (BFEURLSessionTask *)POST:(NSString *)urlStr
                 requestTag:(NSString *)requestTag
                requestType:(BFERequestType)requestType
                 parameters:(NSDictionary *)paramaeters
           loadingOnTheView:(UIView *)view
               loadingTitle:(NSString *)loadingTitle
               needLoadView:(BOOL)needLoadView
                    success:(BFEResponseSuccess)Success
                      error:(BFEResponseFail)Error
{
    @synchronized (self) {
        NSString *requestTagCopy = [requestTag copy];
        if (needLoadView) {
            view = view ? view : KEY_WINDOW;
            [self dealLoadingView:view byRequestTag:requestTagCopy loadingTitle:loadingTitle];
        }
        
        if (bfe_requestType != requestType) {
            bfe_requestType = requestType;
            [self updateRequestSerializer];
        }
        
        __weak __typeof(self)weakSelf = self;
        BFEURLSessionTask *sessionDataTask =
        [self.manager POST:urlStr
                requestTag:requestTagCopy
                parameters:paramaeters
                  progress:nil
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                       __strong __typeof(weakSelf)strongSelf = weakSelf;
                       
                       [strongSelf hideHUDForViewByRequestTag:task.taskDescription];
                       
                       strongSelf.responseData = responseObject;
                       strongSelf.error = nil;
                       strongSelf.tag = [task.taskDescription integerValue];
                       strongSelf.taskDescription = task.taskDescription;
                       strongSelf.urlString = task.response.URL.absoluteString;
                       NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                       strongSelf.responseStatusCode = r.statusCode;
                       if(Success) Success(strongSelf);
                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error, id _Nullable responseObject) {
                       __strong __typeof(weakSelf)strongSelf= weakSelf;
                       
                       [strongSelf hideHUDForViewByRequestTag:task.taskDescription];
                       
                       strongSelf.responseData = responseObject;
                       strongSelf.error = error;
                       strongSelf.tag = [task.taskDescription integerValue];
                       strongSelf.taskDescription = task.taskDescription;
                       strongSelf.urlString = task.response.URL.absoluteString;
                       NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                       strongSelf.responseStatusCode = r.statusCode;
                       if(Error) Error(strongSelf);
                   }];
        return sessionDataTask;
    }
    return nil;
}

- (BFEURLSessionTask *)PUT:(NSString *)urlStr
                 requestTag:(NSString *)requestTag
                requestType:(BFERequestType)requestType
                 parameters:(NSDictionary *)paramaeters
           loadingOnTheView:(UIView *)view
               loadingTitle:(NSString *)loadingTitle
               needLoadView:(BOOL)needLoadView
                    success:(BFEResponseSuccess)Success
                      error:(BFEResponseFail)Error
{
    @synchronized (self) {
        NSString *requestTagCopy = [requestTag copy];
        if (needLoadView) {
            view = view ? view : KEY_WINDOW;
            [self dealLoadingView:view byRequestTag:requestTagCopy loadingTitle:loadingTitle];
        }
        
        if (bfe_requestType != requestType) {
            bfe_requestType = requestType;
            [self updateRequestSerializer];
        }
        
        __weak __typeof(self)weakSelf = self;
        BFEURLSessionTask *sessionDataTask =
        [self.manager PUT:urlStr
                requestTag:requestTagCopy
                parameters:paramaeters
                  progress:nil
                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                       __strong __typeof(weakSelf)strongSelf = weakSelf;
                       
                       [strongSelf hideHUDForViewByRequestTag:task.taskDescription];
                       
                       strongSelf.responseData = responseObject;
                       strongSelf.error = nil;
                       strongSelf.tag = [task.taskDescription integerValue];
                       strongSelf.taskDescription = task.taskDescription;
                       strongSelf.urlString = task.response.URL.absoluteString;
                       NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                       strongSelf.responseStatusCode = r.statusCode;
                       if(Success) Success(strongSelf);
                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error, id _Nullable responseObject) {
                       __strong __typeof(weakSelf)strongSelf= weakSelf;
                       
                       [strongSelf hideHUDForViewByRequestTag:task.taskDescription];
                       
                       strongSelf.responseData = responseObject;
                       strongSelf.error = error;
                       strongSelf.tag = [task.taskDescription integerValue];
                       strongSelf.taskDescription = task.taskDescription;
                       strongSelf.urlString = task.response.URL.absoluteString;
                       NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                       strongSelf.responseStatusCode = r.statusCode;
                       if(Error) Error(strongSelf);
                   }];
        return sessionDataTask;
    }
    return nil;
}

- (BFEURLSessionTask *)GET:(NSString *)urlStr
                requestTag:(NSString *)requestTag
               requestType:(BFERequestType)requestType
                parameters:(NSDictionary *)paramaeters
          loadingOnTheView:(UIView *)view
              loadingTitle:(NSString *)loadingTitle
              needLoadView:(BOOL)needLoadView
                   success:(BFEResponseSuccess)Success
                     error:(BFEResponseFail)Error
{
    @synchronized (self) {
        NSString *requestTagCopy = [requestTag copy];
        if (needLoadView) {
            view = view ? view : KEY_WINDOW;
            [self dealLoadingView:view byRequestTag:requestTagCopy loadingTitle:loadingTitle];
        }
        
        if (bfe_requestType != requestType) {
            bfe_requestType = requestType;
            [self updateRequestSerializer];
        }
        
        __weak __typeof(self)weakSelf = self;
        BFEURLSessionTask *sessionDataTask =
        [self.manager GET:urlStr
               requestTag:requestTagCopy
               parameters:paramaeters
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      __strong __typeof(weakSelf)strongSelf = weakSelf;
                      
                      [strongSelf hideHUDForViewByRequestTag:task.taskDescription];
                      
                      strongSelf.responseData = responseObject;
                      strongSelf.error = nil;
                      strongSelf.tag = [task.taskDescription integerValue];
                      strongSelf.taskDescription = task.taskDescription;
                      strongSelf.urlString = task.response.URL.absoluteString;
                      NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                      strongSelf.responseStatusCode = r.statusCode;
                      if(Success) Success(strongSelf);
                      
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error, id _Nullable responseObject) {
                      __strong __typeof(weakSelf)strongSelf= weakSelf;
                      
                      [strongSelf hideHUDForViewByRequestTag:task.taskDescription];
                      
                      strongSelf.responseData = responseObject;
                      strongSelf.error = error;
                      strongSelf.tag = [task.taskDescription integerValue];
                      strongSelf.taskDescription = task.taskDescription;
                      strongSelf.urlString = task.response.URL.absoluteString;
                      NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                      strongSelf.responseStatusCode = r.statusCode;
                      if(Error) Error(strongSelf);
                      
                  }];
        
        return sessionDataTask;
    }
    return nil;
}

- (BFEURLSessionTask *)DELETE:(NSString *)urlStr
                   requestTag:(NSString *)requestTag
                  requestType:(BFERequestType)requestType
                   parameters:(NSDictionary *)paramaeters
             loadingOnTheView:(UIView *)view
                 loadingTitle:(NSString *)loadingTitle
                 needLoadView:(BOOL)needLoadView
                      success:(BFEResponseSuccess)Success
                        error:(BFEResponseFail)Error
{
    @synchronized (self) {
        NSString *requestTagCopy = [requestTag copy];
        if (needLoadView) {
            view = view ? view : KEY_WINDOW;
            [self dealLoadingView:view byRequestTag:requestTagCopy loadingTitle:loadingTitle];
        }
        
        if (bfe_requestType != requestType) {
            bfe_requestType = requestType;
            [self updateRequestSerializer];
        }
        
        __weak __typeof(self)weakSelf = self;
        BFEURLSessionTask *sessionDataTask =
        [self.manager DELETE:urlStr
                  requestTag:requestTagCopy
                  parameters:paramaeters
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         __strong __typeof(weakSelf)strongSelf = weakSelf;
                         
                         [strongSelf hideHUDForViewByRequestTag:task.taskDescription];
                         
                         strongSelf.responseData = responseObject;
                         strongSelf.error = nil;
                         strongSelf.tag = [task.taskDescription integerValue];
                         strongSelf.taskDescription = task.taskDescription;
                         strongSelf.urlString = task.response.URL.absoluteString;
                         NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                         strongSelf.responseStatusCode = r.statusCode;
                         if(Success) Success(strongSelf);
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error, id  _Nullable responseObject) {
                         __strong __typeof(weakSelf)strongSelf= weakSelf;
                         
                         [strongSelf hideHUDForViewByRequestTag:task.taskDescription];
                         
                         strongSelf.responseData = responseObject;
                         strongSelf.error = error;
                         strongSelf.tag = [task.taskDescription integerValue];
                         strongSelf.taskDescription = task.taskDescription;
                         strongSelf.urlString = task.response.URL.absoluteString;
                         NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                         strongSelf.responseStatusCode = r.statusCode;
                         if(Error) Error(strongSelf);
                     }];
        
        return sessionDataTask;
    }
    return nil;
}

- (BFEURLSessionTask *)DownloadFrom:(NSString *)urlStr
                         requestTag:(NSString *)requestTag
                             toFile:(NSString *)localFilePath
                        requestType:(BFERequestType)requestType
                         parameters:(NSDictionary *)paramaeters
                           progress:(ProgressCallBack)progress
                            success:(BFEResponseSuccess)Success
                              error:(BFEResponseFail)Error
{
    @synchronized (self) {
        NSString *requestTagCopy = [requestTag copy];
        if (bfe_requestType != requestType) {
            bfe_requestType = requestType;
            [self updateRequestSerializer];
        }
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        
        __weak __typeof(self)weakSelf = self;
        BFEURLSessionTask *downloadTask =
        [self.manager DownloadTaskWithRequest:request
                              taskDescription:requestTagCopy
                                     progress:^(NSProgress * _Nonnull downloadProgress) {
                                         __strong typeof(weakSelf)strongSelf = weakSelf;
                                         
                                         progress(downloadProgress.totalUnitCount, downloadProgress.completedUnitCount, downloadProgress.fractionCompleted, strongSelf);
                                     } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                         
                                         if (localFilePath) {
                                             return [NSURL URLWithString:localFilePath];
                                         }else{
                                             NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                                                                                   inDomain:NSUserDomainMask
                                                                                                          appropriateForURL:nil
                                                                                                                     create:NO
                                                                                                                      error:nil];
                                             return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
                                         }
                                     } completionHandler:^(NSURLSessionDownloadTask *task, NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                         __strong typeof(weakSelf)strongSelf = weakSelf;
                                         
                                         if (error) {
                                             
                                             strongSelf.responseData = nil;
                                             strongSelf.error = error;
                                             strongSelf.tag = [task.taskDescription integerValue];
                                             strongSelf.taskDescription = task.taskDescription;
                                             NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                                             strongSelf.urlString = task.response.URL.absoluteString;
                                             strongSelf.responseStatusCode = r.statusCode;
                                             if(Error) Error(strongSelf);
                                         }else{
                                             
                                             strongSelf.downloadFilePath = [NSString stringWithContentsOfURL:filePath encoding:NSUTF8StringEncoding error:nil];
                                             strongSelf.error = nil;
                                             strongSelf.tag = [task.taskDescription integerValue];
                                             strongSelf.taskDescription = task.taskDescription;
                                             strongSelf.urlString = task.response.URL.absoluteString;
                                             NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                                             strongSelf.responseStatusCode = r.statusCode;
                                             if(Success) Success(strongSelf);
                                         }
                                     }];
        [downloadTask setTaskDescription:requestTagCopy];
        [downloadTask resume];
        
        return downloadTask;
    }
    return nil;
}

- (BFEURLSessionTask *)UploadImage:(UIImage *)image
                        requestTag:(NSString *)requestTag
                             ToUrl:(NSString *)urlStr
                       requestType:(BFERequestType)requestType
                        parameters:(NSDictionary *)paramaeters
                          progress:(ProgressCallBack)progress
                           success:(BFEResponseSuccess)Success
                             error:(BFEResponseFail)Error
{
    @synchronized (self) {
        NSString *requestTagCopy = [requestTag copy];
        if (bfe_requestType != requestType) {
            bfe_requestType = requestType;
            [self updateRequestSerializer];
        }
        
        NSData *imageData = UIImageJPEGRepresentation(image, JPEG_COMPRESSION_QUALITY);
        
        __weak __typeof(self)weakSelf = self;
        BFEURLSessionTask *uploadTash = [self.manager POST:urlStr
                                                requestTag:requestTagCopy
                                                parameters:paramaeters
                                 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                                     
                                     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                     formatter.dateFormat = @"yyyyMMddHHmmss";
                                     NSString *str = [formatter stringFromDate:[NSDate date]];
                                     NSString *imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
                                     
                                     [formData appendPartWithFileData:imageData name:@"imageFile" fileName:imageFileName mimeType:@"image/jpeg"];
                                     
                                 } progress:^(NSProgress * _Nonnull uploadProgress) {
                                     __strong typeof(weakSelf)strongSelf = weakSelf;
                                     
                                     progress(uploadProgress.totalUnitCount, uploadProgress.completedUnitCount, uploadProgress.fractionCompleted, strongSelf);
                                     
                                 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                     __strong typeof(weakSelf)strongSelf = weakSelf;
                                     
                                     strongSelf.responseData = responseObject;
                                     strongSelf.error = nil;
                                     strongSelf.tag = [task.taskDescription integerValue];
                                     strongSelf.taskDescription = task.taskDescription;
                                     NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                                     strongSelf.responseStatusCode = r.statusCode;
                                     if(Success) Success(strongSelf);
                                     
                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error, id  _Nullable responseObject) {
                                     __strong typeof(weakSelf)strongSelf = weakSelf;
                                     
                                     strongSelf.responseData = responseObject;
                                     strongSelf.error = error;
                                     strongSelf.tag = [task.taskDescription integerValue];
                                     strongSelf.taskDescription = task.taskDescription;
                                     NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                                     strongSelf.responseStatusCode = r.statusCode;
                                     if(Error) Error(strongSelf);
                                     
                                 }];
        
        [uploadTash setTaskDescription:requestTagCopy];
        [uploadTash resume];
        
        return uploadTash;
    }
    return nil;
}

- (BFEURLSessionTask *)UploadFile:(NSString *)localPath
                       requestTag:(NSString *)requestTag
                            toUrl:(NSString *)urlStr
                      requestType:(BFERequestType)requestType
                         progress:(ProgressCallBack)progress
                          success:(BFEResponseSuccess)Success
                            error:(BFEResponseFail)Error
{
    @synchronized (self) {
        if (bfe_requestType != requestType) {
            bfe_requestType = requestType;
            [self updateRequestSerializer];
        }
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        
        NSURL *filePath = [NSURL fileURLWithPath:localPath];
        
        __weak __typeof(self)weakSelf = self;
        BFEURLSessionTask * uploadTask =
        [self.manager uploadTaskWithRequest:request
                                   fromFile:filePath
                                   progress:^(NSProgress * _Nonnull uploadProgress) {
                                       __strong typeof(weakSelf)strongSelf = weakSelf;
                                       
                                       progress(uploadProgress.totalUnitCount, uploadProgress.completedUnitCount, uploadProgress.fractionCompleted, strongSelf);
                                       
                                   } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                       __strong typeof(weakSelf)strongSelf = weakSelf;
                                       
                                       if (error) {
                                           
                                           strongSelf.responseData = nil;
                                           strongSelf.error = error;
                                           if(Error) Error(strongSelf);
                                       }else{
                                           
                                           strongSelf.downloadFilePath = [NSString stringWithContentsOfURL:filePath encoding:NSUTF8StringEncoding error:nil];
                                           strongSelf.error = nil;
                                           if(Success) Success(strongSelf);
                                           
                                       }
                                   }];
        [uploadTask resume];
        
        return uploadTask;
    }
    return nil;
}

- (BFEURLSessionTask *)UploadMultiparDataToUrl:(NSString *)urlStr
                                    requestTag:(NSString *)requestTag
                              ConstructingBody:(void (^)(id<AFMultipartFormData>))constructingBody
                                      progress:(ProgressCallBack)progress
                                       success:(BFEResponseSuccess)Success
                                         error:(BFEResponseFail)Error
{
    @synchronized (self) {
        
    }
    NSMutableURLRequest *request =
    [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                               URLString:urlStr
                                                              parameters:nil
                                               constructingBodyWithBlock:constructingBody
                                                                   error:nil];
    
    __weak __typeof(self)weakSelf = self;
    BFEURLSessionTask *postTask =
    [self.manager uploadTaskWithStreamedRequest:request
                                       progress:^(NSProgress * _Nonnull uploadProgress) {
                                           __strong typeof(weakSelf)strongSelf = weakSelf;
                                           
                                           // 这个回调不在主线程，回到主线程刷新UI
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               
                                               progress(uploadProgress.totalUnitCount, uploadProgress.completedUnitCount, uploadProgress.fractionCompleted, strongSelf);
                                           });
                                           
                                       } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                           __strong typeof(weakSelf)strongSelf = weakSelf;
                                           
                                           if (error) {
                                               
                                               strongSelf.responseData = nil;
                                               strongSelf.error = error;
                                               if(Error) Error(strongSelf);
                                               
                                           }else{
                                               
                                               strongSelf.responseData = responseObject;
                                               strongSelf.error = nil;
                                               if(Success) Success(strongSelf);
                                               
                                           }
                                       }];
    return postTask;
}

- (void)checkReachabilityStatus:(reachabilityStatusBlock)block
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld",(long)status);
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                block(AFNetworkReachabilityStatusReachableViaWiFi);
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                block(AFNetworkReachabilityStatusReachableViaWWAN);
            }
                break;
            case AFNetworkReachabilityStatusUnknown:
            {
                block(AFNetworkReachabilityStatusUnknown);
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                block(AFNetworkReachabilityStatusNotReachable);
            }
                break;
            default:
                break;
        }
    }];
}

#pragma mark - ================ loadingView
- (void)dealLoadingView:(UIView *)view byRequestTag:(NSString *)requestTag loadingTitle:(NSString *)loadingtitle
{
    UIView *savedView = [self.loadViewDictionary objectForKey:requestTag];
    if (savedView) {
        if (![savedView isEqual:view]) {
            [BFEHTTPServer hideHUDForView:savedView];
            [BFEHTTPServer loadingInView:view waitingMessage:loadingtitle];
            [self.loadViewDictionary setValue:view forKey:requestTag];
        }
    } else {
        [BFEHTTPServer loadingInView:view waitingMessage:loadingtitle];
        [self.loadViewDictionary setValue:view forKey:requestTag];
    }
}

- (void)hideHUDForViewByRequestTag:(NSString *)requestTag
{
    UIView *savedView = [self.loadViewDictionary objectForKey:requestTag];
    if (savedView) {
        [BFEHTTPServer hideHUDForView:savedView];
        [self.loadViewDictionary removeObjectForKey:requestTag];
    }
}

+ (void)loadingInView:(UIView*)view waitingMessage:(NSString*)message;
{
    if (![MBProgressHUD HUDForView:view]) {
        MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:view animated:YES];
        progress.opacity = 0.3;
        progress.labelText = message;
    }else{
        MBProgressHUD *HUD = [MBProgressHUD HUDForView:view];
        [HUD setLabelText:message];
        [HUD show:YES];
    }
}

+ (BOOL)hideHUDForView:(UIView*)view
{
    return [MBProgressHUD hideHUDForView:view animated:YES];;
}

#pragma mark - ================
+ (NSString *)getBundleId
{
    return [BFECommonTools getBundleId];
}

+ (NSString *)getVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark -- lazy
- (NSMutableDictionary *)loadViewDictionary
{
    if (_loadViewDictionary == nil) {
        _loadViewDictionary = [NSMutableDictionary dictionary];
    }
    return _loadViewDictionary;
}


@end
