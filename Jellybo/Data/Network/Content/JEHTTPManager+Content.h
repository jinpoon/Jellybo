//
//  JEHTTPManager+Content.h
//  Jellybo
//
//  Created by POON on 16/5/3.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JEHTTPManager.h"
#import "JEBaseWeiboContentModel.h"

@interface JEHTTPManager(Content)

- (void)getHomeTimelineWeiboContentListWithSinceId: (NSInteger)sinceId maxId:(NSInteger)maxId count:(NSInteger)count feature:(JEWeiboFeature)feature ifTimeUser:(BOOL)trimUser success:(void(^)(JEBaseWeiboContentListModel *list)) success failure:(void(^)(NSError *error)) failure;

@end
