//
//  JEBaseUserInfoModel.h
//  Jellybo
//
//  Created by POON on 16/5/2.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JEBaseModel.h"
@class JEBaseWeiboContentModel;

@interface JEBaseUserInfoModel : JEBaseModel
@property (nonatomic, copy) NSString *u_id;
@property (nonatomic, assign) NSInteger u_class;
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, assign) NSInteger province_code;
@property (nonatomic, assign) NSInteger city_code;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *u_description;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *profileImgUrl;
@property (nonatomic, copy) NSString *coverImgPhoneUrl;
@property (nonatomic, copy) NSString *profileUrl;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, assign) NSInteger followersCount;//粉丝数
@property (nonatomic, assign) NSInteger friendsCount;//关注数
@property (nonatomic, assign) NSInteger pageFriendsCount;
@property (nonatomic, assign) NSInteger statusesCount;//微博数
@property (nonatomic, assign) NSInteger favouritesCount;//收藏数
@property (nonatomic, copy) NSString *userCreateTime;
@property (nonatomic, assign) BOOL following;
@property (nonatomic, assign) BOOL verified;
@property (nonatomic, assign) NSInteger verified_type; //不可用
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, strong) JEBaseWeiboContentModel *lastestWeibo;
@property (nonatomic, assign) BOOL isAllowAllComment;
@property (nonatomic, copy) NSString *avatar_large_url;
@property (nonatomic, copy) NSString *avatar_hd_url;
@property (nonatomic, assign) BOOL isFollowMe;
@property (nonatomic, assign) NSInteger onlineStatus;
@property (nonatomic, assign) NSInteger biFollowCount; //互粉数



- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
