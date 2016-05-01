//
//  JEHomeViewController.m
//  Jellybo
//
//  Created by POON on 16/4/29.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "JEHomeViewController.h"
#import <WeiboSDK/WeiboSDK.h>

@interface JEHomeViewController ()

@property (nonatomic) UIButton *authorizeButton;

@end

@implementation JEHomeViewController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.authorizeButton sizeToFit];
    self.authorizeButton.centerX = self.view.width/2;
    self.authorizeButton.centerY = (self.view.height-40)/2;
}

- (void)configureViews{
    self.authorizeButton = [[UIButton alloc] init];
    [self.authorizeButton setTitle:@"TapToAuth" forState:UIControlStateNormal];
    [self.authorizeButton setTitleColor:RGB(0x000000) forState:UIControlStateNormal];
    self.authorizeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.authorizeButton addTarget:self action:@selector(authorizeWeibo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.authorizeButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureViews];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
