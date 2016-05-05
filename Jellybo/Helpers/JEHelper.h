//
//  JEHelper.h
//  Jellybo
//
//  Created by POON on 16/4/29.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface JEHelper : NSObject
+ (NSString *)timeRemainDescriptionWithTimestamp:(CGFloat)timestamp;

+ (NSString *)timeStringWithTimestamp:(CGFloat)timestamp;

+ (NSString *)timeStringFromSecondsTime:(NSInteger)time;

+ (BOOL)validateEmail:(NSString *)candidate;

+ (BOOL)validatePhone:(NSString *)candidate;

+ (NSString *)chineseStringFromInteger:(NSUInteger)integer;

/**
 *  @return 从1970年的秒
 */
+ (CGFloat)currentTimeStamp;

+ (long long)currentTimeStampMS;

+ (BOOL)moreThanOneDayBetween:(CGFloat)oldTimeStamp
                 newTimeStamp:(CGFloat)newTimeStamp;

+ (NSDate *)dateWithFormatedString:(NSString *)s;
+ (NSString *)showTimeStringWithNSDate: (NSDate *)date;

#pragma mark - View

+ (UIImage *)getImageFromView:(UIView *)orgView;

+ (CGSize)screenSize;

//#pragma mark - String
//
//+ (NSString *)signatureWithDict:(NSDictionary *)dict key:(NSString *)signatureKey;


#pragma mark - User name Empty

+ (BOOL)userNameisEmpty:(NSString *) str;

#pragma mark - Get Color

+ (UIColor *)getColor:(NSString*)hexColor;

#pragma mark - Pure int

+ (BOOL)isPureInt:(NSString*)string;

@end
