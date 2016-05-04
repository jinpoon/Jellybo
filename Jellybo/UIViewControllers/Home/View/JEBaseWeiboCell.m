//
//  JEBaseWeiboCell.m
//  Jellybo
//
//  Created by POON on 16/5/2.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import "JEBaseWeiboCell.h"
#import "JERetweetViewInCell.h"
#import "JEHTTPManager+User.h"
#import "JEDrawerHelper.h"
#import <AFNetworking/UIKit+AFNetworking.h>

@interface JEBaseWeiboCell()
@property (nonatomic) UILabel *username;
@property (nonatomic) UIImageView *avatar;
@property (nonatomic) UIImageView *verifiedSign;
@property (nonatomic) UIView *divideline; //分割线
@property (nonatomic) UILabel *creatTime;


@property (nonatomic) TTTAttributedLabel *content;
@property (nonatomic) JERetweetViewInCell *retweetView;
@property (nonatomic) UIView *cellFooterView; //视觉上增加每个cell的间距

@end

@implementation JEBaseWeiboCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        [self configureViews];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.avatar.frame = CGRectMake(16, 10, 30, 30);
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = self.avatar.width/2;
    
    self.verifiedSign.frame = CGRectMake(0, 0, 10, 10);
    self.verifiedSign.bottom = self.avatar.bottom;
    self.verifiedSign.right = self.avatar.right;
    self.verifiedSign.backgroundColor = [UIColor clearColor];
    
    self.username.frame = CGRectMake(0, 0, 200, 20);
    self.username.left = self.avatar.right + 10;
    self.username.top = self.avatar.top;
    
    self.creatTime.frame = CGRectMake(0, 0, 200, 10);
    self.creatTime.left = self.username.left;
    self.creatTime.bottom = self.avatar.bottom;
    
    self.divideline.frame = CGRectMake(0, 0, self.width, 0.5);
    self.divideline.top = self.avatar.bottom + 10;
    
    self.content.frame = CGRectMake(0, 0, self.width - 30, 100);
    [self.content sizeToFit];
    self.content.top = self.divideline.bottom + 10;
    self.content.left = 16;
    
    self.cellFooterView.frame = CGRectMake(0, 0, self.width, 10);
    self.cellFooterView.bottom = self.height;
}

- (void)configureViews{
    self.avatar = [[UIImageView alloc] init];
    [self addSubview:self.avatar];
    
    self.verifiedSign = [[UIImageView alloc] init];
    [self addSubview:self.verifiedSign];
    
    self.username = [[UILabel alloc] init];
    self.username.textColor = kThemeColor;
    self.username.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.username];
    
    self.creatTime = [[UILabel alloc] init];
    self.creatTime.textColor = kTextGrayLightColor;
    self.creatTime.font = [UIFont systemFontOfSize:11];
    [self addSubview:self.creatTime];
    
    self.divideline = [[UIView alloc] init];
    self.divideline.backgroundColor = kTextGrayLightColor;
    [self addSubview:self.divideline];
    
    self.content = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
    self.content.font = [UIFont systemFontOfSize:16];
    self.content.textColor = kTextBlackColor;
    self.content.lineBreakMode = NSLineBreakByWordWrapping;
    self.content.numberOfLines = 0;
    
    [self addSubview:self.content];
    
    self.cellFooterView = [[UIView alloc] init];
    self.cellFooterView.backgroundColor = kBackgroundGrayColor;
    [self addSubview:self.cellFooterView];
}

- (void)setModel:(JEBaseWeiboContentModel *)model{
    if(model){
        _model = model;
        self.username.text = model.userInfo.screen_name;
        self.creatTime.text = model.createTime;
        if(model.userInfo.verified){
            NSInteger verified_type = model.userInfo.verified_type;
            if(verified_type == 0){
                [self.verifiedSign setImage:[UIImage imageNamed:@"verified_personal"]];
            }
            else if(verified_type > 0){
                [self.verifiedSign setImage:[UIImage imageNamed:@"verified_enterprise"]];
            }
        }
        self.content.text = model.textContent;
        if(model.userInfo.avatar_hd_url){
            [self.avatar setImageWithURL:[NSURL URLWithString:model.userInfo.avatar_hd_url]];
        }
        
        [self layoutSubviews];
    }
}

- (CGFloat)cellHeight{
    CGFloat requiredHeight = self.divideline.bottom + 10 + self.content.height + 30;
    
    return requiredHeight;
}

@end
