//
//  CardTableViewCell.h
//  卡片转场1
//
//  Created by Mac on 2018/3/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardSimpleModel.h"

@interface CardTableViewCell : UITableViewCell

///用户头像
@property (nonatomic, strong) UIImageView *userImage;
///模型
@property (nonatomic, strong) CardSimpleModel *model;
///行高
@property (nonatomic, assign) CGFloat cellHeight;

@end
