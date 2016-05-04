//
//  JEHTTPManager+User.h
//  Jellybo
//
//  Created by POON on 16/5/4.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JEHTTPManager.h"

@interface JEHTTPManager(User)

- (void)getProfileImgWithUrl:(NSString *)url success:(void(^)(NSData *data)) success failure:(void(^)(NSError *error)) failure;

@end
