//
//  BFEHTTPSessionManager.m
//  YQAfnetworking
//
//  Created by 杨琦 on 16/5/4.
//  Copyright © 2016年 杨琦. All rights reserved.
//

#import "BFEHTTPSessionManager.h"
#import "BFEStringTools.h"

@implementation BFEHTTPSessionManager

//- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration {
    // 后台下载任务结束后的回馈（已取消）
//    [self setDidFinishEventsForBackgroundURLSessionBlock:^(NSURLSession * _Nonnull session) {
//        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//        if (appDelegate.backgroundURLSessionCompletionHandler) {
//            void (^completionHandler)() = appDelegate.backgroundURLSessionCompletionHandler;
//            appDelegate.backgroundURLSessionCompletionHandler = nil;
//            completionHandler();
//            NSLog(@"All tasks are finished");
//        }
//    }];
//    return [super initWithSessionConfiguration:configuration];
//}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   requestTag:(NSString *)requesttag
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull, id _Nullable responseObject))failure
{
    
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"GET" URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:downloadProgress success:success failure:failure];
    [dataTask setTaskDescription:requesttag];
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    requestTag:(NSString *)requesttag
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull, id _Nullable responseObject))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"POST" URLString:URLString parameters:parameters uploadProgress:uploadProgress downloadProgress:nil success:success failure:failure];
    [dataTask setTaskDescription:requesttag];
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                    requestTag:(NSString *)requesttag
                    parameters:(id)parameters
                      progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull, id _Nullable responseObject))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"PUT" URLString:URLString parameters:parameters uploadProgress:uploadProgress downloadProgress:nil success:success failure:failure];
    [dataTask setTaskDescription:requesttag];
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    requestTag:(NSString *)requesttag
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error, id _Nullable responseObject))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError, nil);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *task = [self uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error, responseObject);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    [task setTaskDescription:requesttag];
    [task resume];
    
    return task;
}



- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      requestTag:(NSString *)requesttag
                      parameters:(id)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error, id _Nullable responseObject))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"DELETE" URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    [dataTask setTaskDescription:requesttag];
    [dataTask resume];
    
    return dataTask;
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *, id _Nullable responseObject))failure
{
    NSError *serializationError = nil;
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError, nil);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                           if (error) {
                               if (failure) {
                                   failure(dataTask, error, responseObject);
                               }
                           } else {
                               if (success) {
                                   success(dataTask, responseObject);
                               }
                           }
                       }];
    
    return dataTask;
}

- (NSURLSessionDownloadTask *)DownloadTaskWithRequest:(NSURLRequest *)request
                                      taskDescription:(NSString *)taskDescription
                                             progress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                          destination:(nullable NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                    completionHandler:(void (^)(NSURLSessionDownloadTask * _Nonnull, NSURLResponse * _Nonnull, NSURL * _Nullable, NSError * _Nullable))completionHandler
{
    NSURLSessionDownloadTask *task = [self DownloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandlerResult:completionHandler];
    [task setTaskDescription:taskDescription];
    [task resume];
    
    return task;
}

- (NSURLSessionDownloadTask *)DownloadTaskWithRequest:(NSURLRequest *)request
                                             progress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                          destination:(nullable NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                              completionHandlerResult:(void (^)(NSURLSessionDownloadTask *, NSURLResponse *, NSURL *, NSError *))completionHandler
{
    __block NSURLSessionDownloadTask *downloadTask = nil;
    downloadTask = [self downloadTaskWithRequest:request progress:downloadProgressBlock destination:destination completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        completionHandler(downloadTask, response, filePath, error);
    }];
    
    return downloadTask;
}

@end
