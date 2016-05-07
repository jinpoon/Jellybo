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
#import "JEErrorView.h"
#import "JEHomeRefresher.h"

@interface JEHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic, strong) JEBaseWeiboContentListModel *contentListModel;

@property (nonatomic) JEErrorView *errorView;
@end

@implementation JEHomeViewController

#pragma mark - views

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [JEHomeRefresher headerWithRefreshingBlock:^(){
        [self requestNewDataWithSuccessBlock:^(JEBaseWeiboContentListModel *listModel){
            [self.tableView.mj_header endRefreshing];
        }failure:^(NSError *error){
            [self.tableView.mj_header endRefreshing];
        }];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureViews];
    [self tryLoadDataFromCache];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [kCacheManager clearHomeContentCache];
//    [kCacheManager setHomeWeiboContent:self.contentListModel forKey:JEHomeViewWeiboContentCache];

}

#pragma mark - data
- (void)requestNewDataWithSuccessBlock:(void (^)(JEBaseWeiboContentListModel *listModel))success failure:(void (^)(NSError *error))failure{
    NSInteger sinceId = 0;
    if(self.contentListModel){
        JEBaseWeiboContentModel *model = [self.contentListModel.list firstObject];
        sinceId = [model.w_id integerValue];
    }
    [self getWeiboContentWithSinceId:sinceId maxId:0 count:50 success:^(JEBaseWeiboContentListModel *listModel){

        if(self.contentListModel){
            [self.contentListModel insertListModelsFromHead:listModel];
            [kCacheManager setHomeWeiboContent:self.contentListModel forKey:JEHomeViewWeiboContentCache];
            [self.tableView reloadData];
        }
        else{
            self.contentListModel = listModel;
        }
        if(success){
            success(listModel);
        }
    }failure:^(NSError *error){
        NSLog(@"%@",error.description);
    }];
}

- (void)getWeiboContentWithSinceId: (NSInteger)sinceId maxId: (NSInteger)maxId count:(NSInteger)count success:(void (^)(JEBaseWeiboContentListModel *listModel))success failure:(void (^)(NSError *error))failure{
    
    [kHTTPManager getHomeTimelineWeiboContentListWithSinceId:sinceId maxId:maxId count:count feature:JEWeiboFeatureAll ifTimeUser:NO success:^(JEBaseWeiboContentListModel *listModel){
        NSLog(@"%ld", listModel.list.count);
        if(success){
            success(listModel);
        }
    }failure:^(NSError *error){
        NSLog(@"%@",error.description);
        if(failure){
            failure(error);
        }
    }];
}


- (void)tryLoadDataFromCache{
    JEBaseWeiboContentListModel *cacheListModel = (JEBaseWeiboContentListModel *)[kCacheManager homeWeiboContentObjectForKey:JEHomeViewWeiboContentCache];
    if (cacheListModel && cacheListModel.list.count > 0) {
        self.contentListModel = cacheListModel;
    }
}

- (void)setContentListModel:(JEBaseWeiboContentListModel *)contentListModel{
    _contentListModel = contentListModel;
    if(_contentListModel){
        [self.tableView reloadData];
        [kCacheManager setHomeWeiboContent:self.contentListModel forKey:JEHomeViewWeiboContentCache];
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

#pragma mark - tableview
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    JEBaseWeiboCell *cell = (JEBaseWeiboCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return [cell cellHeight];
    
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
