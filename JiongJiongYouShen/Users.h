//
//  Users.h
//  JiongJiongYouShen
//
//  Created by deng on 15/4/28.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Users : NSObject
@property (assign, nonatomic) NSNumber *ID;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *avatar;
@property (copy, nonatomic) NSString *sex;
@property (assign, nonatomic) NSNumber *phone_type;
@property (assign, nonatomic) NSNumber *good_num;
@property (assign, nonatomic) NSNumber *share_num;
@end
