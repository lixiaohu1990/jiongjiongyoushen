//
//  EmotionScrollView.m
//  JiongJiongYouShen
//
//  Created by deng on 15/5/9.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import "EmotionScrollView.h"

@implementation EmotionScrollView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //视图准备
        [self viewPrepare];
    }
    
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    
    if(self){
        
        //视图准备
        [self viewPrepare];
    }
    
    return self;
}


/*
 *  视图准备
 */
-(void)viewPrepare{
    
   // self.showsHorizontalScrollIndicator=NO;
    self.showsVerticalScrollIndicator=NO;
    
    self.pagingEnabled=YES;
    
    //设置代理
    self.delegate=self;
}
/*
 *  代理方法专区
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.isScroll = YES;
    
    //计算页码
   // NSUInteger page = (scrollView.contentOffset.x / self.bounds.size.width) + .5f;
    
   // self.page = page;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.isScroll=NO;
}

-(void)setIsScroll:(BOOL)isScroll{
    
    if(_isScroll == isScroll) return;
    
    _isScroll = isScroll;
}

/*
 *  添加一组视图
 */
-(void)addSubviewsWithArray:(NSArray *)views{
    
    [views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        
        [self addSubview:view];
    }];
}
/*
 *  根据子视图的数量确定contentSize
 */
-(void)contentSizeMakeSure:(NSUInteger)num{
    
    _num = num;
    
    CGRect bounds = self.bounds;
    
    bounds.size.width=[UIScreen mainScreen].bounds.size.width;
    
    CGFloat width = bounds.size.width * num;
    
    CGSize contentSize = CGSizeMake(width,0);
    
    self.contentSize = contentSize;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if(_isScroll) return;
    
    __block CGRect frame = self.bounds;
    
    CGFloat width = frame.size.width;
    //  NSLog(@"%d",self.subviews.count);
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        
        frame.origin.x = idx * width;
        
        subView.frame= frame;
    }];
}

@end
