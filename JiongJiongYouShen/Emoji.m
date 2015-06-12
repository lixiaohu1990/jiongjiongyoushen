//
//  Emoji.m
//  JiongJiongYouShen
//
//  Created by deng on 15/5/8.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import "Emoji.h"
#import "EmotionModel.h"
#import "EmotionScrollView.h"
#import "EmotionPageView.h"
@implementation Emoji
+(instancetype)emoji{
    Emoji* instance=[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
   
    return instance;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self configureScroll];
    [self configurePageControll];
}

-(void) configureScroll{
    
    NSArray *subEmotionArray=[EmotionModel pagesArray];

    NSArray *pagesView=[EmotionPageView emotionPageViewsWithPageModleArr:subEmotionArray];
   
  
    [_emotionScrollView contentSizeMakeSure:pagesView.count];
   
    
    [_emotionScrollView addSubviewsWithArray:pagesView];

}

-(void)configurePageControll{
    
}

@end
