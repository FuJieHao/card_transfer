//
//  CardTableViewCell.m
//  卡片转场1
//
//  Created by Mac on 2018/3/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CardTableViewCell.h"

#define Scala (1 < 0 ? ((ScreenWidth * (3.0 / 5)) / ScreenWidth) : 1)

@interface CardTableViewCell ()

///用户昵称
@property (nonatomic, strong) UILabel *userName;
///用户额外信息
@property (nonatomic, strong) UILabel *userOtherInfo;
///用户评论
@property (nonatomic, strong) UILabel *userComment;

@end

@implementation CardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setModel:(CardSimpleModel *)model
{
    _model = model;
    
    self.userName.text = model.userName;
    self.userImage.image = [UIImage circleImage:model.userPic];
    self.userOtherInfo.text = model.userOther;
    self.userComment.text = model.userComment;

    CGSize size = [model.userComment boundingRectWithSize:CGSizeMake(ScreenWidth - 15, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;

    [self.userComment mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(size.height));
    }];
    
    [self layoutIfNeeded];
}

- (void)setupUI
{
    //用户头像
    self.userImage = [[UIImageView alloc] initWithImage:[UIImage circleImage:self.model.userPic]];
    [self.contentView addSubview:self.userImage];
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15 * Scala);
        make.top.equalTo(self.contentView).offset(10 * Scala);
        make.width.height.mas_equalTo(@(30 * Scala));
    }];

    
    //用户昵称
    self.userName = [UILabel cz_labelWithText:self.model.userName fontSize:15 * Scala color:[UIColor blackColor]];
    self.userName.font = [UIFont fontWithName:@"Arial-BoldMT" size:15 * Scala];
    [self.contentView addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userImage);
        make.left.equalTo(self.userImage.mas_right).offset(15 * Scala);
        make.height.mas_equalTo(@(21 * Scala));
    }];
    
    //用户额外信息
    self.userOtherInfo = [UILabel cz_labelWithText:self.model.userOther fontSize:13 * Scala color:[UIColor lightGrayColor]];
    CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-(15 * Scala) * (CGFloat)M_PI / 180), 1, 0, 0);
    self.userOtherInfo.transform = matrix;
    [self.contentView addSubview:self.userOtherInfo];
    [self.userOtherInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.userName);
        make.right.equalTo(self.contentView.mas_right).offset(-(25 * Scala));
        make.height.mas_equalTo(@(18 * Scala));
    }];
    
    self.userComment = [UILabel cz_labelWithText:@"xxxxxxx" fontSize:14 * Scala color:[UIColor darkGrayColor]];
    self.userComment.numberOfLines = 0;
    self.userComment.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.userComment];
    [self.userComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImage.mas_bottom).offset(10 * Scala);
        make.left.equalTo(self.contentView.mas_left).offset(15 * Scala);
        make.right.equalTo(self.contentView.mas_right).offset(-(15 * Scala));
        //        make.bottom.equalTo(self.contentView).offset(-(15 * Scala));
        make.height.mas_equalTo(@(10 * Scala));
    }];
}

- (CGFloat)cellHeight
{
    return CGRectGetMaxY(self.userComment.frame) + 15;
}


@end
