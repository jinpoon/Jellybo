//
//  JEHTTPManager+User.m
//  Jellybo
//
//  Created by POON on 16/5/4.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "JEHTTPManager+User.h"

@implementation JEHTTPManager(User)

- (void)getProfileImgWithUrl:(NSString *)url success:(void(^)(NSData *data)) success failure:(void(^)(NSError *error)) failure{
    [self requestWithMethod:JERequestMethodGET URLString:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject){
        NSData *data = responseObject;
        if(data){
            if(success){
                success(data);
            }
        }
        
    }failure:^(NSError *error){
        NSLog(@"error: %@: %ld",error.description, error.code);
    }];
}

@end
