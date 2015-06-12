//
//  JJFirstViewController.m
//  JiongJiongYouShen
//
//  Created by deng on 15/4/27.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import "JJFirstViewController.h"
#import "JJDraftViewController.h"
#import "JJTableViewCellPic.h"
#import "JJDetailTableViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "Articles.h"
#import "Img.h"
#import "Video.h"
#import "Student.h"
#import "Users.h"
#import "MBProgressHUD.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface JJFirstViewController()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>
@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic,strong) JJTableViewCellPic *propertyCellPic;
@property (nonatomic,strong)  NSMutableArray *article_arr;
@property (nonatomic ,assign) NSUInteger page_count;
@property (nonatomic,strong) MBProgressHUD *HUD;
@end

@implementation JJFirstViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
   UIImage *Pencil=[[UIImage imageNamed:@"Pencil"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UIBarButtonItem *submission=[[UIBarButtonItem alloc] initWithImage:Pencil style:UIBarButtonItemStylePlain target:self action:@selector(goDraft)];
    self.navigationItem.rightBarButtonItem=submission;
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=back;
    
    
    //table
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    
    [self.view addSubview:_tableView];
    [self downLoad];
    
    
}
#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [self.HUD removeFromSuperview];
}
- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}

-(void) downLoad{

    self.HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.HUD];
    
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    self.HUD.delegate = self;
    self.HUD.labelText = @"Loading";
    [self.HUD show:YES];

    // Show the HUD while the provided method executes in a new thread
   // [self.HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
    
        AFHTTPRequestOperationManager *manner=[AFHTTPRequestOperationManager manager];
        manner.requestSerializer.HTTPShouldHandleCookies=YES;// Creates and returns a serializer with default configuration.
        _article_arr=[NSMutableArray arrayWithCapacity:10];
        [manner GET:api_article_list parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *dicts=[responseObject valueForKey:@"data"];
            _page_count=[responseObject valueForKey:@"count"];

            for (NSDictionary *dic in dicts) {
                 Articles *article=[Articles objectWithKeyValues:dic];
                [_article_arr addObject:article];
            }
          //  Articles *art=[_article_arr objectAtIndex:1];
            
         //  NSLog(@"art.title %@,art.body %@",art.title,art.body);
            
          dispatch_async(dispatch_get_main_queue(), ^{
               [self.tableView reloadData];
               [self.HUD hide:YES];
          });
            
           // NSLog(@"self.title %@,self.body %@",self.article.title,self.article.body);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"responseObject %@",error);
        }];


}
//-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
//    return NO;
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _article_arr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    static NSString *cellIdentifierPic = @"TableViewCellPic";
    JJTableViewCellPic *jiongTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifierPic];
    
    if (!jiongTableViewCell) {
        jiongTableViewCell= [[JJTableViewCellPic alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierPic];
    }
    [jiongTableViewCell  removeConstraints];
    return [self configureCellPic:jiongTableViewCell atIndexPath:indexPath];
}
-(UITableViewCell *) configureCellPic:(JJTableViewCellPic *)jiongTableViewCell atIndexPath:(NSIndexPath *)indexPath{
   
    Articles *arti=[_article_arr objectAtIndex:indexPath.row];
    
    jiongTableViewCell.nicknameLable.text=arti.user.name;
    jiongTableViewCell.sexImg.image=[UIImage imageNamed:@"fa-female"];
    jiongTableViewCell.timeLable.text=@"2小时前 ";
    jiongTableViewCell.contentLable.text=arti.body;
    if (arti.user.avatar) {
        NSString *avatar=[ api_web_root stringByAppendingString:arti.user.avatar];
        
        NSData *avatar_data=[NSData dataWithContentsOfURL:[NSURL URLWithString:avatar]];
        UIImage *avatar_image=[UIImage imageWithData:avatar_data];
        
        [jiongTableViewCell.avatar setImage:avatar_image forState:UIControlStateNormal];
    }
    jiongTableViewCell.cell_type=CellTypeText;
    if (arti.img) {
        
        NSArray *m_size=[arti.img.image_size valueForKey:@"s"];
        
        jiongTableViewCell.image_size=CGSizeMake([[m_size objectAtIndex:0] floatValue],[[m_size objectAtIndex:1] floatValue]);
        
        NSString *orginal_url = [arti.img.url stringByReplacingOccurrencesOfString:@"." withString:@"_m."];
     
        NSString *real_url=[ api_web_root stringByAppendingString:orginal_url];
      
        [jiongTableViewCell.contentImg sd_setImageWithURL:[NSURL URLWithString:real_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        jiongTableViewCell.cell_type=CellTypeImg;
       //  NSLog(@"jiongTableViewCell %@",jiongTableViewCell.contentImg);
     }
    
    
    jiongTableViewCell.jiongLable.text=[NSString stringWithFormat:@"%@ 囧",arti.good_num];
    jiongTableViewCell.commentLable.text=[NSString stringWithFormat:@"%@ 评论",arti.comment_num];
    
    [jiongTableViewCell setNeedsUpdateConstraints];
    [jiongTableViewCell updateConstraintsIfNeeded];
    
    [jiongTableViewCell setNeedsLayout];
    [jiongTableViewCell layoutIfNeeded];
    
    //添加点击事件
    
    [jiongTableViewCell.thumbUpBtn addTarget:self action:@selector(thumbUp:) forControlEvents:UIControlEventTouchUpInside];
    [jiongTableViewCell.commentBtn addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    
    return jiongTableViewCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

     Articles *arti=[_article_arr objectAtIndex:indexPath.row];
    if (arti.cell_height) {
        // NSLog(@"cell_height %ld %lf ",indexPath.row,arti.cell_height);
        return arti.cell_height;
    }
    
    static NSString *cellIdentifierPic = @"TableViewCellPic";
    if (!self.propertyCellPic) {
        self.propertyCellPic = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifierPic];
        if (!self.propertyCellPic)  self.propertyCellPic= [[JJTableViewCellPic alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierPic];
    }
    [self.propertyCellPic  removeConstraints];
    [self configureCellPic:self.propertyCellPic atIndexPath:indexPath];
    
    CGSize size= [self.propertyCellPic.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    //  NSLog(@"propertyCellPic heightForRowAtIndexPath %ld ,%f ",(long)indexPath.row,size.height);
    
    arti.cell_height=size.height+1;
    return  arti.cell_height;

    
//    static NSString *cellIdentifier = @"TableViewCell";
//    static JJTableViewCell *jiongTableViewCell = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        jiongTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        
//        if (!jiongTableViewCell) {
//            jiongTableViewCell = [[JJTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        }
//    });
//    
//    [jiongTableViewCell  removeConstraints];
    
}


-(void)thumbUp:(UIButton*)sender{
   // NSLog(@"jiongTableViewCell Higth %@",sender);
    [sender setImage:[UIImage imageNamed:@"fa-thumbs-up"] forState:UIControlStateNormal];

}
-(void)comment:(id)sender{
    JJDetailTableViewController *detail=[[JJDetailTableViewController alloc] init];
    [self.navigationController pushViewController:detail animated:NO];
}

-(void)goDraft{
    JJDraftViewController *daft=[[JJDraftViewController alloc] init];
    [self.navigationController pushViewController:daft animated:NO];

}
@end
