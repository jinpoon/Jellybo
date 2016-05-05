//
//  AppDelegate.m
//  Jellybo
//
//  Created by POON on 16/4/29.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "AppDelegate.h"
#import <WeiboSDK/WeiboSDK.h>
#import "UINavigationController+Custom.h"

@interface AppDelegate ()<WeiboSDKDelegate, UIApplicationDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];;
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.rootViewController = [[RootViewController alloc] init];
    self.rootNavigationController = [[UINavigationController alloc] initWithRootViewController:self.rootViewController];
    self.window.rootViewController = self.rootNavigationController;
    
    [self.window makeKeyAndVisible];
    
    [self setUrlCacheCapacity];
    
    //manager
    [JEUserManager manager];
    [JEHTTPManager manager];
    [JECacheManager manager];
    
    //Weibo
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:@"1913145241"];
    [self checkIfExpired];
    return YES;
}

- (void) setUrlCacheCapacity{
    //设置cache
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:1 * 1024 * 1024
                                                            diskCapacity:2 * 1024 * 1024
                                                                diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
}

#pragma mark - OpenURL

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [self application:application openURL:url options:@{@"":@""}];
}

#pragma mark - WeiboSDK
- (void)checkIfExpired{
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDate *expireDate = [[NSUserDefaults standardUserDefaults] valueForKey:SINA_WEIBO_EXPIRE_DATE];
    if([expireDate isEqualToDate: [expireDate earlierDate:now]]){
        [self authorizeWeibo];
    }
    else{
        [JEUserManager manager].accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:SINA_WEIBO_ACCESS_TOKEN];
        [JEUserManager manager].userId = [[NSUserDefaults standardUserDefaults] valueForKey: SINA_WEIBO_USER_ID];
    }
}

- (void)authorizeWeibo{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"http://www.sina.com";
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    
    [WeiboSDK sendRequest:request];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]){
        if (WeiboSDKResponseStatusCodeSuccess == response.statusCode) {
            // 执行分享后的回调代理，就是分享后从新浪的客户端回到自己的应用会执行
        }
        
    }else if ([response isKindOfClass:WBAuthorizeResponse.class]){
        WBAuthorizeResponse *authorizeResponse = (WBAuthorizeResponse *)response;
        if (WeiboSDKResponseStatusCodeSuccess == authorizeResponse.statusCode) {
            
            NSString *accessToken = authorizeResponse.accessToken;
            NSString *userId = authorizeResponse.userID;
            NSDate *expireDate = authorizeResponse.expirationDate;
            NSLog(@"token: %@", accessToken);
            NSLog(@"userId: %@", userId);
            [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:SINA_WEIBO_ACCESS_TOKEN];
            [[NSUserDefaults standardUserDefaults] setObject:userId forKey:SINA_WEIBO_USER_ID];
            [[NSUserDefaults standardUserDefaults] setObject:expireDate forKey:SINA_WEIBO_EXPIRE_DATE];
            
        }
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
