//
//  CardCollectionViewCell.h
//  卡片转场1
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardStartsView.h"
#import "CardUsersView.h"

@interface CardCollectionViewCell : UICollectionViewCell

///卡片控件大背景
@property (nonatomic, strong) UIView *bgView;
///图片视图
@property (nonatomic, strong) UIImageView *coverImageView;
///文本视图
@property (nonatomic, strong) UIView *titleView;
///标题
@property (nonatomic, strong) UILabel *title;
///喜爱标签
@property (nonatomic, strong) UILabel *favoriteLabel;

///星星集合视图
@property (nonatomic, strong) CardStartsView *startsView;
///用户集合视图
@property (nonatomic, strong) CardUsersView *usersView;

@property (nonatomic, strong) NSArray *usersPicCount;

///用来传递索引（不用tag，避免冲突）
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) void (^tapCoverImageBlock)(NSInteger index);

- (void)loadData:(NSString *)imageName;

@end
