//
//  JEBaseWeiboCell.h
//  Jellybo
//
//  Created by POON on 16/5/2.
//  Copyright © 2016年 JIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JEBaseWeiboContentModel.h"

@interface JEBaseWeiboCell : UITableViewCell

@property (nonatomic, strong) JEBaseWeiboContentModel *model;

-(CGFloat)cellHeight;

@end
