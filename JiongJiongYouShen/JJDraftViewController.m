//
//  JJDraftViewController.m
//  JiongJiongYouShen
//
//  Created by deng on 15/4/28.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import "JJDraftViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
@interface JJDraftViewController ()

@end

@implementation JJDraftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *Pencil=[[UIImage imageNamed:@"fa-send"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *submission=[[UIBarButtonItem alloc] initWithImage:Pencil style:UIBarButtonItemStylePlain target:self action:@selector(submitDraft)];
    self.navigationItem.rightBarButtonItem=submission;
    
    
}
-(void)submitDraft{
    
    AFHTTPRequestOperationManager *manner=[AFHTTPRequestOperationManager manager];
    manner.requestSerializer.HTTPShouldHandleCookies=YES;// Creates and returns a serializer with default configuration.
    
    [manner POST:api_article_post_store parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dicts=[responseObject valueForKey:@"data"];
        
         NSLog(@"dicts %@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        NSLog(@"error %@",error);
      
    }];
     
   NSLog(@"submitDraft");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
