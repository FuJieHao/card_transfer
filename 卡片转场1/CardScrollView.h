//
//  CardScrollView.h
//  卡片转场1
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardScrollViewDelegate <NSObject>

- (void)cardScrollViewDelegateDidSelectAtIndex:(NSInteger)index;

@end

@interface CardScrollView : UIView

@property (nonatomic, weak) id<CardScrollViewDelegate> delegate;

///collectionView视图
@property (nonatomic, strong) UICollectionView *collectionView;

@end
