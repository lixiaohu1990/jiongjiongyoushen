//
//  JJTableViewCell.m
//  JiongJiongYouShen
//
//  Created by deng on 15/4/28.
//  Copyright (c) 2015年 deng. All rights reserved.
//

#import "JJTableViewCellPic.h"
#import "Articles.h"
#import "Users.h"
#import "Img.h"
#import "Video.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "SDWebImage/UIButton+WebCache.h"

static CGSize const kAvatarSize = {32.f, 32.f};
@interface JJTableViewCellPic()
@property (assign,nonatomic) BOOL didSetupConstraints;
@end
@implementation JJTableViewCellPic
- (void)baseSetup {
    self.imageView.image = nil;
    self.imageView.hidden = YES;
    self.textLabel.text = nil;
    self.textLabel.hidden = YES;
    self.detailTextLabel.text = nil;
    self.detailTextLabel.hidden = YES;
   // self.selectionStyle=UITableViewCellSelectionStyleBlue;
    self.selectedBackgroundView=[[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.1f];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self baseSetup];
        [self initCell];
    }
    return self;
}

- (void)initCell{
      //  self.contentView.backgroundColor = [UIColor redColor];
     self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    _avatar=[UIButton newAutoLayoutView];
    _avatar.backgroundColor=[[UIColor redColor] colorWithAlphaComponent:0.3];
    _avatar.layer.cornerRadius= kAvatarSize.height / 2.f;
    _avatar.layer.masksToBounds=YES;
    [_avatar setImage:[UIImage imageNamed:@"default"] forState:UIControlStateNormal];

    _nicknameLable=[UILabel newAutoLayoutView];
    _nicknameLable.textColor=[[UIColor blueColor] colorWithAlphaComponent:0.4];
    _nicknameLable.numberOfLines=1;
    _nicknameLable.font=[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
    _sexImg=[UIImageView newAutoLayoutView];
   // _sexImg.backgroundColor=[[UIColor purpleColor] colorWithAlphaComponent:.3f];
    
    _timeIndicatorImg=[UIImageView newAutoLayoutView];
    _timeIndicatorImg.image=[UIImage imageNamed:@"Fill 29"];
  //  _timeIndicatorImg.backgroundColor=[[UIColor purpleColor] colorWithAlphaComponent:.3f];
    
    _timeLable=[UILabel newAutoLayoutView];
    _timeLable.textColor=[[UIColor colorWithWhite:0.081 alpha:1.000] colorWithAlphaComponent:.4f];
    _timeLable.font=[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
    _contentLable=[UILabel newAutoLayoutView];
    _contentLable.textColor=[[UIColor lightGrayColor] colorWithAlphaComponent:.3f];
    _contentLable.numberOfLines=0;
    _contentLable.font=[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];

    _contentImg=[UIImageView newAutoLayoutView];
    _contentImg.backgroundColor=[[UIColor purpleColor] colorWithAlphaComponent:.3f];

    _jiongLable=[UILabel newAutoLayoutView];
    _jiongLable.textColor=[[UIColor lightGrayColor] colorWithAlphaComponent:.3f];
    _jiongLable.font=[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];

    _commentLable=[UILabel newAutoLayoutView];
    _commentLable.textColor=[[UIColor lightGrayColor] colorWithAlphaComponent:.3f];
    _commentLable.font=[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
    _thumbUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //_thumbUpBtn.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.3f];
    
    _thumbDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    // _thumbDownBtn.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:.3f];
    
    _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   //  _commentBtn.backgroundColor = [[UIColor magentaColor] colorWithAlphaComponent:.3f];
    
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    // _shareBtn.backgroundColor = [[UIColor magentaColor] colorWithAlphaComponent:.3f];
    
    [_thumbUpBtn setImage:[UIImage imageNamed:@"fa-thumbs-o-up"] forState:UIControlStateNormal];
    [_thumbDownBtn setImage:[UIImage imageNamed:@"fa-thumbs-o-down"] forState:UIControlStateNormal];
    
    [_commentBtn setImage:[UIImage imageNamed:@"fa-comment"] forState:UIControlStateNormal];
    [_shareBtn setImage:[UIImage imageNamed:@"fa-share-alt"] forState:UIControlStateNormal];
    
    
    [self.contentView addSubview:_avatar];
    [self.contentView addSubview:_nicknameLable];
    [self.contentView addSubview:_sexImg];
    
    [self.contentView addSubview:_timeIndicatorImg];
    [self.contentView addSubview:_timeLable];
    
    [self.contentView addSubview:_contentLable];
    [self.contentView addSubview:_contentImg];
    
    [self.contentView addSubview:_jiongLable];
    [self.contentView addSubview:_commentLable];
    
    [self.contentView addSubview:_thumbUpBtn];
    [self.contentView addSubview:_thumbDownBtn];
    [self.contentView addSubview:_commentBtn];
    [self.contentView addSubview:_shareBtn];

}

- (UIImage *)buttonImageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
-(void)setUpConstraints{
    
//   NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|" options:0 metrics:nil views:@{@"contentView" : self.contentView}];
//    [self.contentView.superview addConstraints:horizontalConstraints];

    
    [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.contentView autoSetDimension:ALDimensionWidth toSize:K_SCREEN_WIDTH];
    
   // [self.contentView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.avatar autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [self.avatar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [self.avatar autoSetDimensionsToSize:kAvatarSize];
    
    [self.nicknameLable autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:_avatar withOffset:10];
    //[self.nicknameLable autoSetDimensionsToSize:[self.nicknameLable intrinsicContentSize]];
    
    [self.sexImg autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:_nicknameLable withOffset:10];
   // [self.sexImg autoSetDimensionsToSize:kSexSize];
    
    [self.timeIndicatorImg autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:_timeLable withOffset:-10];
    [self.timeIndicatorImg autoSetDimensionsToSize:CGSizeMake(10, 10)];
    
    [self.timeLable autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
  //  [self.timeLable autoSetDimensionsToSize:[self.timeLable intrinsicContentSize]];
    
    [@[_avatar,_nicknameLable,_sexImg,_timeIndicatorImg,_timeLable] autoAlignViewsToAxis:ALAxisHorizontal];
    
    
    [self.contentLable autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
    [self.contentLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatar withOffset:10];
    [self.contentLable autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:_avatar];
   //self.cell_type==CellTypeText
    //self.contentImg.image==nil
   
    if (self.cell_type==CellTypeText ) {
        [self.jiongLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:20];
      // NSLog(@"contentImg WEI NIL  %@,artcicle_id %@",self.contentImg.image,self.artcicle_id);

    }else{
       //  NSLog(@"contentImg %@,artcicle_id %@",self.contentImg.image,self.artcicle_id);
         self.contentImg.contentMode=UIViewContentModeScaleToFill;
        [self.contentImg autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentLable withOffset:10];
        
        [self.contentImg autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:_avatar];
    
     //   [self.contentImg autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:10];
     
       CGFloat width=K_SCREEN_WIDTH-20;
       CGFloat height= (self.image_size.height/ self.image_size.width)*width;
        
       [self.contentImg autoSetDimension:ALDimensionWidth toSize:width];
       [self.contentImg autoSetDimension:ALDimensionHeight toSize:height];
    
       [self.jiongLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentImg withOffset:20];
    }
    
    [self.jiongLable autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:_avatar];
   // [self.jiongLable autoSetDimensionsToSize:[self.jiongLable intrinsicContentSize]];
    
    
    [self.commentLable autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:_jiongLable withOffset:20];
    [self.commentLable autoAlignAxis:ALAxisHorizontal toSameAxisOfView:_jiongLable];
    
    [self.thumbUpBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_jiongLable withOffset:10];
   [self.thumbUpBtn autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    
      [self.thumbUpBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeLeading ofView:_avatar];
    
    [self.thumbDownBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:_thumbUpBtn withOffset:50];

    
    [self.commentBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:_thumbDownBtn withOffset:50];
    
   
    [self.shareBtn autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:_commentBtn withOffset:50];
    
    NSArray *buttons=@[_thumbUpBtn,_thumbDownBtn,_commentBtn,_shareBtn];
  [buttons autoAlignViewsToAxis:ALAxisHorizontal];
//    
   // CGSize size= [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];//IOS8里面不能用这个，不然会崩溃
 //  NSLog(@"contentView Higth %@,text is %@",NSStringFromCGSize(size),self.nicknameLable.text);
   //  NSLog(@"text is %@,intrinsicContentSize %@",self.nicknameLable.text,NSStringFromCGSize([self.nicknameLable intrinsicContentSize]));
  //  NSLog(@"didSetupConstraints");
    
    self.didSetupConstraints = YES;
}

- (void)setEntity:(Articles *)arti
{
     [self removeConstraints];//设置可以修改约束和去掉以前的约束，防止复用出错
    _entity = arti;
    
    self.artcicle_id=arti.ID;
    self.nicknameLable.text=arti.user.name;
    self.sexImg.image=[UIImage imageNamed:@"fa-female"];
    self.timeLable.text=@"2小时前 ";
    self.contentLable.text=arti.body;
    if (arti.user.avatar) {
        NSString *avatar=[ api_web_root stringByAppendingString:arti.user.avatar];
        
        [self.avatar sd_setImageWithURL:[NSURL URLWithString:avatar]forState:UIControlStateNormal];
    }
    self.cell_type=CellTypeText;
    self.contentImg.image=nil;//假如要用image判断，就要加入nil复原，这里因为还有vedeo，就不用这个
    
    if (arti.img) {
        
        NSArray *m_size=[arti.img.image_size valueForKey:@"s"];
        
        self.image_size=CGSizeMake([[m_size objectAtIndex:0] floatValue],[[m_size objectAtIndex:1] floatValue]);
        
        NSString *orginal_url = [arti.img.url stringByReplacingOccurrencesOfString:@"." withString:@"_m."];
        
        NSString *real_url=[ api_web_root stringByAppendingString:orginal_url];
        
        [self.contentImg sd_setImageWithURL:[NSURL URLWithString:real_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        self.cell_type=CellTypeImg;
        //  NSLog(@"jiongTableViewCell %@",jiongTableViewCell.contentImg);
    }
    
    self.jiongLable.text=[NSString stringWithFormat:@"%@ 囧",arti.good_num];
    self.commentLable.text=[NSString stringWithFormat:@"%@ 评论",arti.comment_num];
    
    
    [self updateCellConstraints];//更新约束
}


-(void) removeConstraints{
     _didSetupConstraints = NO;
    
    [self.contentView.constraints autoRemoveConstraints];
    
    [self.contentImg.constraints autoRemoveConstraints];//必须有
}
//-(void)prepareForReuse{
//    [super prepareForReuse];
//    // NSLog(@"prepareForReuse artcicle_id %@",self.artcicle_id);
//}
- (void)updateCellConstraints {
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        [self setUpConstraints];
    }
    [super updateConstraints];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    self.contentLable.preferredMaxLayoutWidth = CGRectGetWidth(self.contentLable.frame);
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
