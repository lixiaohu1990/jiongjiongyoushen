//
//  JJCommentTableViewCell.h
//  JiongJiongYouShen
//
//  Created by deng on 15/4/30.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJCommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *avatarBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIImageView *sexImg;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;

@property (weak, nonatomic) IBOutlet UILabel *orderLable;

@end
