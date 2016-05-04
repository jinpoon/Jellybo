//
//  JEHomeViewController.m
//  Jellybo
//
//  Created by POON on 16/4/29.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "JEHomeViewController.h"
#import <WeiboSDK/WeiboSDK.h>
#import "JEHTTPManager+Content.h"
#import "JEBaseWeiboContentModel.h"
#import "JEBaseWeiboCell.h"

@interface JEHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic, strong) JEBaseWeiboContentListModel *contentListModel;
@end

@implementation JEHomeViewController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}

- (void)configureViews{
    self.view.backgroundColor = kBackgroundGrayColor;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    //self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^(){}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureViews];
    [self testDataRequest];
}

- (void)testDataRequest{
    [[JEHTTPManager manager] getHomeTimelineWeiboContentListWithSinceId:0 maxId:0 count:10 feature:JEWeiboFeatureAll ifTimeUser:NO success:^(JEBaseWeiboContentListModel *listModel){
        self.contentListModel = listModel;
        
        
    }failure:^(NSError *error){
        NSLog(@"%@",error.description);
    }];
}

- (void)setContentListModel:(JEBaseWeiboContentListModel *)contentListModel{
    _contentListModel = contentListModel;
    if(_contentListModel){
        [self.tableView reloadData];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentListModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *weiboCellIdentifier = @"weiboCellIdentifier";
    JEBaseWeiboCell *cell = (JEBaseWeiboCell *)[tableView dequeueReusableCellWithIdentifier:weiboCellIdentifier];
    if(!cell){
        cell = [[JEBaseWeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:weiboCellIdentifier];
    }
    cell.model = self.contentListModel.list[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
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
