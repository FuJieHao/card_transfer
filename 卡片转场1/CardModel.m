//
//  CardModel.m
//  卡片转场1
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CardModel.h"

@interface CardModel()

@end

@implementation CardModel

+ (NSArray <CardModel *> *)cardModel {
 
    NSMutableArray *arrM = [NSMutableArray array];
    
    for (NSInteger i = 1; i <= 6; i++) {
        
        CardModel *model = [[CardModel alloc] init];
        model.cardPicName = [NSString stringWithFormat:@"%ld",(long)i];
        [arrM addObject:model];
    }
    
    return arrM.copy;
}

@end
