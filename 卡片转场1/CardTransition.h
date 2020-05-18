//
//  CardTransition.h
//  卡片转场1
//
//  Created by Mac on 2018/3/13.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

///转场动画区别
typedef NS_ENUM(NSUInteger, CardTransitionType) {
    CardTransitionPush = 1,
    CardTransitionPop  = -1,
};

@interface CardTransition : NSObject <UIViewControllerAnimatedTransitioning>

///转场动画实现方法
+ (instancetype)transitionWithType:(CardTransitionType)type;
- (instancetype)initWithTransitionType:(CardTransitionType)type;

@end
