//
//  JJTableViewCell.h
//  JiongJiongYouShen
//
//  Created by deng on 15/4/28.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, CellType) {
    CellTypeText = 0,
    CellTypeImg   = 1,
    CellTypeVideo  = 2,
};
@interface JJTableViewCellPic : UITableViewCell
@property (assign, nonatomic) NSNumber *artcicle_id;
@property (assign, nonatomic) NSNumber *user_id;
@property (assign, nonatomic) CGSize   image_size;
@property (assign, nonatomic) CellType   cell_type;

@property (strong, nonatomic) UIButton *avatar;
@property (strong, nonatomic) UILabel *nicknameLable;
@property (strong, nonatomic) UIImageView *sexImg;
@property (strong, nonatomic) UIImageView *timeIndicatorImg;
@property (strong, nonatomic) UILabel *timeLable;
@property (strong, nonatomic) UILabel *contentLable;
@property (strong, nonatomic) UIImageView *contentImg;
@property (strong, nonatomic) UILabel *jiongLable;
@property (strong, nonatomic) UILabel *commentLable;
@property (strong, nonatomic) UIButton *thumbUpBtn;
@property (strong, nonatomic) UIButton *thumbDownBtn;
@property (strong, nonatomic) UIButton *commentBtn;
@property (strong, nonatomic) UIButton *shareBtn;

-(void)removeConstraints;
@end
