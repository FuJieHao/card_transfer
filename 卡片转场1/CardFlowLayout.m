//
//  CardFlowLayout.m
//  卡片转场1
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CardFlowLayout.h"

#define ItemHeight (ScreenHeight * (5.0 / 9))
#define ItemWidth (ScreenWidth * (3.0 / 5))

@implementation CardFlowLayout

- (instancetype)init
{
    if (self = [super init]) {
        
        self.itemSize = CGSizeMake(ItemWidth, ItemHeight);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;   //水平方向
        self.sectionInset = UIEdgeInsetsMake(0, ScreenWidth/2 - ItemWidth/2, 0, ScreenWidth/2 - ItemWidth/2);   //设置组边距
        
        self.minimumLineSpacing = (ScreenWidth - ItemWidth)/4;
    }
    
    return self;
}

//Implement -layoutAttributesForElementsInRect:
//to return layout attributes for for supplementary or decoration views, or to perform layout in an as-needed-on-screen fashion.
//返回 追加的 或者 装饰视图 布局属性 或者去适应屏幕上的布局
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //这样就拿到了所有的布局属性
    //[super layoutAttributesForElementsInRect:rect].copy;
    NSArray<UICollectionViewLayoutAttributes *> *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];

    //这样就通过遍历每个属性对其进行修改来达到预期的效果
    
    //获取屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width / 2.0;
    //拿到每个属性
    for (UICollectionViewLayoutAttributes *attr in arr) {
       
        //布局属性与中线的距离
        CGFloat distance = fabs(attr.center.x - centerX);
        //距离与屏幕宽的比例（为了计算缩放的比例）
        CGFloat disScale = distance / self.collectionView.bounds.size.width;
        //确定缩放的大小
        CGFloat scale = fabs(cos(disScale * M_PI / 4));
        
        //对布局属性进行缩放变换
        attr.transform = CGAffineTransformMakeScale(1.0, scale);
        
        //同时也利用这个比例对透明度进行一下更改，显得自然
        attr.alpha = scale;
    
    }
    
    return arr;
}

// Additionally, all layout subclasses should implement -layoutAttributesForItemAtIndexPath: to return layout attributes instances on demand for specific index paths.
//此外所有的布局子类（item）应该实现方法 layoutAttributesForItemAtIndexPath ：对于确定的（indexpath确定）返回布局属性实例
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}

- (NSArray<UICollectionViewLayoutAttributes *> *)getCopyOfAttributes:(NSArray *)attributes {
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}


// return YES to cause the collection view to requery the layout for geometry information
//判定为布局需要被无效化并重新计算的时候,布局对象会被询问以提供新的布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

@end
