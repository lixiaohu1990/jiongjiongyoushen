//
//  Comments.h
//  JiongJiongYouShen
//
//  Created by deng on 15/4/28.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comments : NSObject
@property (assign, nonatomic) NSNumber *ID;
@property (assign, nonatomic) NSNumber *user_id;
@property (assign, nonatomic) NSNumber *article_id;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *created_at;
@end
