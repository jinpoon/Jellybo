//
//  JEBaseWeiboContentModel.h
//  Jellybo
//
//  Created by POON on 16/5/2.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JEGeoInfoModel.h"
#import "JEBaseUserInfoModel.h"
#import "JEBaseModel.h"

@interface JEBaseWeiboContentModel : JEBaseModel

@property (nonatomic, copy) NSString      *createTime;
@property (nonatomic, copy) NSString      *w_id;
@property (nonatomic, copy) NSString      *textContent;
@property (nonatomic, assign) NSInteger   textLength;
@property (nonatomic, assign) NSInteger   sourceType;
@property (nonatomic, copy) NSString      *source;
@property (nonatomic, assign) BOOL         favorited;
@property (nonatomic, assign) BOOL         truncated;
@property (nonatomic, strong) NSArray     *thumbnail_pics_urls;
@property (nonatomic, strong) NSArray     *bmiddle_pics_urls;
@property (nonatomic, strong) NSArray     *large_pics_urls;
@property (nonatomic, strong) JEGeoInfoModel *geoInfo;
@property (nonatomic, strong) JEBaseUserInfoModel *userInfo;
@property (nonatomic, assign) NSInteger   reposts_count;
@property (nonatomic, assign) NSInteger   comments_count;
@property (nonatomic, assign) NSInteger   attitudes_count;
@property (nonatomic, assign) BOOL        isLongText;

- (instancetype)initWithDictionary:(NSDictionary *)dict;


@end
