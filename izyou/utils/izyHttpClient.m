//
//  izyHttpClient.m
//  izyou
//
//  Created by wudi on 3/13/16.
//  Copyright © 2016 wudi. All rights reserved.
//

#import "izyHttpClient.h"
#import "CTHTTPClient.h"

@interface izyHttpClient(){
    
}
@property(nonatomic,strong)CTHTTPClient *client;
@end

@implementation izyHttpClient

+ (instancetype)httpClient{
    static id instance = nil;
    if (!instance) {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            instance = [[izyHttpClient alloc] init];
        });
    }
    return instance;
}

- (CTHTTPClient *)client{
    if (!_client) {
        _client = [[CTHTTPClient alloc] init];
    }
    return _client;
}

- (void)asyncGet:(NSString *)url
           paramters:(NSDictionary *)kvParams
             timeout:(NSUInteger)timeout
             success:(AFSuccessBlock)successBlock
               faild:(AFFaildBlock)faildBlock{
    [_client asyncJSONGet:url paramters:kvParams timeout:timeout success:successBlock faild:faildBlock];
}

- (void)asyncPost:(NSString *)url
            paramters:(NSDictionary *)paramDict
              timeout:(NSUInteger)timeout
              success:(AFSuccessBlock)successBlock
                faild:(AFFaildBlock)faildBlock
{
    [_client asyncJSONPost:url paramters:paramDict timeout:timeout success:successBlock faild:faildBlock];
}


+ (void)asyncHttp:(eizyHttpType)httpType isPost:(BOOL)isPost parameters:(NSDictionary *)parameters timeout:(NSUInteger)timeout success:(AFSuccessBlock)successBlock faild:(AFFaildBlock)faildBlock{
    if (isPost) {
        [[self httpClient] asyncGet:[self urlForHttpType:httpType] paramters:parameters timeout:timeout success:successBlock faild:faildBlock];
    }
}

+ (NSString *)urlForHttpType:(eizyHttpType)httpType{
    NSString *url = @"";
    switch (httpType) {
        case izyHttpTypeLogin:{
            url = stringAppend(izyURLHost, izyURLLogin)
        }
            break;
        case izyHttpTypeNotes:{
            url = stringAppend(izyURLHost, izyURLNotes)
        }
            break;
        case izyHttpTypeNote:{
            url = stringAppend(izyURLHost, izyURLNote)
        }
            break;
        case izyHttpTypeProblem:{
            url = stringAppend(izyURLHost, izyURLProblem)
        }
            break;
        case izyHttpTypeCourse:{
            url = stringAppend(izyURLHost, izyURLCourse)
        }
            break;
        case izyHttpTypeRegister:{
            url = stringAppend(izyURLHost, izyURLRegister)
        }
            break;
        case izyHttpTypeFeedBack:{
            url = stringAppend(izyURLHost, izyURLFeedBack)
            
        }
            break;
        case izyHttpTypeUpdate:{
            url = stringAppend(izyURLHost, izyURLUpdate)
        }
            break;
        case izyHttpTypeBanners:{
            url = stringAppend(izyURLHost, izyURLBanners)
            
        }
            break;
        default:
            break;
    }
    return url;
}



@end
