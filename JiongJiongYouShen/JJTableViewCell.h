//
//  JJTableViewCell.h
//  JiongJiongYouShen
//
//  Created by deng on 15/4/28.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJTableViewCell : UITableViewCell
@property (assign, nonatomic) NSNumber *artcicle_id;
@property (assign, nonatomic) NSNumber *user_id;
@property (assign, nonatomic) CGSize   image_size;

@property (strong, nonatomic) UIButton *avatar;
@property (strong, nonatomic) UILabel *nicknameLable;
@property (strong, nonatomic) UIImageView *sexImg;
@property (strong, nonatomic) UIImageView *timeIndicatorImg;
@property (strong, nonatomic) UILabel *timeLable;
@property (strong, nonatomic) UILabel *contentLable;
@property (strong, nonatomic) UILabel *jiongLable;
@property (strong, nonatomic) UILabel *commentLable;
@property (strong, nonatomic) UIButton *thumbUpBtn;
@property (strong, nonatomic) UIButton *thumbDownBtn;
@property (strong, nonatomic) UIButton *commentBtn;
@property (strong, nonatomic) UIButton *shareBtn;

-(void)removeConstraints;
-(void)prepareForReuse;
@end
