//
//  JEApiKeys.h
//  Jellybo
//
//  Created by POON on 16/5/2.
//  Copyright © 2016年 JIN. All rights reserved.
//

#ifndef JEApiKeys_h
#define JEApiKeys_h

#pragma mark - user
static NSString *const k_accessToken = @"access_token";
static NSString *const k_user_id = @"idstr";
static NSString *const k_class   = @"class";
static NSString *const k_screen_name  = @"screen_name";
static NSString *const k_user_name = @"name";
static NSString *const k_province  = @"province";
static NSString *const k_city      = @"city";
static NSString *const k_location  = @"location";
static NSString *const k_description = @"description";
static NSString *const k_user_url = @"url";
static NSString *const k_profile_image_url = @"profile_image_url";
static NSString *const k_cover_image_phone = @"cover_image_phone";
static NSString *const k_profile_url = @"profile_url";
static NSString *const k_domain = @"domain";
static NSString *const k_gender = @"gender";
static NSString *const k_followers_count = @"followers_count";
static NSString *const k_friends_count = @"friends_count";
static NSString *const k_page_friends_count = @"page_friends_count";
static NSString *const k_statuses_count = @"statuses_count";
static NSString *const k_favourites_count = @"favourites_count";
static NSString *const k_user_created_at = @"created_at";
static NSString *const k_following = @"following";
static NSString *const k_verified = @"verified";
static NSString *const k_verified_type = @"verified_type";
static NSString *const k_remark = @"remark";
static NSString *const k_latest_status = @"status";
static NSString *const k_allow_all_comment = @"allow_all_comment";
static NSString *const k_avatar_large = @"avatar_large";
static NSString *const k_avatar_hd = @"avatar_hd";
static NSString *const k_follow_me = @"follow_me";
static NSString *const k_online_status = @"online_status";
static NSString *const k_bi_followers_count = @"bi_followers_count"; //用户互粉数;
static NSString *const k_lang = @"lang";


#pragma mark - content
typedef NS_ENUM(NSInteger, JEWeiboFeature){
    JEWeiboFeatureAll = 0,
    JEWeiboFeatureOriginal = 1,
    JEWeiboFeaturePics = 2,
    JEWeiboFeatureVideos = 3,
    JEWeiboFeatureMusic = 4,
};

static NSString *const k_weibo_id = @"id";
static NSString *const k_since_id = @"since_id";
static NSString *const k_max_id   = @"max_id";
static NSString *const k_count = @"count";
static NSString *const k_page  = @"page";
static NSString *const k_feature = @"feature";
static NSString *const k_trim_user = @"trim_user";
static NSString *const k_create_time = @"created_at";
static NSString *const k_weibo_idstr = @"idstr";
static NSString *const k_text_content = @"text";
static NSString *const k_text_length = @"textLength";
static NSString *const k_source_type = @"source_type";
static NSString *const k_source = @"source";
static NSString *const k_favorited = @"favorited";
static NSString *const k_truncated = @"truncated";
static NSString *const k_pics_urls = @"pic_url";
static NSString *const k_geo = @"geo";
static NSString *const k_user = @"user";
static NSString *const k_reposts_count = @"reposts_count";
static NSString *const k_comments_count = @"comments_count";
static NSString *const k_attitudes_count = @"attitudes_count";
static NSString *const k_is_long_text = @"isLongText";

#define API_HOME_TIMELINE                @"https://api.weibo.com/2/statuses/home_timeline.json"
#define API_FRIENDS_TIMELINE_ID          @"https://api.weibo.com/2/statuses/friends_timeline/ids.json"
#define API_USER_TIMELINE                @"https://api.weibo.com/2/statuses/user_timeline.json"
#define API_USER_TIMELINE_ID             @"https://api.weibo.com/2/statuses/user_timeline/ids.json"
#define API_REPOSTS_TIMELINE             @"https://api.weibo.com/2/statuses/repost_timeline.json"
#define API_MENTIONS_TIMELINE            @"https://api.weibo.com/2/statuses/mentions.json"



#endif /* JEApiKeys_h */
