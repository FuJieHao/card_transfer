//
//  CardCollectionViewCell.m
//  卡片转场1
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CardCollectionViewCell.h"

@interface CardCollectionViewCell ()

@end

@implementation CardCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    
    return self;
}


- (void)setupUI
{
    //阴影视图
    UIView *shadowView =  [self createShadowView];
    
    //背景视图
    self.bgView = [self setViewWithColor:[UIColor whiteColor] andCornerRadius:5 andAlpha:0.0];
    
    [shadowView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(shadowView);
    }];
    
    //文字视图
    self.titleView = [self setViewWithColor:[UIColor whiteColor] andCornerRadius:5 andAlpha:1.0];
    [shadowView addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(shadowView.mas_bottom);
        make.left.equalTo(shadowView.mas_left);
        make.right.equalTo(shadowView.mas_right);
        make.height.mas_equalTo(@100);
    }];
    
    //标题
    self.title = [UILabel cz_labelWithText:@"罗兰是个大傻子 * 100" fontSize:16 color:[UIColor lightGrayColor]];
    self.title.numberOfLines = 1;
    [self.titleView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_top).offset(15);
        make.left.equalTo(self.titleView.mas_left).offset(15);
        make.width.mas_equalTo(self.contentView.frame.size.width);
    }];
    
    //喜欢
    self.favoriteLabel = [UILabel cz_labelWithText:@"100 comments" fontSize:14 color:[UIColor grayColor]];
    self.favoriteLabel.textAlignment = NSTextAlignmentLeft;
    [self.titleView addSubview:self.favoriteLabel];
    [self.favoriteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(10);
        make.left.equalTo(self.titleView.mas_left).offset(15);
        make.height.mas_equalTo(@20);
    }];
    
    //评价
    self.startsView = [[CardStartsView alloc] init];
    self.startsView.level = 4;
    [self.titleView addSubview:self.startsView];
    [self.startsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.favoriteLabel.mas_centerY);
        make.left.equalTo(self.favoriteLabel.mas_right).offset(10);
        make.width.mas_equalTo(@70);
        make.height.mas_equalTo(@20);
    }];
    
    //用户集合视图
    self.usersPicCount = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4",nil];
    self.usersView = [[CardUsersView alloc] init];
    self.usersView.users = self.usersPicCount;
    [shadowView addSubview:self.usersView];
    [self.usersView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.width.equalTo(@(self.usersPicCount.count * 25 + 5));
        make.top.equalTo(self.favoriteLabel.mas_bottom).offset(3);
        make.left.equalTo(self.bgView.mas_left);
    }];
    
    //最上面的图片
    self.coverImageView = [[UIImageView alloc] init];
    self.coverImageView.layer.cornerRadius = 5; //切个小圆角
    self.coverImageView.layer.masksToBounds = YES;
    self.coverImageView.userInteractionEnabled = NO;
    [shadowView addSubview:self.coverImageView];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(shadowView);
    }];
    
    //添加点击手势
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
    [self.coverImageView addGestureRecognizer:tapImage];
}

- (void)tapImage
{
    if (self.tapCoverImageBlock) {
        self.tapCoverImageBlock(self.index);
    }
}

- (void)loadData:(NSString *)imageName
{
    self.coverImageView.image = [UIImage imageNamed:imageName];
}

- (UIView *)setViewWithColor:(UIColor *)color andCornerRadius:(CGFloat)radius andAlpha:(CGFloat)alpha
{
    UIView *view = [[UIView alloc] init];
    view.alpha = alpha;
    view.backgroundColor = color;
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
    
    return view;
}

- (UIView *)createShadowView
{
    //阴影视图
    UIView *shadowView = [[UIView alloc] init];
    shadowView.layer.cornerRadius = 5;
    shadowView.clipsToBounds = NO;
    shadowView.layer.shadowColor = [UIColor colorWithRed:138.0/255 green:138.0/255 blue:138.0/255 alpha:1.0].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(0, 5);
    shadowView.layer.shadowOpacity = 0.8;
    shadowView.layer.shadowRadius = 10;
    
    [self.contentView addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    return shadowView;
}



@end
