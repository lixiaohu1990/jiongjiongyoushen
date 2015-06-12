//
//  EmotionPageView.h
//  JiongJiongYouShen
//
//  Created by deng on 15/5/9.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionDeleteBtn;
@interface EmotionPageView : UIView
@property (nonatomic,strong) NSArray* emotionModelArr;
@property (nonatomic,weak) EmotionDeleteBtn *deleteBtn;
+(NSArray *)emotionPageViewsWithPageModleArr:(NSArray*) PageModleArr;
@end
