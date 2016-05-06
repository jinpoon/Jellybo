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
#import "JEHelper.h"
#import <AFNetworking/UIKit+AFNetworking.h>

@interface JEBaseWeiboCell()
@property (nonatomic) UILabel *username;
@property (nonatomic) UIImageView *avatar;
@property (nonatomic) UIImageView *verifiedSign;
@property (nonatomic) UIView *divideline; //分割线
@property (nonatomic) UILabel *creatTime;
@property (nonatomic, strong) NSArray *pics; //图片列表


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
    [self.username sizeToFit];
    self.username.top = self.avatar.top;
    
    self.creatTime.frame = CGRectMake(0, 0, 200, 10);
    self.creatTime.left = self.username.left;
    [self.creatTime sizeToFit];
    self.creatTime.bottom = self.avatar.bottom;
    
    self.divideline.frame = CGRectMake(0, 0, self.width, 0.5);
    self.divideline.top = self.avatar.bottom + 10;
    
    self.content.frame = CGRectMake(0, 0, self.width - 30, 100);
    [self.content sizeToFit];
    self.content.top = self.divideline.bottom + 10;
    self.content.left = 16;
    
    self.cellFooterView.frame = CGRectMake(0, 0, self.width, 10);
    self.cellFooterView.bottom = self.height;
    
    if(self.model && self.model.thumbnail_pics_urls){
        [self layoutImageViews];
    }
    else{
        for (UIImageView *view in self.pics) {
            view.hidden = YES;
            [view removeFromSuperview];
        }
    }
}

- (void)layoutImageViews{
    CGFloat thumbImgWidth = (self.width - 16 * 2 - 5 *2)/3; //减去两边间距及中间间距后平均分布
    NSInteger numOfPics = self.model.thumbnail_pics_urls.count;
    UIImageView *imgView;
    NSURL *picUrl;
    for (NSInteger i = 0; i<numOfPics; i++) {
        imgView = self.pics[i];
        imgView.hidden = NO;
        [self addSubview:imgView];
        if (i %3 == 0) {
            imgView.frame = CGRectMake(16, self.content.bottom + (i/3 + 1) * 5 + i/3*thumbImgWidth, thumbImgWidth, thumbImgWidth);
        }
        else {
            UIImageView *leftView = self.pics[i-1];
            imgView.frame = CGRectMake(leftView.right + 5, leftView.top, thumbImgWidth, thumbImgWidth);
        }
        picUrl = [NSURL URLWithString: self.model.bmiddle_pics_urls[i]];
        imgView.contentMode = UIViewContentModeScaleToFill;
        [imgView setImageWithURL:picUrl];
    }
    for (NSInteger i = numOfPics; i<9; i++) {
        imgView = self.pics[i];
        imgView.hidden = YES;
        
        [imgView removeFromSuperview];
    }
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
    
    NSMutableArray *imgArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i<9; i++) {
        UIImageView *img = [[UIImageView alloc] init];
        img.hidden = YES;
        [imgArray addObject:img];
    }
    self.pics = [NSArray arrayWithArray:imgArray];
}

- (void)setModel:(JEBaseWeiboContentModel *)model{
    if(model){
        _model = model;
        self.username.text = model.userInfo.screen_name;
        
        NSString *source = model.source;
        NSArray *strs = [source componentsSeparatedByString:@">"];
        source = strs[strs.count - 2];
        strs = [source componentsSeparatedByString:@"<"];
        source = strs.firstObject;
        
        
        NSDate *date = [JEHelper dateWithFormatedString:model.createTime];
        self.creatTime.text = [NSString stringWithFormat:@"%@ 来自%@", [JEHelper showTimeStringWithNSDate:date], source];
        
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
    CGFloat heightForPics = 0;
    if(self.model.thumbnail_pics_urls){
        CGFloat thumbImgWidth = (kScreenWidth - 16 * 2 - 5 *2)/3;
        NSInteger numOfPics = self.model.thumbnail_pics_urls.count - 1;
        heightForPics = (numOfPics/3 + 1)*thumbImgWidth + numOfPics/3*5;
    }
    CGFloat requiredHeight = self.divideline.bottom  + self.content.height + 30 + heightForPics;
    NSLog(@"pic height: %f,  numberofpics: %ld",heightForPics,  self.model.thumbnail_pics_urls.count);
    return requiredHeight;
}

@end
