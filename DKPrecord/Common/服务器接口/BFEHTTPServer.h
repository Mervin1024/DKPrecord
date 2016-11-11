//
//  BFEHTTPServer.h
//  boxfish-english
//
//  Created by 杨琦 on 16/2/26.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>
#import "BFEHTTPSessionManager.h"

@class BFEHTTPServer;

/**
 *  请求数据格式
 *
 *  默认
 *  普通text/html
 */
typedef NS_ENUM(NSUInteger, BFERequestType) {
    BFERequestTypeJSON = 1,
    BFERequestTypePlainText  = 2
};
/**
 *  接收数据格式
 *
 *  默认
 *  普通text/html
 */
typedef NS_ENUM(NSUInteger, BFEResponseType) {
    BFEResponseTypeJSON = 1, // 默认
    BFEResponseTypeXML  = 2, // XML
    BFEResponseTypeDATA = 3  // data
};
/**
 *  返回结果
 *
 *  @param responseData 结果
 *  @param error              错误
 */
typedef void (^BFEResponseSuccess)(id response);
typedef void (^BFEResponseFail)(id error);
/**
 *  进度
 *
 *  @param totalUnitCount     总大小
 *  @param completedUnitCount 当前大小
 *  @param fractionCompleted  Update the progress view
 *                            [progressView setProgress:fractionCompleted];
 */
typedef void (^ProgressCallBack)(int64_t totalUnitCount, int64_t completedUnitCount, double fractionCompleted, BFEHTTPServer *bfeHttpServer);

/**
 *  网络状态
 *
 *  @param status 状态（WiFi/其他）
 */
typedef void (^reachabilityStatusBlock)(AFNetworkReachabilityStatus status);

/**
 *  声明NSURLSessionTask的对应子类
 */
typedef NSURLSessionTask BFEURLSessionTask;


@interface BFEHTTPServer : NSObject

@property (nonatomic, assign) NSUInteger tag;
@property (nonatomic, copy) NSString *taskDescription;
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, copy) id responseData;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, copy) NSString *downloadFilePath;
@property (nonatomic, assign) NSInteger responseStatusCode;
@property (nonatomic, copy) NSString *urlString;

+ (instancetype)sharedManager;

/**
 *  获取网络状态
 *
 *  @param block 回调
 */
- (void)checkReachabilityStatus:(reachabilityStatusBlock)block;

/**
 *  配置返回格式，默认为JSON。
 *
 *  @param responseType 响应格式
 */
- (void)configResponseType:(BFEResponseType)responseType;

/**
 *  取消网络请求
 */
- (void)cancelRequest;

/**
 *  GET
 *
 *  @param urlStr       地址
 *  @param requestTag   tag
 *  @param requestType  请求数据格式
 *  @param paramaeters  参数
 *  @param view         显示加载动画的view（为nil是默认view == window）
 *  @param loadingTitle 加载提示
 *  @param needLoadView 是否需要加载动画
 *  @param Success      成功回调
 *  @param Error        失败回调
 *
 *  @return 任务
 */
- (BFEURLSessionTask *)GET:(NSString*)urlStr
                requestTag:(NSString *)requestTag
               requestType:(BFERequestType)requestType
                parameters:(NSDictionary *)paramaeters
          loadingOnTheView:(UIView *)view
              loadingTitle:(NSString *)loadingTitle
              needLoadView:(BOOL)needLoadView
                   success:(BFEResponseSuccess)Success
                     error:(BFEResponseFail)Error;
/**
 *  POST
 *
 *  @param urlStr       地址
 *  @param requestTag   tag
 *  @param requestType  请求数据格式
 *  @param paramaeters  参数
 *  @param view         显示加载动画的view（为nil是默认view == window）
 *  @param loadingTitle 加载提示
 *  @param needLoadView 是否需要加载动画
 *  @param Success      成功回调
 *  @param Error        失败回调
 *
 *  @return 任务
 */
- (BFEURLSessionTask *)POST:(NSString*)urlStr
                 requestTag:(NSString *)requestTag
                requestType:(BFERequestType)requestType
                 parameters:(NSDictionary *)paramaeters
           loadingOnTheView:(UIView *)view
               loadingTitle:(NSString *)loadingTitle
               needLoadView:(BOOL)needLoadView
                    success:(BFEResponseSuccess)Success
                      error:(BFEResponseFail)Error;

- (BFEURLSessionTask *)PUT:(NSString*)urlStr
                 requestTag:(NSString *)requestTag
                requestType:(BFERequestType)requestType
                 parameters:(NSDictionary *)paramaeters
           loadingOnTheView:(UIView *)view
               loadingTitle:(NSString *)loadingTitle
               needLoadView:(BOOL)needLoadView
                    success:(BFEResponseSuccess)Success
                      error:(BFEResponseFail)Error;
/**
 *  DELETE
 *
 *  @param urlStr           请求地址
 *  @param requestTag       请求tag
 *  @param isJson           是否是json
 *  @param paramaeters      参数
 *  @param progressCallBack 请求进度
 *  @param responseCallBack 请求结果
 *  @return GET 请求任务
 */
- (BFEURLSessionTask *)DELETE:(NSString *)urlStr
                   requestTag:(NSString *)requestTag
                  requestType:(BFERequestType)requestType
                   parameters:(NSDictionary *)paramaeters
             loadingOnTheView:(UIView *)view
                 loadingTitle:(NSString *)loadingTitle
                 needLoadView:(BOOL)needLoadView
                      success:(BFEResponseSuccess)Success
                        error:(BFEResponseFail)Error;
/**
 *  DOWNLOAD
 *
 *  @param url              下载地址
 *  @param requestTag       请求tag
 *  @param localFilePath    下载到本地的地址
 *  @param isJson           是否是Json
 *  @param paramaeters      参数
 *  @param progressCallBack 下载进度
 *  @param responseCallBack 下载结果
 *
 *  @return 下载任务
 */
- (BFEURLSessionTask *)DownloadFrom:(NSString *)urlStr
                         requestTag:(NSString *)requestTag
                             toFile:(NSString *)localFilePath
                        requestType:(BFERequestType)requestType
                         parameters:(NSDictionary *)paramaeters
                           progress:(ProgressCallBack)progress
                            success:(BFEResponseSuccess)Success
                              error:(BFEResponseFail)Error;
/**
 *  上传单张图片
 *
 *  @param image       图片
 *  @param urlStr      上传地址
 *  @param requestTag  请求tag
 *  @param requestType 请求数据格式类型
 *  @param paramaeters 参数
 *  @param progress    上传进度
 *  @param Success     上传成功回调
 *  @param Error       上传失败回调
 *
 *  @return 上传单张图片任务
 */
- (BFEURLSessionTask *)UploadImage:(UIImage *)image
                        requestTag:(NSString *)requestTag
                             ToUrl:(NSString *)urlStr
                       requestType:(BFERequestType)requestType
                        parameters:(NSDictionary *)paramaeters
                          progress:(ProgressCallBack)progress
                           success:(BFEResponseSuccess)Success
                             error:(BFEResponseFail)Error;
/**
 *  上传文件
 *
 *  @param localPath   文件本地地址
 *  @param requestTag  请求tag
 *  @param urlStr      上传地址
 *  @param requestType 上传数据格式
 *  @param progress    上传进度
 *  @param Success     上传成功回调
 *  @param Error       上传失败回调
 *
 *  @return 上传文件任务
 */
- (BFEURLSessionTask *)UploadFile:(NSString *)localPath
                       requestTag:(NSString *)requestTag
                            toUrl:(NSString *)urlStr
                      requestType:(BFERequestType)requestType
                         progress:(ProgressCallBack)progress
                          success:(BFEResponseSuccess)Success
                            error:(BFEResponseFail)Error;
/**
 *  自定义上传内容（多部分）
 *
 *  @param urlStr           上传地址
 *  @param requestTag       请求tag
 *  @param constructingBody 上传内容
 *  @param progress         上传进度
 *  @param Success          上传成功回调
 *  @param Error            上传失败回调
 *
 *  @return 自定义上传任务
 */
- (BFEURLSessionTask *)UploadMultiparDataToUrl:(NSString *)urlStr
                                    requestTag:(NSString *)requestTag
                              ConstructingBody:(void (^)(id<AFMultipartFormData>))constructingBody
                                      progress:(ProgressCallBack)progress
                                       success:(BFEResponseSuccess)Success
                                         error:(BFEResponseFail)Error;
/**
 *  为view添加loadingView
 *
 *  @param view     父view
 *  @param animated 是否添加动画
 *  @param message  加载信息
 */
+ (void)loadingInView:(UIView*)view waitingMessage:(NSString*)message;

/**
 *  为view隐藏loadingview
 *
 *  @param view     父view
 *  @param animated 是否添加动画
 *
 *  @return 是否隐藏成功
 */
+ (BOOL)hideHUDForView:(UIView*)view;

@end
