//
//  CardSimpleModel.m
//  卡片转场1
//
//  Created by Mac on 2018/3/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CardSimpleModel.h"

@implementation CardSimpleModel

+ (NSArray <CardSimpleModel *> *)cardModel {
    
    NSMutableArray *arrM = [NSMutableArray array];
    
        
    CardSimpleModel *model1 = [[CardSimpleModel alloc] init];
    model1.userPic = @"10";
    model1.userName = @"小罗兰";
    model1.userOther = @"厚端工程虱";
    model1.userComment = @"累死老娘了，辛辛苦苦仨月才把 hello world 写出来，啊哈哈哈哈哈";
    
    CardSimpleModel *model2 = [[CardSimpleModel alloc] init];
    model2.userPic = @"20";
    model2.userName = @"富杰";
    model2.userOther = @"菜鸟";
    model2.userComment = @"看看楼上，说点什么好呢，唉，算了，printf(\"hello world\\n\");\n富杰乘舟将欲行，忽闻楼上说编程。\n桃花潭水深千尺，不及厚端工程虱。";
    
    CardSimpleModel *model3 = [[CardSimpleModel alloc] init];

    model3.userPic = @"30";
    model3.userName = @"罗家俊";
    model3.userOther = @"iOS开发";
    model3.userComment = @"和2楼同感，唉，NSLog(@\"hello world\");";
    [arrM addObject:model1];
    [arrM addObject:model2];
    [arrM addObject:model3];
    
    
    CardSimpleModel *model4 = [[CardSimpleModel alloc] init];
    
    model4.userPic = @"40";
    model4.userName = @"李嘉伟";
    model4.userOther = @"后端开发";
    model4.userComment = @"一楼只会给我们后端丢人，后端多好👌，hello world 万岁";
    [arrM addObject:model4];

    CardSimpleModel *model5 = model1;
    CardSimpleModel *model6 = model2;
    CardSimpleModel *model7 = model3;
    CardSimpleModel *model8 = model4;
    CardSimpleModel *model9 = model1;
    CardSimpleModel *model10 = model2;
    
    [arrM addObject:model5];
    [arrM addObject:model6];
    [arrM addObject:model7];
    [arrM addObject:model8];
    [arrM addObject:model9];
    [arrM addObject:model10];
    
    return arrM;
}


@end
