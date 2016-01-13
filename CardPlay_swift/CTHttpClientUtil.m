//
//  CTHttpClientUtil.m
//  CardPlay_swift
//
//  Created by wudi on 1/11/16.
//  Copyright © 2016 wudi. All rights reserved.
//

#import "CTHttpClientUtil.h"

@implementation CTHttpClientUtil

+ (NSMutableURLRequest *)URLRequestForSOAGet:(NSURL *)url
                                  parameters:(NSDictionary *)params{
    NSMutableString *urlStr = [NSMutableString stringWithString:url.absoluteString];
    
    if (![urlStr hasSuffix:@"?"]) {
        [urlStr appendFormat:@"?"];
    }
    NSArray *allKeys = [params allKeys];
    for (NSString *aKey in allKeys) {
        if ([[params valueForKey:aKey] isKindOfClass:[NSArray class]]) {
            NSArray *arrays = [params valueForKey:aKey];
            for (id object in arrays) {
                [urlStr appendFormat:@"%@=%@&", aKey, object];
            }
        }
        else{
            [urlStr appendFormat:@"%@=%@&", aKey, [params valueForKey:aKey]];
        }
    }
    if ([urlStr hasSuffix:@"&"] || [urlStr hasSuffix:@"?"]) {
        [urlStr deleteCharactersInRange:NSMakeRange(urlStr.length-1, 1)];
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                            timeoutInterval:5];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"GET"];
    return request;
}

@end
