//
//  EmotionModel.h
//  JiongJiongYouShen
//
//  Created by deng on 15/5/9.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmotionModel : NSObject
@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSNumber *type;
+(NSArray*)pagesArray;
+(NSUInteger)colOFOneRowCount;
+(NSUInteger)emojiNumOnePage;
@end
