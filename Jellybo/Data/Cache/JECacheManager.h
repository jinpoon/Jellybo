//
//  JECacheManager.h
//  Jellybo
//
//  Created by POON on 16/5/4.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString* JEHomeViewWeiboContentCache = @"JEHomeViewWeiboContentCache";

@interface JECacheManager : NSObject

+ (instancetype)manager;

- (void)setHomeWeiboContent:(id<NSCoding>)object forKey:(NSString *)aKey;//缓存首页微博


- (id<NSCoding>)homeWeiboContentObjectForKey:(NSString *)aKey;//取出首页微博缓存

- (void)removeObjectForKey:(NSString *)aKey;

- (void)clearCache;

@end
