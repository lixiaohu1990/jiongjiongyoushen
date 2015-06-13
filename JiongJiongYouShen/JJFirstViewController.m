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
#import "MBProgressHUD.h"


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
    return [self configureCellPic:jiongTableViewCell atIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

     Articles *article=[_article_arr objectAtIndex:indexPath.row];
    if (article.cell_height) {
        // NSLog(@"cell_height %ld %lf ",indexPath.row,arti.cell_height);
        return article.cell_height;
    }
    
    static NSString *cellIdentifierPic = @"TableViewCellPic";
    if (!self.propertyCellPic) {
        self.propertyCellPic = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifierPic];
        if (!self.propertyCellPic)  self.propertyCellPic= [[JJTableViewCellPic alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierPic];
    }
    [self configureCellPic:self.propertyCellPic atIndexPath:indexPath];
    
    CGSize size= [self.propertyCellPic.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    //  NSLog(@"propertyCellPic heightForRowAtIndexPath %ld ,%f ",(long)indexPath.row,size.height);
    
    article.cell_height=size.height+1;
    
    return  article.cell_height;
    
}

-(UITableViewCell *) configureCellPic:(JJTableViewCellPic *)jiongTableViewCell atIndexPath:(NSIndexPath *)indexPath{
    
    Articles *article=[_article_arr objectAtIndex:indexPath.row];
    
    jiongTableViewCell.entity=article;//这一步做了优化，详见setEntity
    
    //添加点击事件, 做一些其他事件工作
    [jiongTableViewCell.thumbUpBtn addTarget:self action:@selector(thumbUp:) forControlEvents:UIControlEventTouchUpInside];
    [jiongTableViewCell.commentBtn addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    
    return jiongTableViewCell;
    
}

-(void)thumbUp:(UIButton*)sender{
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
