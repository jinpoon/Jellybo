//
//  JEHelper.m
//  Jellybo
//
//  Created by POON on 16/4/29.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "JEHelper.h"

@implementation JEHelper
+ (NSString *)timeRemainDescriptionWithTimestamp:(CGFloat)timestamp {
    
    NSString *minuteStr = @"分钟";
    NSString *hourStr = @"小时";
    NSString *dayStr = @"天";
    
    NSTimeInterval interval = timestamp - [[NSDate date] timeIntervalSince1970];
    
    NSString *before = @"";
    
    if (interval < 0) {
        interval = -interval;
        before = @"前";
    }
    
    CGFloat minute = interval / 60.0f;
    if (minute < 60.0f) {
        if (minute < 1.0f) {
            return @"刚刚";
        }
        return [NSString stringWithFormat:@"%.f %@%@", minute, minuteStr, before];
    } else {
        CGFloat hour = minute / 60.0f;
        if (hour < 24.0f) {
            return [NSString stringWithFormat:@"%.f %@%@", hour, hourStr, before];
        } else {
            CGFloat day = hour / 24.0f;
            if (day < 7.0f) {
                return [NSString stringWithFormat:@"%zd %@%@", (NSInteger)day, dayStr, before];
            } else {
                return [self timeStringWithTimestamp:timestamp];
            }
        }
    }
    
}

+ (NSString *)timeStringWithTimestamp:(CGFloat)timestampSeconds {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestampSeconds];
    
    NSDateFormatter *localDateFormatter = [[NSDateFormatter alloc] init];
    [localDateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [localDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *localTimeString = [localDateFormatter stringFromDate:date];
    
    return localTimeString;
}


+ (BOOL)validateEmail:(NSString *)candidate {
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [emailTest evaluateWithObject:candidate];
}

+ (BOOL)validatePhone:(NSString *)candidate {
    
    if (candidate.length == 0 || ![[candidate substringWithRange:(NSRange){0,1}] isEqualToString:@"1"]) {
        return NO;
    }
    
    NSError *error = NULL;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:&error];
    
    NSRange inputRange = NSMakeRange(0, [candidate length]);
    NSArray *matches = [detector matchesInString:candidate options:0 range:inputRange];
    
    // no match at all
    if ([matches count] == 0) {
        return NO;
    }
    
    // found match but we need to check if it matched the whole string
    NSTextCheckingResult *result = (NSTextCheckingResult *)[matches objectAtIndex:0];
    
    if ([result resultType] == NSTextCheckingTypePhoneNumber && result.range.location == inputRange.location && result.range.length == inputRange.length && result.range.length == 11) {
        // it matched the whole string
        return YES;
    }
    else {
        // it only matched partial string
        return NO;
    }
}

+ (NSString *)chineseStringFromInteger:(NSUInteger)integer {
    
    if (integer > 9999) {
        return @"";
    }
    NSArray *numbArray = @[@"〇", @"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九"];
    NSArray *unitArray = @[@"十", @"百", @"千", @"万"];
    
    NSMutableString *string = [NSMutableString new];
    
    NSUInteger number = integer;
    NSUInteger zeroCount = 0;
    NSUInteger index = 0;
    while (number != 0) {
        NSUInteger last = (number % 10);
        if (last == 0) {
            zeroCount ++;
        } else {
            // o between numbers
            if (zeroCount > 0 && index > 1 && zeroCount != index) {
                [string insertString:numbArray[0] atIndex:0];
            }
            // unit
            if (index > 0) {
                [string insertString:unitArray[index - 1] atIndex:0];
            }
            // number
            if (last == 1) {
                if (index != 1 || number % 100 != last) {
                    [string insertString:numbArray[last] atIndex:0];
                }
            } else {
                [string insertString:numbArray[last] atIndex:0];
            }
            zeroCount = 0;
        }
        number = number/10;
        index ++;
    }
    
    return string;
}

+ (NSString *)timeStringFromSecondsTime:(NSInteger)time {
    
    NSInteger minutes = time / 60;
    NSInteger seconds = time - minutes * 60;
    NSString *minutesString;
    NSString *secondsString;
    if (minutes < 10) {
        minutesString = [@"0" stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)minutes]];
    } else {
        minutesString = [NSString stringWithFormat:@"%ld", (long)minutes];
    }
    if (seconds < 10) {
        secondsString = [@"0" stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)seconds]];
    } else {
        secondsString = [NSString stringWithFormat:@"%ld", (long)seconds];
    }
    
    return [NSString stringWithFormat:@"%@:%@", minutesString, secondsString];
    
}

+ (CGFloat)currentTimeStamp{
    
    CGFloat current = [[NSDate date] timeIntervalSince1970];
    return current;
}

+ (long long)currentTimeStampMS{
    return [self currentTimeStamp] * 1000;
}

+ (BOOL)moreThanOneDayBetween:(CGFloat)oldTimeStamp
                 newTimeStamp:(CGFloat)newTimeStamp{
    
    CGFloat secondsOneDay = 24 * 60 * 60;
    
    if (oldTimeStamp >= newTimeStamp){
        return false;
    }
    
    if (newTimeStamp - oldTimeStamp > secondsOneDay){
        return true;
    }
    
    return false;
}

#pragma mark - View

+ (UIImage *)getImageFromView:(UIView *)orgView {
    if (orgView) {
        //        UIGraphicsBeginImageContext(orgView.bounds.size);
        //        [orgView.layer renderInContext:UIGraphicsGetCurrentContext()];
        //        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        //        UIGraphicsEndImageContext();
        UIGraphicsBeginImageContextWithOptions(orgView.bounds.size, NO, [UIScreen mainScreen].scale);
        [orgView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    } else {
        return nil;
    }
}


+ (CGSize)screenSize {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    }
    return screenSize;
}

//#pragma mark - String
//
//+ (NSString *)signatureWithDict:(NSDictionary *)dict key:(NSString *)signatureKey {
//
//    NSArray *keys = [dict.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
//        return [obj1 compare:obj2];
//    }];
//
//    NSMutableString *string = [NSMutableString new];
//
//    NSInteger index = 0;
//    for (NSString *key in keys) {
//        if (index) {
//            [string appendString:@"&"];
//        }
//        [string appendFormat:@"%@=%@", key, [dict valueForKey:key]];
//        index ++;
//    }
//    [string appendFormat:@"&%@", signatureKey];
//
//    return string.md5;
//}


#pragma mark - User name Empty

+ (BOOL) userNameisEmpty:(NSString *) str {
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

#pragma mark - Get Color

+ (UIColor *)getColor:(NSString*)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
}

//判断是否为整型：

+ (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}
@end
