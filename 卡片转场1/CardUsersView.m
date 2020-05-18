//
//  CardUsersView.m
//  卡片转场1
//
//  Created by Mac on 2018/3/12.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CardUsersView.h"

#define UsersCount 4
#define UserWidth 30

@implementation CardUsersView

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setUsers:(NSArray *)users
{
    NSInteger usersCount = users.count >= UsersCount ? UsersCount : users.count;

    for (NSInteger i = 0; i < usersCount; i++) {
        UIImageView *imageView = [self createImageViewWithName:[NSString stringWithFormat:@"%ld",(i + 1) * 10]];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(@(i * 25));
            make.width.equalTo(@30);
        }];
    }
    _users = users;
}

- (UIImageView *)createImageViewWithName:(NSString *)name
{
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage circleImage:name];
    [self addSubview:imageV];
    return imageV;
}



@end
