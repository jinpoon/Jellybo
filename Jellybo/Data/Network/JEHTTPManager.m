//
//  JEHTTPManager.m
//  Jellybo
//
//  Created by POON on 16/5/2.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "JEHTTPManager.h"
@interface JEHTTPManager()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation JEHTTPManager

+ (instancetype)manager{
    static JEHTTPManager *kmanager = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        kmanager = [[JEHTTPManager alloc] init];
    });
    return kmanager;
}

- (instancetype)init {
    if (self = [super init]) {
        
        self.manager = [[AFHTTPSessionManager alloc] init];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"text/plain",
                                                                  @"application/json",
                                                                  @"text/json",
                                                                  @"text/javascript",
                                                                  @"text/html",
                                                                  @"image/jpeg",
                                                                  @"image/jpg",
                                                                  nil];
    }
    
    return self;
}

- (NSURLSessionDataTask *) requestWithMethod:(JERequestMethod)requestMethod
                                   URLString:(NSString *)URLString
                                  parameters:(NSDictionary *)parameters
                                     success:(void (^)(NSURLSessionDataTask *task, id respondObject))success
                                     failure:(void (^)(NSError *error))failure{
    // stateBar
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    void (^successHandleBlock)(NSURLSessionDataTask *task, id respondObject)
    = ^(NSURLSessionDataTask *task, id respondObject){
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if(success){
            success(task, respondObject);
        }
    };
    
    void (^failureHandleBlock)(NSURLSessionDataTask *task, NSError *error) = ^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        NSData *jsonData = [error.userInfo objectForKey:@"error"];
        NSDictionary *jsonDict = [jsonData objectFromJSONData];
        
        if (jsonData) {
            
            if (jsonDict == nil){
                if (failure) {
                    failure(error);
                }
            }
            else {
                //NSError *ksError = [[NSError alloc] initWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:[[jsonDict objectForSafeKey:@"err"] integerValue]   userInfo:jsonDict];
                if (failure) {
                    failure(error);
                }
                
               
            }
            
        } else {
            if (failure) {
                failure(error);
            }
        }

    };
    
    // Create HTTPSession
    NSURLSessionDataTask *task;
    
    if (requestMethod == JERequestMethodGET) {
        task = [self.manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
            successHandleBlock(task, responseObject);
        }failure:^(NSURLSessionDataTask *task, NSError *error){
            failureHandleBlock(task, error);
        }];
    }
    if (requestMethod == JERequestMethodPOST) {
        task = [self.manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            successHandleBlock(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failureHandleBlock(task, error);
        }];
    }
    if (requestMethod == JERequestMethodPUT){
        task = [self.manager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            successHandleBlock(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failureHandleBlock(task, error);
        }];
    }
    if (requestMethod == JERequestMethodDELETE){
        task = [self.manager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            successHandleBlock(task, responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            failureHandleBlock(task, error);
        }];
    }
    return task;
}

@end
