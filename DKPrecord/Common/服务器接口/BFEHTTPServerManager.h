//
//  BFEHTTPServerManager.h
//  boxfish-english
//
//  Created by mike on 2016/10/11.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>
#import "BFEHTTPServer.h"

typedef void(^RequestCallBlock)(BFEHTTPServer *bfeHttpServer);
typedef void (^SuccessCallBack)(id responseObject);
typedef void (^ErrorCallBack)(NSError *error);

@protocol BFEHTTPServerManagerDelegate <NSObject>

@optional
- (void)handleRequestFail:(BFEHTTPServer *)request;
- (void)handleRequestCompletion:(BFEHTTPServer *)request;
- (void)handleProgressedBytes:(unsigned long long)size totalBytes:(unsigned long long)total;
- (void)handleProgressedBytes:(unsigned long long)size totalBytes:(unsigned long long)total speed:(float)speed tag:(NSInteger)tag; //速度是K/秒
- (void)handleReceivedData:(NSData*)data resourceId:(NSString*)resourceId;
- (void)handleReceivedResponseHeaders:(BFEHTTPServer*)request;
- (void)handleRequestFail:(BFEHTTPServer*)request additionalInfo:(id)additionalInfo;
- (void)handleRequestCompletion:(BFEHTTPServer*)request additionalInfo:(id)additionalInfo;

@end

@interface BFEHTTPServerManager : NSObject

@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, copy)   NSString *taskDescription;
@property (nonatomic, assign)   id<BFEHTTPServerManagerDelegate> delegate;
@property (nonatomic, strong) BFEHTTPServer *httpServer;
@property (nonatomic, strong) id additionalInfo;

- (void)cancelRequest;

#pragma mark -- GET
/**
 *  GET
 *
 *  @param urlString       请求地址（必传）
 *  @param requestType     请求数据格式（默认JSON）
 *  @param patameters      参数 (不传为nil)
 *  @param view            显示加载动画的view（为nil时，默认view == window）
 *  @param title           加载提示 (默认nil)
 *  @param needLoadView    是否需要加载动画 (默认YES)
 *  @param needAccessToken 是否有需要accessToken (默认YES)
 *  @param success         成功回调
 *  @param faild           失败回调
*/
- (BFEURLSessionTask *)get:(NSString*)urlString
               requestType:(BFERequestType)requestType
                parameters:(NSDictionary *)patameters
          loadingOnTheView:(UIView *)view
              loadingTitle:(NSString *)title
              needLoadView:(BOOL)needLoadView
           needAccessToken:(BOOL)needAccessToken
                   success:(RequestCallBlock)success
                     faild:(RequestCallBlock)faild;

- (BFEURLSessionTask *)get:(NSString*)urlString
               requestType:(BFERequestType)requestType
              needLoadView:(BOOL)needLoadView
           needAccessToken:(BOOL)needAccessToken
                   success:(RequestCallBlock)success
                     faild:(RequestCallBlock)faild;

#pragma mark -- POST
/**
 *  POST
 *
 *  @param urlString       请求地址 (必传)
 *  @param requestType     请求数据格式（默认JSON）
 *  @param patameters      参数（默认nil）
 *  @param view            显示加载动画的view（为nil时，默认view == window）
 *  @param title           加载提示（默认nil）
 *  @param needLoadView    是否需要加载动画（默认YES）
 *  @param needAccessToken 是否有需要accessToken（默认YES）
 *  @param success         成功回调
 *  @param faild           失败回调
 */
- (BFEURLSessionTask *)post:(NSString*)urlString
                requestType:(BFERequestType)requestType
                 parameters:(NSDictionary *)patameters
           loadingOnTheView:(UIView *)view
               loadingTitle:(NSString *)title
               needLoadView:(BOOL)needLoadView
            needAccessToken:(BOOL)needAccessToken
                    success:(RequestCallBlock)success
                      faild:(RequestCallBlock)faild;

- (BFEURLSessionTask *)post:(NSString*)urlString
                requestType:(BFERequestType)requestType
                 parameters:(NSDictionary *)patameters
               needLoadView:(BOOL)needLoadView
            needAccessToken:(BOOL)needAccessToken
                    success:(RequestCallBlock)success
                      faild:(RequestCallBlock)faild;

#pragma mark -- PUT
- (BFEURLSessionTask *)put:(NSString*)urlString
               requestType:(BFERequestType)requestType
                parameters:(NSDictionary *)patameters
          loadingOnTheView:(UIView *)view
              loadingTitle:(NSString *)title
              needLoadView:(BOOL)needLoadView
           needAccessToken:(BOOL)needAccessToken
                   success:(RequestCallBlock)success
                     faild:(RequestCallBlock)faild;

- (BFEURLSessionTask *)put:(NSString*)urlString
               requestType:(BFERequestType)requestType
                parameters:(NSDictionary *)patameters
              needLoadView:(BOOL)needLoadView
           needAccessToken:(BOOL)needAccessToken
                   success:(RequestCallBlock)success
                     faild:(RequestCallBlock)faild;
#pragma mark -- DELETE
/**
 *  DELETE
 *
 *  @param urlString       请求地址
 *  @param requestType     请求数据格式（默认JSON）
 *  @param patameters      参数
 *  @param view            显示加载动画的view（为nil时，默认view == window）
 *  @param title           加载提示
 *  @param needLoadView    是否需要加载动画
 *  @param needAccessToken 是否有需要accessToken
 *  @param success         成功回调
 *  @param faild           失败回调
 */
- (BFEURLSessionTask *)Delete:(NSString*)urlString
                  requestType:(BFERequestType)requestType
                   parameters:(NSDictionary *)patameters
             loadingOnTheView:(UIView *)view
                 loadingTitle:(NSString *)title
                 needLoadView:(BOOL)needLoadView
              needAccessToken:(BOOL)needAccessToken
                      success:(RequestCallBlock)success
                        faild:(RequestCallBlock)faild;

- (BFEURLSessionTask *)Delete:(NSString*)urlString
                  requestType:(BFERequestType)requestType
                   parameters:(NSDictionary *)patameters
                 needLoadView:(BOOL)needLoadView
              needAccessToken:(BOOL)needAccessToken
                      success:(RequestCallBlock)success
                        faild:(RequestCallBlock)faild;

#pragma mark -- DOWNLOAD
/**
 *  DOWNLOAD
 *
 *  @param url              下载地址
 *  @param requestTag       请求tag
 *  @param localFilePath    下载到本地的地址
 *  @param requestType      请求类型
 *  @param paramaeters      参数
 *  @param needAccessToken  是否需要AccessToken
 *  @param progressCallBack 下载进度
 *  @param responseCallBack 下载结果
 *  @param success         成功回调
 *  @param faild           失败回调
 *  @return 下载任务
 */
- (BFEURLSessionTask *)DownloadFrom:(NSString *)urlString
                             toFile:(NSString *)localFilePath
                        requestType:(BFERequestType)requestType
                         parameters:(NSDictionary *)paramaeters
                    needAccessToken:(BOOL)needAccessToken
                           progress:(ProgressCallBack)progress
                            success:(RequestCallBlock)success
                              faild:(RequestCallBlock)faild;

#pragma mark -- commonMethod
/**
 *  解析请求数据（NSData ——> NSDictionary）
 */
+ (id)parseObjectFromRequest:(BFEHTTPServer *)request;

/**
 *  url编码
 */
- (NSString*)urlEncode:(NSString*)urlPara;

/**
 *  获取服务器地址
 */
- (NSString*)getServerAddress;


#pragma mark Help Method
+ (NSString *)notNil:(NSString *)sender;
+ (NSString *)reportTimeString;

@end
