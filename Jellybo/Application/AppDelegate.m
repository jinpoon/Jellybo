//
//  AppDelegate.m
//  Jellybo
//
//  Created by POON on 16/4/29.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "AppDelegate.h"
#import <WeiboSDK/WeiboSDK.h>

@interface AppDelegate ()<WeiboSDKDelegate, UIApplicationDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.rootViewController = [[RootViewController alloc] init];
    self.rootNavigationController = [[UINavigationController alloc] initWithRootViewController:self.rootViewController];
    self.window.rootViewController = self.rootViewController;
    
    [self.window makeKeyAndVisible];
    
    //Weibo
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:@"1913145241"];
    return YES;
}

#pragma mark - OpenURL

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark - WeiboSDK

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
            // 使用授权会调用 授权的开发情况下面
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
