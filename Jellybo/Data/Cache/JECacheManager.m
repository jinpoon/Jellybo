//
//  JECacheManager.m
//  Jellybo
//
//  Created by POON on 16/5/4.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "JECacheManager.h"


static NSTimeInterval const kTimeoutInterval    = 7 * 24 * 60 * 60;

static NSString * const kContentCacheName = @"kHomeContentCache";

@interface JECacheManager()

@property (nonatomic, strong) TMDiskCache *homeContentCache;

@end

@implementation JECacheManager

- (instancetype)init {
    if (self = [super init]) {
        
        _homeContentCache = [[TMDiskCache alloc] initWithName:kContentCacheName rootPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
        _homeContentCache.ageLimit = kTimeoutInterval;
        
        
    }
    return self;
}

+ (instancetype)manager{
    static JECacheManager *manager = nil;
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JECacheManager alloc] init];
    });
    return manager;
}

- (void)setHomeWeiboContent:(id<NSCoding>)object forKey:(NSString *)aKey{
    [self.homeContentCache setObject:object forKey:aKey];
}

- (id<NSCoding>)homeWeiboContentObjectForKey:(NSString *)aKey{
    return [self.homeContentCache objectForKey:aKey];
}

- (void)removeObjectForKey:(NSString *)aKey{
    [self.homeContentCache removeObjectForKey:aKey];
}

- (void)clearHomeContentCache{
    [self.homeContentCache removeAllObjects];
}


@end
