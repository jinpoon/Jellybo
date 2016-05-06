//
//  JEBaseWeiboContentModel.m
//  Jellybo
//
//  Created by POON on 16/5/2.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "JEBaseWeiboContentModel.h"
#import <AFNetworking/AFNetworking.h>

@implementation JEBaseWeiboContentModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if(self = [super initWithDictionary:dict]){
        self.createTime = [dict objectForSafeKey:k_create_time];
        self.w_id = [dict objectForSafeKey:k_weibo_idstr];
        self.textContent = [dict objectForSafeKey:k_text_content];
        self.textLength = [[dict objectForSafeKey:k_text_length] integerValue];
        self.sourceType = [[dict objectForSafeKey:k_source_type] integerValue];
        self.source = [dict objectForSafeKey:k_source];
        self.favorited = [[dict objectForSafeKey:k_favorited] boolValue];
        self.truncated = [[dict objectForSafeKey:k_truncated] boolValue];
        self.thumbnail_pics_urls = [dict objectForSafeKey:k_pics_urls];//初始数据是一个字典序列
        [self hanlePicsUrl];
        //self.geoInfo = [dict objectForSafeKey:k_geo];
        self.userInfo = nil;
        NSDictionary *userInfoDict = [dict objectForSafeKey:k_user];
        if(userInfoDict){
            self.userInfo = [[JEBaseUserInfoModel alloc] initWithDictionary:userInfoDict];
        }
        self.reposts_count = [[dict objectForSafeKey:k_reposts_count] integerValue];
        self.comments_count = [[dict objectForSafeKey:k_comments_count] integerValue];
        self.attitudes_count = [[dict objectForSafeKey:k_attitudes_count] integerValue];
        self.isLongText = [[dict objectForSafeKey:k_is_long_text] boolValue];
        
    }
    return self;
}

- (void)hanlePicsUrl{
    if (self.thumbnail_pics_urls.count == 0) {
        self.thumbnail_pics_urls = nil;
        return;
    }
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *bmiddle_array = [[NSMutableArray alloc] init];
    NSMutableArray *large_array = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.thumbnail_pics_urls) {
        [array addObject:[dict objectForSafeKey:@"thumbnail_pic"]];
    }
    self.thumbnail_pics_urls = [NSArray arrayWithArray:array];
    
    for (NSString *str in array) {
        [bmiddle_array addObject:[str stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"]];
        [large_array addObject:[str stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large_pic"]];
    }
    self.bmiddle_pics_urls = [NSArray arrayWithArray:bmiddle_array];
    self.large_pics_urls = [NSArray arrayWithArray:large_array];
}

@end

@implementation JEBaseWeiboContentListModel

- (instancetype) initWithDictionary:(NSDictionary *)dict{
    if(self = [super initWithDictionary:dict]){
        self.list = [[NSMutableArray alloc] init];
        NSArray *contents = [dict objectForSafeKey:@"statuses"];
        for (NSDictionary *dicts in contents) {
            JEBaseWeiboContentModel *weibocontentModel = [[JEBaseWeiboContentModel alloc] initWithDictionary:dicts];
            [self.list addObject:weibocontentModel];
        }
        
    }
    return self;
}

- (void)insertListModelsFromHead:(JEBaseWeiboContentListModel *)newList{
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];
    for(int i = 0;i < newList.list.count;i++)
    {
        [indexes addIndex:i];
    }
    [self.list insertObjects:newList.list atIndexes:indexes];
}

@end
