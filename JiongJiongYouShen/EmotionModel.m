//
//  EmotionModel.m
//  JiongJiongYouShen
//
//  Created by deng on 15/5/9.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import "EmotionModel.h"
#import "MJExtension.h"
#import "EmotionPageView.h"
#define ramdomColor ([UIColor colorWithRed:arc4random_uniform(256)/255.0f green:arc4random_uniform(256)/255.0f blue:arc4random_uniform(256)/255.0f alpha:1.0f])

#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f || [UIScreen mainScreen].bounds.size.height==320.0f)

#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f || [UIScreen mainScreen].bounds.size.height==320.0f)

#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f || [UIScreen mainScreen].bounds.size.height==375.0f)

#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)

@implementation EmotionModel

+(NSArray*)modelArrayForEmoji{
    NSString *path= [[NSBundle mainBundle] pathForResource:@"emoji_info" ofType:@"plist"];
    NSArray *arr=[NSArray arrayWithContentsOfFile:path];
    NSArray *modelArray=[self objectArrayWithKeyValuesArray:arr];
    return modelArray;
}
// 按照每页来分割数组
+(NSArray*)pagesArray{
    NSUInteger length=[self emojiNumOnePage];
  
    NSArray * modelArrays=[self modelArrayForEmoji];
    
    NSUInteger count=modelArrays.count;
    
    NSUInteger subArrayCount =count /length;
    if(subArrayCount * length < count) subArrayCount++;
    
    NSMutableArray *pageA=[NSMutableArray arrayWithCapacity:subArrayCount];
    
    for (NSUInteger i=0; i<subArrayCount; i++) {
        NSUInteger loc = i * length;
        NSUInteger len = length;
        if(i == subArrayCount - 1){//最后一组
            len = count - length * (subArrayCount -1);
        }
        NSRange range = NSMakeRange(loc, len);
        
        NSArray *subArray_i = [modelArrays subarrayWithRange:range];
        
        [pageA addObject:subArray_i];
        
    }
    return pageA;
}


/*
 *  由pageView决定一页应该放多少个表情视图
 */
+(NSUInteger)emojiNumOnePage{
    
    return [self colOFOneRowCount] * 3-1;
}


/*
 *  一行有多少列
 */
+(NSUInteger)colOFOneRowCount{
    
    //普通屏幕: 一排7个
    NSUInteger rowCount = 7;
    
    //iPhone6: 一排8个
    if(iphone6_4_7) rowCount = 8;
    
    //iPhone 6P: 一排10个
    if(iphone6Plus_5_5) rowCount = 10;
    
    return rowCount;
}
@end
