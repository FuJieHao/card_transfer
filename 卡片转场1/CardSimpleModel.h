//
//  CardSimpleModel.h
//  卡片转场1
//
//  Created by Mac on 2018/3/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardSimpleModel : NSObject

@property (nonatomic, strong) NSString *userPic;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userOther;
@property (nonatomic, strong) NSString *userComment;

+ (NSArray <CardSimpleModel *> *)cardModel;

@end
