//
//  izyHttpClient.h
//  izyou
//
//  Created by wudi on 3/13/16.
//  Copyright © 2016 wudi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,eizyHttpType){
    izyHttpTypeLogin = 0,
    izyHttpTypeNotes,
    izyHttpTypeNote,
    izyHttpTypeProblem,
    izyHttpTypeCourse,
    izyHttpTypeRegister,
    izyHttpTypeFeedBack,
    izyHttpTypeUpdate,
    izyHttpTypeBanners
};
/**
 *  izy所有http请求封装到这里面
 */
@interface izyHttpClient : NSObject
/**
 *  对外暴露这个接口处理app所有http 请求
 *
 */
+ (void)asyncHttp:(eizyHttpType)httpType
           isPost:(BOOL)isPost
       parameters:(NSDictionary *)parameters
          timeout:(NSUInteger)timeout
          success:(AFSuccessBlock)successBlock
            faild:(AFFaildBlock)faildBlock;
@end
