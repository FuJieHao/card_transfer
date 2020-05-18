//
//  AnotherViewController.h
//  卡片转场1
//
//  Created by Mac on 2018/3/13.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnotherViewController : UIViewController <UINavigationControllerDelegate>

///tableView
@property (nonatomic, strong) UITableView *tableView;
///索引
@property (nonatomic, assign) NSInteger index;
///顶部图片
@property (nonatomic, strong) UIImageView *topImageView;
///titleView
@property (nonatomic, strong) UIView *titleView;

///获取cell行高数组
- (NSMutableArray *)calculatePicCenter;

@end
