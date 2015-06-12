//
//  Comments.h
//  JiongJiongYouShen
//
//  Created by deng on 15/4/28.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Img : NSObject
@property (assign, nonatomic) NSNumber *ID;
@property (assign, nonatomic) NSNumber *user_id;
@property (assign, nonatomic) NSNumber *article_id;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSArray *image_size;
@property (copy, nonatomic) NSString *created_at;
@end
