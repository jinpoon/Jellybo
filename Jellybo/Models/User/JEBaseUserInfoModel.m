//
//  JEBaseUserInfoModel.m
//  Jellybo
//
//  Created by POON on 16/5/2.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "JEBaseUserInfoModel.h"

@implementation JEBaseUserInfoModel
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if(self = [super initWithDictionary:dict]){
        self.u_id = [dict objectForSafeKey:k_user_id];
        self.u_class = [[dict objectForSafeKey:k_class] integerValue];
        self.screen_name = [dict objectForSafeKey:k_screen_name];
        self.user_name = [dict objectForSafeKey:k_user_name];
        self.province_code = [[dict objectForSafeKey:k_province] integerValue];
        self.city_code = [[dict objectForSafeKey:k_city] integerValue];
        self.location = [dict objectForSafeKey:k_location];
        self.u_description = [dict objectForSafeKey:k_description];
        self.url = [dict objectForSafeKey:k_user_url];
        self.profileImgUrl = [dict objectForSafeKey:k_profile_image_url];
        self.profileUrl = [dict objectForSafeKey:k_profile_url];
        self.coverImgPhoneUrl = [dict objectForSafeKey:k_cover_image_phone];
        self.gender = [dict objectForSafeKey:k_gender];
        self.followersCount = [[dict objectForSafeKey:k_followers_count] integerValue];
        self.friendsCount = [[dict objectForSafeKey:k_friends_count] integerValue];
        self.pageFriendsCount = [[dict objectForSafeKey:k_page_friends_count] integerValue];
        self.statusesCount = [[dict objectForSafeKey:k_statuses_count] integerValue];
        self.favouritesCount = [[dict objectForSafeKey:k_favourites_count] integerValue];
        self.userCreateTime = [dict objectForSafeKey:k_user_created_at];
        self.following = [[dict objectForSafeKey:k_following] boolValue];
        self.verified = [[dict objectForSafeKey:k_verified] boolValue];
        self.verified_type = [[dict objectForSafeKey:k_verified_type] integerValue];
        self.remark = [dict objectForSafeKey:k_remark];
        //self.latestweibo
        self.isAllowAllComment = [dict objectForSafeKey:k_allow_all_comment];
        self.avatar_large_url = [dict objectForSafeKey:k_avatar_large];
        self.avatar_hd_url = [dict objectForSafeKey:k_avatar_hd];
        self.isFollowMe = [[dict objectForSafeKey:k_follow_me] boolValue];
        self.onlineStatus = [[dict objectForSafeKey:k_online_status] integerValue];
        self.biFollowCount = [[dict objectForSafeKey:k_bi_followers_count] integerValue];
        
    }
    return self;
}


@end
