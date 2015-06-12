//
//  EmotionScrollView.h
//  JiongJiongYouShen
//
//  Created by deng on 15/5/9.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionScrollView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic,assign) NSUInteger num;
/*
 *  是否在滚动
 */
@property (nonatomic,assign) BOOL isScroll;

-(void)addSubviewsWithArray:(NSArray *)views;
-(void)contentSizeMakeSure:(NSUInteger)num;
@end
