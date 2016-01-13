//
//  CTHTTPClient.m
//  CTRIP_WIRELESS
//
//  Created by jimzhao on 14-5-26.
//  Copyright (c) 2014年 携程. All rights reserved.
//

#import "CTHTTPClient.h"
//#import "StringUtil.h"
//#import "CTCommConfig.h"
#import "AFURLConnectionOperation.h"
//#import "JSONKit.h"
#import "NSTimer+BlocksKit.h"
#import <objc/runtime.h>
//#import "CTNetworkUtil.h"
//#import "NSString+CTURL.h"

#pragma mark - ----
static char key_AFHTTPRequestOperation_Key;

@interface AFHTTPRequestOperation(CTExt)

- (id)extObject;

- (void)setExtObject:(id)extObj;

@end

@implementation AFHTTPRequestOperation(CTExt)

- (id)extObject
{
    return objc_getAssociatedObject(self, &key_AFHTTPRequestOperation_Key);
}

- (void)setExtObject:(id)extObj
{
    objc_setAssociatedObject(self, &key_AFHTTPRequestOperation_Key, extObj, OBJC_ASSOCIATION_RETAIN);
}

@end


#pragma mark - ----

@interface CTHTTPClient()
{
    
}

@property (nonatomic, strong) AFHTTPRequestOperationManager *inner_httpRequestManager;

- (void)inner_asyncHTTPRequest:(NSString *)url
                     paramters:(NSDictionary *)paramDict
                        method:(NSString *)method
                       timeout:(NSUInteger)timeout
                       success:(AFSuccessBlock)successBlock
                         faild:(AFFaildBlock)faildBlock;

@end

@implementation CTHTTPClient

#pragma mark - ---- 初始化

+ (instancetype)client
{
    return [[self alloc] init];
}

- (CTHTTPClient *)init
{
    if (self = [super init]) {
        self.inner_httpRequestManager = [AFHTTPRequestOperationManager manager];
        [self resetSerializer];
    }
    
    return self;
}

-(void)allowInvalidCertificatesForHttpsIndev
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    self.inner_httpRequestManager.securityPolicy = securityPolicy;
}

- (void)resetSerializer
{
    self.inner_httpRequestManager.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
    self.inner_httpRequestManager.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
}

- (AFHTTPRequestOperationManager *)httpRequestManager
{
    return self.inner_httpRequestManager;
}

- (void)setValue:(id)value forHTTPHeaderKey:(NSString *)key
{
    [self.inner_httpRequestManager.requestSerializer setValue:value forHTTPHeaderField:key];
}

#pragma mark - ----- 各种请求发送

- (void)asyncRawDataGet:(NSString *)url
              paramters:(NSDictionary *)kvParams
                timeout:(NSUInteger)timeout
                success:(AFSuccessBlock)successBlock
                  faild:(AFFaildBlock)faildBlock
{
    
    [self inner_asyncHTTPRequest:url
                       paramters:kvParams
                          method:@"GET"
                         timeout:timeout
                         success:successBlock
                           faild:faildBlock];
}

- (void)asyncRawDataPost:(NSString *)url
               paramters:(NSDictionary *)paramDict
                 timeout:(NSUInteger)timeout
                 success:(AFSuccessBlock)successBlock
                   faild:(AFFaildBlock)faildBlock
{
    NSParameterAssert(url);
    [self inner_asyncHTTPRequest:url
                       paramters:paramDict
                          method:@"POST"
                         timeout:timeout
                         success:successBlock
                           faild:faildBlock];
}

- (void)asyncRawDataRequest:(NSURLRequest *)request
                    timeout:(NSUInteger)timeout
                    success:(AFSuccessBlock)successBlock
                      faild:(AFFaildBlock)faildBlock
{
    NSParameterAssert(request);
    
    __block int fTimeout = (int)timeout;
    
    if (timeout > kMaxTimeout || timeout < kMinTimeout) {
        fTimeout = kDefaultTimeout;
    }
    CFAbsoluteTime startTimestamp = CFAbsoluteTimeGetCurrent();
    
    AFHTTPRequestOperation *opt = [self.inner_httpRequestManager HTTPRequestOperationWithRequest:request
                                                                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                                             NSTimer *timer = (NSTimer *)opt.extObject;
                                                                                             [timer invalidate];
                                                                                             timer = nil;
                                                                                             [CTHTTPClient logHTTPRequestMetrics:operation
                                                                                                                  startTimestamp:startTimestamp
                                                                                                                           error:nil];
                                                                                             
                                                                                             if (successBlock) {
                                                                                                 successBlock(operation, responseObject);
                                                                                             }
                                                                                         }
                                                                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                                             [CTHTTPClient logHTTPRequestMetrics:operation
                                                                                                                  startTimestamp:startTimestamp
                                                                                                                           error:error];
                                                                                             NSTimer *timer = (NSTimer *)opt.extObject;
                                                                                             [timer invalidate];
                                                                                             timer = nil;
                                                                                             if (faildBlock) {
                                                                                                 faildBlock(operation, error);
                                                                                             }
                                                                                         }];
    
    NSTimer *timerd = [NSTimer bk_scheduledTimerWithTimeInterval:fTimeout
                                                           block:^(NSTimer *timer) {
                                                               
                                                               [opt cancel];
                                                               [opt setExtObject:nil];
                                                               if(!opt.isFinished && !opt.isCancelled) {
                                                                   NSError *timeoutError = [self timeoutError:fTimeout];
                                                                   [CTHTTPClient logHTTPRequestMetrics:opt
                                                                                        startTimestamp:startTimestamp
                                                                                                 error:timeoutError];
                                                                   if (faildBlock) {
                                                                       faildBlock(opt, timeoutError);
                                                                   }
                                                               }
                                                               [timer invalidate];
                                                               timer = nil;
                                                           }
                                                         repeats:NO];
    [opt setExtObject:timerd];
    [self.inner_httpRequestManager.operationQueue  addOperation:opt];
}


#pragma mark - ---- 请求取消

- (void)cancelRequest:(NSString*)url
{
    if (url == nil) {
        return;
    }
    
    NSArray *opts = self.inner_httpRequestManager.operationQueue.operations;
    for (AFHTTPRequestOperation *opt in opts) {
        if ([[opt.request.URL.absoluteString lowercaseString] hasPrefix:[url lowercaseString]]) {
            [opt cancel];
            NSTimer *timer = (NSTimer*)opt.extObject;
            [timer invalidate];
            timer = nil;
        }
    }
}

- (void)cancelAllRequest
{
    NSArray *opts = self.inner_httpRequestManager.operationQueue.operations;
    for (AFHTTPRequestOperation *opt in opts) {
        NSTimer *timer = (NSTimer*)opt.extObject;
        [timer invalidate];
        timer = nil;
    }
    [self.inner_httpRequestManager.operationQueue cancelAllOperations];
}

#pragma mark - ---- inner

- (NSError *)timeoutError:(int)timeout
{
    return [NSError errorWithDomain:[NSString stringWithFormat:@"网络请求超过设置的超时时间[%d]", timeout] code:kTimeoutErrorCode userInfo:nil];
}


+ (void)logHTTPRequestMetrics:(AFHTTPRequestOperation *)operation
               startTimestamp:(CFAbsoluteTime)stTimestamp
                        error:(NSError *)error
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:operation.request.URL.absoluteString forKey:@"requestUrl"];
    [params setValue:operation.request.HTTPMethod forKey:@"method"];
    [params setValue:[NSNumber numberWithInteger:operation.response.statusCode] forKey:@"statusCode"];
    [params setValue:error.domain forKey:@"error_reason"];
    
    NSNumber *metrics = [NSNumber numberWithDouble:CFAbsoluteTimeGetCurrent()-stTimestamp];
    if(stTimestamp == 0) {
        metrics = [NSNumber numberWithDouble:0];
    }
 
}


- (void)inner_asyncHTTPRequest:(NSString *)url
                     paramters:(NSDictionary *)paramDict
                        method:(NSString *)method
                       timeout:(NSUInteger)timeout
                       success:(AFSuccessBlock)successBlock
                         faild:(AFFaildBlock)faildBlock
{
    NSParameterAssert(url);
    NSParameterAssert(method);
    
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.inner_httpRequestManager.requestSerializer requestWithMethod:method
                                                                                            URLString:url
                                                                                           parameters:paramDict
                                                                                                error:&serializationError];
    if (serializationError && faildBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            faildBlock(nil, serializationError);
        });
    } else {
        [self asyncRawDataRequest:request timeout:timeout success:successBlock faild:faildBlock];
    }
}


@end


#pragma mark - ----- JSON Request

@implementation CTHTTPClient(JSON)

/**
 *  发送GET请求，服务端返回的数据会被JSON Decode，再通过callback返回
 *
 *  @param url          请求的URL，参数带在URL里面，不能为空
 *  @param timeout    timeout时间，单位是秒, 如果timeout>=kMaxTimeout(120秒)||timeout<=kMinTimeout(3秒)时候，会使用默认值kDefaultTimeout(15秒)
 *  @param successBlock 成功回调
 *  @param faildBlock   失败回调
 */
- (void)asyncJSONGet:(NSString *)url
           paramters:(NSDictionary *)kvParams
             timeout:(NSUInteger)timeout
             success:(AFSuccessBlock)successBlock
               faild:(AFFaildBlock)faildBlock
{
    [self asyncRawDataGet:url
                paramters:kvParams
                  timeout:timeout
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      [CTHTTPClient JSONRequestSuccessCallbackWithOperation:operation
                                                                   response:responseObject
                                                               successBlock:successBlock
                                                                 faildBlock:faildBlock];
                  }
                    faild:faildBlock];
}



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
                faild:(AFFaildBlock)faildBlock
{
    [self asyncRawDataPost:url
                 paramters:paramDict
                   timeout:timeout success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       [CTHTTPClient JSONRequestSuccessCallbackWithOperation:operation
                                                                    response:responseObject
                                                                successBlock:successBlock
                                                                  faildBlock:faildBlock];
                   }
                     faild:faildBlock];
}


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
                   faild:(AFFaildBlock)faildBlock
{
    [self asyncRawDataRequest:request
                      timeout:timeout success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          [CTHTTPClient JSONRequestSuccessCallbackWithOperation:operation
                                                                       response:responseObject
                                                                   successBlock:successBlock
                                                                     faildBlock:faildBlock];
                      }
                        faild:faildBlock];
    
}





#pragma mark - --- inner API

+ (id)objectFromJSONResponseData:(NSData *)responseData
{
    NSError *error = nil;
    id retObj = nil;
    if (responseData == nil) {
        error = [NSError errorWithDomain:@"JSON_Decode_Empty_Response" code:-1001 userInfo:nil];
    }
    else {
        retObj = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    }
    
    if (error == nil && retObj != nil) {
        return retObj;
    }
    else {
        error = [NSError errorWithDomain:@"JSON_Decode_Failed" code:-1002 userInfo:nil];
        return error;
    }
}

+ (void)JSONRequestSuccessCallbackWithOperation:(AFHTTPRequestOperation*)operation
                                       response:(id)responseObject
                                   successBlock:(AFSuccessBlock)cbSuccessBlock
                                     faildBlock:(AFFaildBlock)cbFaildBlock
{
    
    if (cbSuccessBlock != nil) {
        id retObj = [CTHTTPClient objectFromJSONResponseData:responseObject];
        if ([retObj isKindOfClass:[NSError class]]) {
            [CTHTTPClient logHTTPRequestMetrics:operation startTimestamp:0 error:retObj];
            if (cbFaildBlock != nil) {
                cbFaildBlock(operation, retObj);
            }
        }
        else {
            cbSuccessBlock(operation, retObj);
        }
    }
}

@end