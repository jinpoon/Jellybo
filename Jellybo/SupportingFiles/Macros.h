//
//  Macros.h
//  Jellybo
//
//  Created by POON on 16/4/29.
//  Copyright © 2016年 JIN. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


#define kScreenHeight ([JEHelper screenSize].height)
#define kScreenWidth ([JEHelper screenSize].width)
#define kScreenSize ([JEHelper screenSize])
#define kScreenBounds ((CGRect){0, 0, kScreenWidth, kScreenHeight})

#define RGBA(c,a)    [UIColor colorWithRed:((c>>16)&0xFF)/256.0  green:((c>>8)&0xFF)/256.0   blue:((c)&0xFF)/256.0   alpha:a]
#define RGB(c)    [UIColor colorWithRed:((c>>16)&0xFF)/256.0  green:((c>>8)&0xFF)/256.0   blue:((c)&0xFF)/256.0   alpha:1.0f]
#define ARGB(c)     [UIColor colorWithRed:((c>>24)&0xFF)/256.0  green:((c>>16)&0xFF)/256.0   blue:((c>>8)&0xFF)/256.0   alpha:((c)&0xFF)/256.0]

#define JELocalizedStringWithValue(key, defaultValue) [[NSBundle mainBundle] localizedStringForKey:(key) value:(defaultValue) table:nil]
#define JELocalizedString(key) [[NSBundle mainBundle] localizedStringForKey:(key) value:nil table:nil]

#define SINA_WEIBO_ACCESS_TOKEN @"sina_weibo_access_token"
#define SINA_WEIBO_USER_ID @"sina_weibo_user_id"
#define SINA_WEIBO_EXPIRE_DATE @"sina_weibo_expire_date"

#endif /* Macros_h */
