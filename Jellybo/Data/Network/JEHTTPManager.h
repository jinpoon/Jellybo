//
//  JEHTTPManager.h
//  Jellybo
//
//  Created by POON on 16/5/2.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger, JERequestMethod) {
    JERequestMethodGET    = 1,
    JERequestMethodPOST   = 2,
    JERequestMethodPUT    = 3,
    JERequestMethodDELETE = 4,
};

@interface JEHTTPManager : NSObject

+ (instancetype)manager;

- (NSURLSessionDataTask *) requestWithMethod:(JERequestMethod)requestMethod
                                   URLString:(NSString *)URLString
                                  parameters:(NSDictionary *)parameters
                                     success:(void (^)(NSURLSessionDataTask *task, id respondObject))success
                                     failure:(void (^)(NSError *error))failure;


@end
