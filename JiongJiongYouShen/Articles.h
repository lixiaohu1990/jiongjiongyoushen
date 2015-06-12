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
@property (assign, nonatomic) NSNumber *ID;
@property (assign, nonatomic) NSNumber *user_id;
@property (copy, nonatomic) NSString *body;
@property (assign, nonatomic) NSNumber *comment_num;
@property (assign, nonatomic) NSNumber *good_num;
@property (assign, nonatomic) NSNumber *share_num;
@property (assign, nonatomic) NSString *created_at;
@property (assign, nonatomic) CGFloat cell_height;
@property (strong, nonatomic) Users *user;
@property (strong, nonatomic) Img *img;
@property (strong, nonatomic) Video *video;
@end
