//
//  Emoji.h
//  JiongJiongYouShen
//
//  Created by deng on 15/5/8.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionScrollView;
@class EmotionPageControl;

@interface Emoji : UIView
@property (weak, nonatomic) IBOutlet EmotionScrollView *emotionScrollView;

@property (weak, nonatomic) IBOutlet EmotionPageControl *pageControl;

+(instancetype) emoji;
@end
