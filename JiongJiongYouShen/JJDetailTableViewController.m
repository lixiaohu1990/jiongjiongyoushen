//
//  JJDetailTableViewController.m
//  JiongJiongYouShen
//
//  Created by deng on 15/4/30.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import "JJDetailTableViewController.h"
#import "JJDraftViewController.h"
#import "JJTableViewCell.h"
#import "JJCommentTableViewCell.h"
#import "Emoji.h"
@interface JJDetailTableViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) JJTableViewCell *prototypeCell;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIButton *faceBtn;
@property (nonatomic,strong) UIButton *submitBtn;
@property (nonatomic,strong) UIView * commentView;
@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) Emoji *emoji;
@end

@implementation JJDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *Pencil=[[UIImage imageNamed:@"Pencil"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *submission=[[UIBarButtonItem alloc] initWithImage:Pencil style:UIBarButtonItemStylePlain target:self action:@selector(goDraft)];
    self.navigationItem.rightBarButtonItem=submission;
    
    UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem=back;
    self.view.backgroundColor=[UIColor redColor];
    
    
    //self.edgesForExtendedLayout=UIRectEdgeNone;
    
    self.tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStylePlain];

    //table
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    self.prototypeCell=[[JJTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    [self.view addSubview:_tableView];
    [self addCommentView];
    [self keyboardView];
}


- (void)keyboardView{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)keyboardWillShow:(NSNotification*) notification{
    NSDictionary *userInfo= notification.userInfo;
    NSInteger curve=[userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval time=[userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    CGFloat height=[userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    CGRect emojiRect=  self.emoji.frame;
    emojiRect.size.height=height;
    self.emoji.frame=emojiRect;
    
    [UIView animateWithDuration:time animations:^{
        [UIView setAnimationCurve:curve];
         self.view.transform=CGAffineTransformMakeTranslation(0, -height);

    }];
   // UIEventSubtypeMotionShake
    _tableView.userInteractionEnabled=NO;
    
}
-(void)keyboardWillHide:(NSNotification*) notification{
    NSDictionary *userInfo= notification.userInfo;
    NSInteger curve=[userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval time=[userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    //CGFloat height=[userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [UIView animateWithDuration:time animations:^{
        [UIView setAnimationCurve:curve];
        self.view.transform=CGAffineTransformIdentity;
        
    }];
    _tableView.userInteractionEnabled=YES;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //_commentView.transform=CGAffineTransformMakeTranslation(0, -330);
   // [self.view setNeedsUpdateConstraints];
   
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)addCommentView{

    _commentView=[UIView newAutoLayoutView];
    _commentView.backgroundColor=[[UIColor greenColor] colorWithAlphaComponent:0.3];
    
    _textView=[UITextView newAutoLayoutView];
    _textView.layer.cornerRadius=5;
    _textView.layer.borderColor=[UIColor redColor].CGColor;
   // _textView.placeholder=@"请输入评论内容";
    
    _faceBtn=[UIButton newAutoLayoutView];
    [_faceBtn setImage:[UIImage imageNamed:@"fa-meh-o"] forState:UIControlStateNormal];
    
    _submitBtn=[UIButton newAutoLayoutView];
  //  _submitBtn.backgroundColor=[UIColor redColor];
    [_submitBtn setTitle:@"评论" forState:UIControlStateNormal];
    
    [_commentView addSubview:_textView];
    [_commentView addSubview:_faceBtn];
    [_commentView addSubview:_submitBtn];
    
    
    [_faceBtn addTarget:self action:@selector(faceClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_commentView];
    [self.view setNeedsUpdateConstraints];
   // [self.view updateConstraintsIfNeeded];
    
}
      //  [views autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:20.0 insetSpacing:YES matchedSizes:YES];
- (void)updateViewConstraints
{
    
    [super updateViewConstraints];
    if (!self.didSetupConstraints) {
                [_textView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
                [_textView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
                [_textView autoSetDimension:ALDimensionWidth toSize:150 relation:NSLayoutRelationGreaterThanOrEqual];
        
                [_faceBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:_textView withOffset:10];
                [_faceBtn autoSetDimension:ALDimensionWidth toSize:30];
        
                [_submitBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:_faceBtn withOffset:10];
            //    [_submitBtn autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
                [_submitBtn autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
                [_submitBtn autoSetDimension:ALDimensionWidth toSize:40];
        
        
                [_commentView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
                [_commentView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
                [_commentView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view];
                [_commentView autoSetDimension:ALDimensionHeight toSize:40];
        
         NSArray *views = @[_textView,_faceBtn,_submitBtn];
         [views autoSetViewsDimension:ALDimensionHeight toSize:30.0];
         [views autoAlignViewsToAxis:ALAxisHorizontal];
        
        self.didSetupConstraints = YES;
    }
    
}

-(Emoji*)emoji{
    if (!_emoji) {
        _emoji=[Emoji emoji];
    }
    return _emoji;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
       return  [self subjectCell];
    }
    
    return  [self commentCell:tableView cellForRowAtIndexPath:indexPath];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return  [self subjectCell:tableView heightForRowAtIndexPath:indexPath];
    }
    
    return [self commentCell:tableView heightForRowAtIndexPath:indexPath];
}


-(CGFloat)subjectCell:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JJTableViewCell *jiongTableViewCell= self.prototypeCell;
    if (!jiongTableViewCell) {
        jiongTableViewCell = [[JJTableViewCell alloc] init];
        self.prototypeCell=jiongTableViewCell;
    }
    
    jiongTableViewCell.nicknameLable.text=@"我是姚明";
    jiongTableViewCell.sexImg.image=[UIImage imageNamed:@"fa-female"];
    jiongTableViewCell.timeIndicatorImg.image=[UIImage imageNamed:@"Fill 29"];
    jiongTableViewCell.timeLable.text=@"2小时前 ";
    jiongTableViewCell.contentLable.text=@"saôxzcxzçsdasdasdsa容x\ndasdaw😃dsadsad容x\ndasdaw😃sadsadasd😊";
    // jiongTableViewCell.contentImg.image=[UIImage imageNamed:@"1"];
    
    jiongTableViewCell.jiongLable.text=@"200 囧";
    jiongTableViewCell.commentLable.text=@"200 评论 ";
    
    
    [jiongTableViewCell setNeedsUpdateConstraints];
    [jiongTableViewCell updateConstraintsIfNeeded];
    
    [jiongTableViewCell setNeedsLayout];
    [jiongTableViewCell layoutIfNeeded];
    
    CGSize size= [jiongTableViewCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
   // NSLog(@"jiongTableViewCell Higth %@",NSStringFromCGSize(size));
    return size.height+1;
}

- (UITableViewCell *)subjectCell {

    static NSString *cellIdentifier = @"TableViewCell";
    JJTableViewCell *jiongTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!jiongTableViewCell) {
        jiongTableViewCell= [[JJTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    jiongTableViewCell.nicknameLable.text=@"我是姚明";
    jiongTableViewCell.sexImg.image=[UIImage imageNamed:@"fa-female"];
    jiongTableViewCell.timeIndicatorImg.image=[UIImage imageNamed:@"Fill 29"];
    jiongTableViewCell.timeLable.text=@"2小时前 ";
    jiongTableViewCell.contentLable.text=@"saôxzcxzçsdasdasdsa容x\ndasdaw😃dsadsad容x\ndasdaw😃sadsadasd😊";
    //  jiongTableViewCell.contentImg.image=[UIImage imageNamed:@"1"];
    
    jiongTableViewCell.jiongLable.text=@"200 囧";
    jiongTableViewCell.commentLable.text=@"200 评论 ";
    
    [jiongTableViewCell setNeedsUpdateConstraints];
    [jiongTableViewCell updateConstraintsIfNeeded];
    
    
    //添加点击事件
    
    [jiongTableViewCell.thumbUpBtn addTarget:self action:@selector(thumbUp:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return jiongTableViewCell;
}
- (UITableViewCell *)commentCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //指定cellIdentifier为自定义的cell
     NSString *CellIdentifier = @"commentCell";
    //自定义cell类
    JJCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"commentCell" owner:self options:nil] lastObject];
    }
    
    //xib的cell.contentView.translatesAutoresizingMaskIntoConstraints的默认是YES，开启会打乱布局，我勒个日
  //  cell.contentView.translatesAutoresizingMaskIntoConstraints=NO;
    //添加测试数据
    cell.avatarBtn.imageView.image=[UIImage imageNamed:@"default"];
    cell.sexImg.image=[UIImage imageNamed:@"fa-male"];
    cell.nameLable.text=@"姚明的哥";
    cell.contentLable.text=@"评论内容";
    cell.orderLable.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;

}


-(CGFloat)commentCell:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //指定cellIdentifier为自定义的cell
     NSString *CellIdentifier = @"commentCell";
    //自定义cell类
    JJCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"commentCell" owner:self options:nil] lastObject];
    }
   // cell.contentView.translatesAutoresizingMaskIntoConstraints=NO;

    //添加测试数据
    cell.avatarBtn.imageView.image=[UIImage imageNamed:@"default"];
    cell.sexImg.image=[UIImage imageNamed:@"fa-male"];
    cell.nameLable.text=@"姚明的哥";
    cell.contentLable.text=@"评论内容";
    cell.orderLable.text=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGSize size= [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return size.height+1;
}



-(void)thumbUp:(id)sender{
    NSLog(@"jiongTableViewCell Higth %@",sender);
    
}
-(void)faceClick:(id)sender{
    [_textView resignFirstResponder];

   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.15f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         self.textView.inputView=self.textView.inputView?nil:self.emoji;
         [_textView becomeFirstResponder];
    });

   
    
}
-(void)goDraft{
    JJDraftViewController *daft=[[JJDraftViewController alloc] init];
    [self.navigationController pushViewController:daft animated:NO];
    
}



@end
