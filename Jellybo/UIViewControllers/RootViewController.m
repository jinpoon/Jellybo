//
//  RootViewController.m
//  Jellybo
//
//  Created by POON on 16/4/29.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "RootViewController.h"
#import "JEHomeViewController.h"
#import "JEDiscoverViewController.h"
#import "JEMessagesViewController.h"
#import "JEPersonViewController.h"

@interface RootViewController ()<UITabBarControllerDelegate, UITabBarDelegate>
@property (nonatomic, strong) JEHomeViewController *homeVC;
@property (nonatomic, strong) JEPersonViewController *personVC;
@property (nonatomic, strong) JEMessagesViewController *messageVC;
@property (nonatomic, strong) JEDiscoverViewController *discoverVC;


@property (nonatomic) UINavigationController *homeNaviVC;
@property (nonatomic) UINavigationController *discoverNaviVC;
@property (nonatomic) UINavigationController *personNaviVC;
@property (nonatomic) UINavigationController *messagesNaviVC;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureControllers];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - configure
- (void)configureControllers{
    [self.navigationController setNavigationBarHidden:YES];
    
    self.mainTabBarController = [[UITabBarController alloc] init];
    
    self.discoverVC = [[JEDiscoverViewController alloc] init];
    self.messageVC = [[JEMessagesViewController alloc] init];
    self.homeVC = [[JEHomeViewController alloc] init];
    self.personVC = [[JEPersonViewController alloc] init];
    
    
    
    NSDictionary *tabItemTextAttr_normal = @{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                             NSForegroundColorAttributeName: RGBA(0x555555, 1)};
    NSDictionary *tabItemTextAttr_selected = @{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                               NSForegroundColorAttributeName: RGBA(0x258de9, 1)};
    
    UITabBarItem *barItem1 = [[UITabBarItem alloc] initWithTitle:JELocalizedString(@"Home") image:[[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"home_selected"]];
    
    UITabBarItem *barItem2 = [[UITabBarItem alloc] initWithTitle:JELocalizedString(@"Messages") image:[[UIImage imageNamed:@"messages"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"messages_selected"]];
    
    UITabBarItem *barItem3 = [[UITabBarItem alloc] initWithTitle:JELocalizedString(@"Discover") image:[[UIImage imageNamed:@"discover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"discover_selected"]];
    
    UITabBarItem *barItem4 = [[UITabBarItem alloc] initWithTitle:JELocalizedString(@"Person") image:[[UIImage imageNamed:@"person"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[UIImage imageNamed:@"person_selected"]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:tabItemTextAttr_normal forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:tabItemTextAttr_selected forState:UIControlStateSelected];
    //[[UITabBarItem appearance] setImageInsets:UIEdgeInsetsMake(-3, 0, 0, 0)];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    self.homeNaviVC = [[UINavigationController alloc] initWithRootViewController:self.homeVC];
    self.homeNaviVC.tabBarItem = barItem1;
    
    self.messagesNaviVC = [[UINavigationController alloc] initWithRootViewController:self.messageVC];
    self.messageVC.tabBarItem = barItem2;
    
    self.discoverNaviVC = [[UINavigationController alloc] initWithRootViewController:self.discoverVC];
    self.discoverNaviVC.tabBarItem = barItem3;
    
    self.personNaviVC = [[UINavigationController alloc] initWithRootViewController:self.personVC];
    self.personNaviVC.tabBarItem = barItem4;
    
    NSArray *VCs = [NSArray arrayWithObjects:self.homeNaviVC, self.messagesNaviVC, self.discoverNaviVC, self.personNaviVC, nil];
    self.mainTabBarController.viewControllers = VCs;
    self.mainTabBarController.tabBar.tintColor = kThemeColor;
    
    [self.view addSubview:self.mainTabBarController.view];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
