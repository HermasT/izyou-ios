//
//  CTHttpClientUtil.h
//  CardPlay_swift
//
//  Created by wudi on 1/11/16.
//  Copyright © 2016 wudi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTHttpClientUtil : NSObject

+ (NSMutableURLRequest *)URLRequestForSOAGet:(NSURL *)url
                                  parameters:(NSDictionary *)params;
@end
