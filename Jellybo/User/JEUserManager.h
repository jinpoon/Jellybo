//
//  JEUserManager.h
//  Jellybo
//
//  Created by POON on 16/5/3.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEUserManager : NSObject
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *userId;


+ (instancetype)manager;

@end
