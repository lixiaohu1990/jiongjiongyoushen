//
//  EmotionPageView.m
//  JiongJiongYouShen
//
//  Created by deng on 15/5/9.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import "EmotionPageView.h"
#import "EmotionModel.h"
#import "EmotionItemBtn.h"
#import "EmotionDeleteBtn.h"
#import "EmotionConst.h"
//顶部边距
const CGFloat topInset = 12.f;
//左右边距
const CGFloat left_RightInset = 8.f;
@implementation EmotionPageView
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        //视图准备
       // [self pageViewPrepare];
    }
    
    return self;
}
/*
 *  deleteBtn
 */
-(void)addDeleteBtn{
    
    EmotionDeleteBtn *deleteBtn = [EmotionDeleteBtn deleteBtn];
    self.deleteBtn=deleteBtn;
    [deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
}
/*
 *  点击了删除按钮
 */
-(void)deleteBtnClick:(EmotionDeleteBtn *)btn{
    
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:EmotionDeleteBtnClickNotification object:btn];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSUInteger colNum = [EmotionModel colOFOneRowCount];

    //调整位置,设置frame
    // NSLog(@"luguo row %f",self.bounds.size.height);
    CGFloat btnH = (self.bounds.size.height - topInset) / 3.0f;
    CGFloat btnW =(self.bounds.size.width - left_RightInset * 2) / colNum;
    
    [self.subviews enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        
         [self calFrameWithView:subView rowCount:colNum btnH:btnH btnW:btnW idx:idx ];
    }];
}

-(void)calFrameWithView:(UIView *)subView rowCount:(NSUInteger)rowCount btnH:(CGFloat)btnH btnW:(CGFloat)btnW idx:(NSUInteger)idx{
    NSUInteger row = idx % rowCount;
    NSUInteger col = idx / rowCount;
    CGFloat btnX = row * btnW + left_RightInset;
    CGFloat btnY = col * btnH + topInset;
    CGRect frame = CGRectMake(btnX, btnY, btnW, btnH);
    subView.frame=frame;
}

+(NSArray *)emotionPageViewsWithPageModleArr:(NSArray*) PageModleArr{
    
     NSMutableArray *viewsArray= [NSMutableArray array];
     [PageModleArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      EmotionPageView *pages=[self emotionOnePageViewWithEmotionModle:obj];
         [viewsArray addObject:pages];
     }];
    return viewsArray;
}
+(instancetype)emotionOnePageViewWithEmotionModle:(NSArray*)onePageModel{
    EmotionPageView *pageView=[[EmotionPageView alloc] init];
    pageView.emotionModelArr=onePageModel;
    return pageView;
}
-(void)setEmotionModelArr:(NSArray*)emotionModelArr{
    _emotionModelArr=emotionModelArr;
    [_emotionModelArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        EmotionItemBtn *itemBtm=[EmotionItemBtn buttonWithType:UIButtonTypeCustom];
        itemBtm.emotionModel=obj;
        [itemBtm addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemBtm];
    }];
    //最后添加deleteBTN
   [self addDeleteBtn];
}


-(void)btnClick:(id)sender{
    NSLog(@"btnClick %@",sender);
}
@end
