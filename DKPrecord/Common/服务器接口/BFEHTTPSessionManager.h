//
//  BFEHTTPSessionManager.h
//  YQAfnetworking
//
//  Created by 杨琦 on 16/5/4.
//  Copyright © 2016年 杨琦. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFEHTTPSessionManager : AFHTTPSessionManager

- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                            requestTag:(NSString *)requesttag
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error, id _Nullable responseObject))failure;

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             requestTag:(NSString *)requesttag
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error, id _Nullable responseObject))failure;

- (nullable NSURLSessionDataTask *)PUT:(NSString *)URLString
                             requestTag:(NSString *)requesttag
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error, id _Nullable responseObject))failure;

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             requestTag:(NSString *)requesttag
                             parameters:(nullable id)parameters
              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                               progress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error, id _Nullable responseObject))failure;

- (nullable NSURLSessionDataTask *)DELETE:(NSString *)URLString
                               requestTag:(NSString *)requesttag
                               parameters:(nullable id)parameters
                                  success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                  failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error, id _Nullable responseObject))failure;

- (nullable NSURLSessionDownloadTask *)DownloadTaskWithRequest:(NSURLRequest *)request
                                               taskDescription:(NSString *)taskDescription
                                                      progress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                                                   destination:(nullable NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                             completionHandler:(nullable void (^)(NSURLSessionDownloadTask * _Nonnull task, NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler;

@end

NS_ASSUME_NONNULL_END
