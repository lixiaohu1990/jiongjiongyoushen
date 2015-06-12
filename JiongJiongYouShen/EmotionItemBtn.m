//
//  EmotionItemBtn.m
//  JiongJiongYouShen
//
//  Created by deng on 15/5/9.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import "EmotionItemBtn.h"
#import "NSString+Emoji.h"
#import "EmotionModel.h"
@implementation EmotionItemBtn
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self configureBtn];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //按钮初始化
        [self configureBtn];
    }
    
    return self;
}



-(void)configureBtn{
    self.titleLabel.font=[UIFont systemFontOfSize:32];
    self.adjustsImageWhenHighlighted=NO;
}
-(void)setEmotionModel:(EmotionModel *)emotionModel{
    _emotionModel=emotionModel;
    self.code=emotionModel.code;
}
-(void)setCode:(NSString *)code{
    _code=code;
    [self setTitle:[code emoji] forState:UIControlStateNormal];
    //[self setTitle:@"nihao" forState:UIControlStateNormal];
}

@end
