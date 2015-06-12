//
//  Student.h
//  JiongJiongYouShen
//
//  Created by deng on 15/5/2.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
/** 名称 */
@property (copy, nonatomic) NSString *name;
/** 头像 */
@property (copy, nonatomic) NSString *icon;
/** 年龄 */
@property (assign, nonatomic) NSNumber *age;
/** 身高 */
@property (copy, nonatomic) NSString *height;
/** 财富 */
@property (strong, nonatomic) NSNumber *money;

@property (assign, nonatomic) NSNumber *ID;
@end