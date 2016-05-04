//
//  JEHTTPManager+Content.m
//  Jellybo
//
//  Created by POON on 16/5/3.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "JEHTTPManager+Content.h"
#import "JEBaseWeiboContentModel.h"

@implementation JEHTTPManager(Content);

- (void)getHomeTimelineWeiboContentListWithSinceId: (NSInteger)sinceId maxId:(NSInteger)maxId count:(NSInteger)count feature:(JEWeiboFeature)feature ifTimeUser:(BOOL)trimUser success:(void(^)(JEBaseWeiboContentListModel *list)) success failure:(void(^)(NSError *error)) failure{
    NSString *urlString = API_HOME_TIMELINE;
    
    NSInteger ifTimeUser = trimUser? 1: 0;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   [JEUserManager manager].accessToken,k_accessToken,
                                   @(sinceId), k_since_id,
                                   @(maxId), k_max_id,
                                   @(count), k_count,
                                   @(feature), k_feature,
                                   @(ifTimeUser), k_trim_user,
                                   nil];
    [self requestWithMethod:JERequestMethodGET URLString:urlString parameters:params success:^(NSURLSessionDataTask *task, id responseObject){
        NSDictionary *dict = responseObject;
        JEBaseWeiboContentListModel *listModel = [[JEBaseWeiboContentListModel alloc] initWithDictionary:dict];
        if(success){
            success(listModel);
        }
        
    }failure:^(NSError *error){
        if(failure){
            failure(error);
        }
    }];
}

@end
