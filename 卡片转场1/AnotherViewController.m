//
//  AnotherViewController.m
//  卡片转场1
//
//  Created by Mac on 2018/3/13.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "AnotherViewController.h"
#import "CardModel.h"
#import "CardStartsView.h"
#import "CardTransition.h"
#import "CardTableViewCell.h"
#import "CardSimpleModel.h"

#define Marign 80
#define CellId @"cellId"

@interface AnotherViewController () <UITableViewDelegate, UITableViewDataSource>

///存储行高数组
@property (nonatomic, strong) NSMutableArray *arrCellHeight;

@end

@implementation AnotherViewController
{
    NSArray *_arrModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrCellHeight = [NSMutableArray array];
    //获取模型
    _arrModel = [CardSimpleModel cardModel];
    
    [self setupUI];
}

- (NSMutableArray *)calculatePicCenter
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:4];
    CGFloat start = TitleViewHeight + TopViewHeight;
    CGFloat centerX = 30;
    for (NSInteger i = 0; i < 4; i++) {
        CGFloat centerY = start + 10 + 15;
        [arr addObject:NSStringFromCGPoint(CGPointMake(centerX, centerY))];
        
        if (self.arrCellHeight.count != 0) {
            start += [self.arrCellHeight[i] floatValue];
        }  
    }
    return arr;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//计算行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardTableViewCell *cell = [[CardTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellId];
    
    cell.model = _arrModel[indexPath.row];
    
    [self.arrCellHeight addObject:@(cell.cellHeight)];
    return cell.cellHeight;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId forIndexPath:indexPath];
    
    cell.model = _arrModel[indexPath.row];
    return cell;
}

#pragma mark - 控制器生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.5 animations:^{
        self.titleView.frame = CGRectMake(0, TopViewHeight - Marign, ScreenWidth, Marign);
        self.titleView.alpha = 0.9;
        self.tableView.frame = CGRectMake(0, TitleViewHeight + TopViewHeight - Marign - 30, ScreenWidth, ScreenHeight - (TitleViewHeight + TopViewHeight - Marign - 30));
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

#pragma mark - setUI

//指定转场动画
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    return [CardTransition transitionWithType:operation == UINavigationControllerOperationPush ?
                          CardTransitionPush : CardTransitionPop];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTableHeaderView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TitleViewHeight + TopViewHeight, ScreenWidth, ScreenHeight - (TitleViewHeight + TopViewHeight))];
    
    [self.tableView registerClass:[CardTableViewCell class] forCellReuseIdentifier:CellId];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //这样的做法拿不到每个cell具体的高度，抛弃
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    //self.tableView.estimatedRowHeight = 60;
    
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.tableView];
    
    //返回按钮
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(27);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.width.height.mas_equalTo(@30);
    }];
}

- (void)setTableHeaderView
{
    self.topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[CardModel cardModel][self.index].cardPicName]];
    self.topImageView.userInteractionEnabled = YES;
    self.topImageView.frame = CGRectMake(0, -1.5 * Marign, ScreenWidth, TopViewHeight + 1.5 * Marign);
    self.topImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.topImageView];
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, TopViewHeight , ScreenWidth, TitleViewHeight)];
    self.titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.titleView];
    
    //标题
    UILabel *titleLabel = [UILabel cz_labelWithText:@"罗兰是个大傻子 * 100" fontSize:16 color:[UIColor lightGrayColor]];
    titleLabel.numberOfLines = 1;
    [self.titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_top).offset(15);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    //评价
    UILabel *comment = [UILabel cz_labelWithText:@"100 comments" fontSize:14 color:[UIColor grayColor]];
    comment.textAlignment = NSTextAlignmentLeft;
    [self.titleView addSubview:comment];
    [comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.titleView.mas_left).offset(15);
        make.height.mas_equalTo(@20);
    }];
    
    //星星
    CardStartsView *startView = [[CardStartsView alloc] init];
    startView.level = 4;
    [self.titleView addSubview:startView];
    [startView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(comment.mas_centerY);
        make.left.equalTo(comment.mas_right).offset(10);
        make.width.mas_equalTo(@70);
        make.height.mas_equalTo(@20);
    }];
}

- (void)clickBackBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
