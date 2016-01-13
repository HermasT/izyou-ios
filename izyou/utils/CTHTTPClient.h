//
//  CTHTTPClient.h
//  CTRIP_WIRELESS
//
//  Created by jimzhao on 14-5-26.
//  Copyright (c) 2014年 携程. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import <Foundation/Foundation.h>


#define kDefaultTimeout 10
#define kMinTimeout 2
#define kMaxTimeout 120

#define kTimeoutErrorCode -111111


typedef void (^AFSuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^AFFaildBlock)(AFHTTPRequestOperation *operation, NSError *error);

typedef void (^AFJSONRequestSuccessBlock)(AFHTTPRequestOperation *operation, NSUInteger statusCode, NSDictionary *responseDict);


#pragma mark - ----

@interface CTHTTPClient : NSObject

#pragma mark - ---- 初始化

/**
 *  初始化
 *
 *  @param host 初始化CTHTTPClient对象，不是单例，每次内部new一个CTHTTPClient对象
 *
 *  @return 对象
 */
+ (CTHTTPClient *)client;
- (CTHTTPClient *)init;

-(void)allowInvalidCertificatesForHttpsIndev;

@property (readonly) AFHTTPRequestOperationManager *httpRequestManager;

#pragma mark - ---- HTTP 头

/**
 *  设置自定义HTTP 头
 *
 *  @param value value
 *  @param key   key
 */
- (void)setValue:(id)value forHTTPHeaderKey:(NSString *)key;

#pragma mark - ---- RawData网络请求

/**
 *  发送GET请求，服务端返回的原始数据(NSData)会通过callback返回
 *
 *  @param url          请求的URL，参数带在URL里面，不能为空
 *  @param kvParams     请求带的key/value参数
 *  @param timeout    timeout时间，单位是秒, 如果timeout>=kMaxTimeout(120秒)||timeout<=kMinTimeout(3秒)时候，会使用默认值kDefaultTimeout(15秒)
 *  @param successBlock 成功回调
 *  @param faildBlock   失败回调
 */
- (void)asyncRawDataGet:(NSString *)url
              paramters:(NSDictionary *)kvParams
                timeout:(NSUInteger)timeout
                success:(AFSuccessBlock)successBlock
                  faild:(AFFaildBlock)faildBlock;


/**
 *  发送Post请求, 服务端返回的原始数据(NSData)会通过callback返回
 *
 *  @param url          请求的URL，不能为空
 *  @param paramDict    post的参数key，value形式
 *  @param timeout     timeout时间，单位是秒,如果timeout>=kMaxTimeout(120秒)||timeout<=kMinTimeout(3秒)时候，会使用默认值kDefaultTimeout(15秒)
 *  @param successBlock 成功回调
 *  @param faildBlock   失败回调
 */
- (void)asyncRawDataPost:(NSString *)url
               paramters:(NSDictionary *)paramDict
                 timeout:(NSUInteger)timeout
                 success:(AFSuccessBlock)successBlock
                   faild:(AFFaildBlock)faildBlock;

/**
 *  发送自定义Request, 服务端返回的原始数据(NSData)会通过callback返回
 *
 *  @param request    发送的Request对象，不能为空
 *  @param timeout    timeout时间，单位是秒, 如果timeout>=kMaxTimeout(120秒)||timeout<=kMinTimeout(3秒)时候，会使用默认值kDefaultTimeout(15秒)
 *  @param successBlock 成功回调
 *  @param faildBlock   失败回调
 */
- (void)asyncRawDataRequest:(NSURLRequest *)request
                    timeout:(NSUInteger)timeout
                    success:(AFSuccessBlock)successBlock
                      faild:(AFFaildBlock)faildBlock;



#pragma mark - ---- 取消正在发送的网络请求

/**
 *  取消请求
 *
 *  @param url          请求的URL，不能为空
 */
- (void)cancelRequest:(NSString*)url;


/**
 *  取消所有请求
 *
 */
- (void)cancelAllRequest;

@end

#pragma mark - ----- JSON 网络请求

@interface CTHTTPClient(JSON)


/**
 *  发送GET请求，服务端返回的数据会被JSON Decode，再通过callback返回
 *
 *  @param url          请求的URL，参数带在URL里面，不能为空
 *  @param kvParams     请求带的key/value参数
 *  @param timeout    timeout时间，单位是秒, 如果timeout>=kMaxTimeout(120秒)||timeout<=kMinTimeout(3秒)时候，会使用默认值kDefaultTimeout(15秒)
 *  @param successBlock 成功回调
 *  @param faildBlock   失败回调
 */
- (void)asyncJSONGet:(NSString *)url
           paramters:(NSDictionary *)kvParams
             timeout:(NSUInteger)timeout
             success:(AFSuccessBlock)successBlock
               faild:(AFFaildBlock)faildBlock;


/**
 *  发送Post请求, 服务端返回的数据会被JSON Decode，再通过callback返回
 *
 *  @param url          请求的URL，不能为空
 *  @param paramDict    post的参数key，value形式
 *  @param timeout     timeout时间，单位是秒,如果timeout>=kMaxTimeout(120秒)||timeout<=kMinTimeout(3秒)时候，会使用默认值kDefaultTimeout(15秒)
 *  @param successBlock 成功回调
 *  @param faildBlock   失败回调
 */
- (void)asyncJSONPost:(NSString *)url
            paramters:(NSDictionary *)paramDict
              timeout:(NSUInteger)timeout
              success:(AFSuccessBlock)successBlock
                faild:(AFFaildBlock)faildBlock;


/**
 *  发送自定义Request, 服务端返回的数据会被JSON Decode，再通过callback返回
 *
 *  @param request    发送的Request对象，不能为空
 *  @param timeout    timeout时间，单位是秒, 如果timeout>=kMaxTimeout(120秒)||timeout<=kMinTimeout(3秒)时候，会使用默认值kDefaultTimeout(15秒)
 *  @param successBlock 成功回调
 *  @param faildBlock   失败回调
 */
- (void)asyncJSONRequest:(NSURLRequest *)request
                 timeout:(NSUInteger)timeout
                 success:(AFSuccessBlock)successBlock
                   faild:(AFFaildBlock)faildBlock;




@end