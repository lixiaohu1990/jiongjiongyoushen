//
//  Articles.h
//  JiongJiongYouShen
//
//  Created by deng on 15/4/28.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Users;
@class Img;
@class Video;
@interface Articles : NSObject
@property (strong, nonatomic) NSNumber *ID;
@property (strong, nonatomic) NSNumber *user_id;
@property (copy, nonatomic) NSString *body;
@property (strong, nonatomic) NSNumber *comment_num;
@property (strong, nonatomic) NSNumber *good_num;
@property (strong, nonatomic) NSNumber *share_num;
@property (strong, nonatomic) NSString *created_at;
@property (assign, nonatomic) CGFloat cell_height;//缓存cell 高度
@property (strong, nonatomic) Users *user;
@property (strong, nonatomic) Img *img;
@property (strong, nonatomic) Video *video;
@end
