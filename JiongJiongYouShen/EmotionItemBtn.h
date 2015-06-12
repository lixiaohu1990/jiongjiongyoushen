//
//  EmotionItemBtn.h
//  JiongJiongYouShen
//
//  Created by deng on 15/5/9.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmotionModel;
@interface EmotionItemBtn : UIButton
@property (nonatomic,strong) NSString* code;
@property (nonatomic,strong) EmotionModel *emotionModel;
@end
