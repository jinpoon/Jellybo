//
//  JEUserManager.m
//  Jellybo
//
//  Created by POON on 16/5/3.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "JEUserManager.h"

@implementation JEUserManager

+ (instancetype)manager{
    static JEUserManager *manager = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        manager = [[JEUserManager alloc] init];
    });
    return manager;
}

- (instancetype) init{
    if(self = [super init]){
        
    }
    return self;
}

@end
