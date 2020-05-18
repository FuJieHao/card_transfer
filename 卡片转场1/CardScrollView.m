//
//  CardScrollView.m
//  卡片转场1
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CardScrollView.h"
#import "CardModel.h"
#import "CardCollectionViewCell.h"
#import "CardFlowLayout.h"

#define CellId @"CellId"

typedef enum : NSInteger {
    Up = 1,
    Down = -1,
} Direction;

@interface CardScrollView() <UICollectionViewDataSource, UICollectionViewDelegate>

///背景毛玻璃图片
@property (nonatomic, strong) UIImageView *BgView;

///模型数组
@property (nonatomic, strong) NSArray <CardModel *> *imageArray;

///上滑手势
@property (nonatomic, strong) UISwipeGestureRecognizer *up;

///下滑手势
@property (nonatomic, strong) UISwipeGestureRecognizer *down;

@end

@implementation CardScrollView
{
    CGFloat     _startDragX;        //开始移动的位置
    CGFloat     _endDragX;          //停止移动的位置
    CGFloat     _dragMiniDistance;  //最小移动的临界值
    NSInteger   _currentIndex;      //当前切换到的卡片索引位置
    NSInteger   _maxIndex;          //最大的索引位置
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.imageArray = [CardModel cardModel];
        [self setupUI];
        _dragMiniDistance = self.collectionView.bounds.size.width / 20;
        _maxIndex = self.imageArray.count - 1;
    }
    return self;
}

- (void)setupUI
{
    //初始化背景图并附加毛玻璃效果
    self.BgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.imageArray[0].cardPicName]];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.BgView.bounds;
    [self.BgView addSubview:effectView];
    
    //初始化collectionView
    CardFlowLayout *layout = [[CardFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    self.collectionView.backgroundView = self.BgView;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[CardCollectionViewCell class] forCellWithReuseIdentifier:CellId];
    
    //隐藏滚动条
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:self.collectionView];
    
    //添加手势方法
    [self addGesture];
}

#pragma mark - collectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellId forIndexPath:indexPath];
    [cell loadData:self.imageArray[indexPath.row].cardPicName];
    
    cell.index = indexPath.row;

    cell.tapCoverImageBlock = ^(NSInteger index) {
        if ([self.delegate respondsToSelector:@selector(cardScrollViewDelegateDidSelectAtIndex:)]) {
            [self.delegate cardScrollViewDelegateDidSelectAtIndex:index];
        }
    };
    
    return cell;
}

#pragma mark - scrollView delegate
/**
 修正cell居中
 */

//开始拖拽collectionView(scrollView的子类）
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"开始拖动%f",scrollView.contentOffset.x);
    _startDragX = scrollView.contentOffset.x;
}

//停止拖拽collectionView
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSLog(@"停止拖动%f",scrollView.contentOffset.x);
    _endDragX = scrollView.contentOffset.x;
    
    CGFloat delta = _startDragX - _endDragX;
    
    if (delta >= _dragMiniDistance) {
        //向右滑动
        _currentIndex -= 1;
        
    } else if (delta * -1 >= _dragMiniDistance) {
        //向左滑动
        _currentIndex += 1;
    }
    
    _currentIndex = _currentIndex <= 0 ? 0 : _currentIndex;
    _currentIndex = _currentIndex >= _maxIndex ? _maxIndex : _currentIndex;
    
    //等候数据源方法确定，所以用主队列异步
    dispatch_async(dispatch_get_main_queue(), ^{
    
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    });
    
    self.BgView.image = [UIImage imageNamed:self.imageArray[_currentIndex].cardPicName];
}

#pragma mark - SwipeGestureRecognizer
- (void)addGesture
{
    //上滑
    self.up = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
    self.up.direction = UISwipeGestureRecognizerDirectionUp;
    [self.collectionView addGestureRecognizer:self.up];
    
    //下滑
    self.down = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    self.down.direction = UISwipeGestureRecognizerDirectionDown;
    
    //这里先不添加下滑手势，避免在没展开的时候，同时存在两种手势（只有在上滑以后，才会有下滑手势）
}

- (void)swipeUp:(UISwipeGestureRecognizer *)swipeRecognizer
{
    [self setSwip:swipeRecognizer andDrection:Up];
}

- (void)swipeDown:(UISwipeGestureRecognizer *)swipeRecognizer
{
    [self setSwip:swipeRecognizer andDrection:Down];
}

- (void)setSwip:(UISwipeGestureRecognizer *)swipeRecognizer andDrection:(Direction)direction
{
    //得到point.x位置，用以确定item是第几个
    CGPoint location = [swipeRecognizer locationInView:self.collectionView];
    NSIndexPath *indexpath = [self.collectionView indexPathForItemAtPoint:location];
    //NSLog(@"indexpath.row : %ld",(long)indexpath.row);
    
    //得到对应的cell
    CardCollectionViewCell *swipeCell = (CardCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexpath];
    
    if (direction == Up) {
        //返回cell在目标视图（collectionView）中的位置
        CGRect rect = [self.collectionView convertRect:swipeCell.frame toView:self.collectionView];
        
        //手势没在cell范围上（通过打印发现没在位置的时候，size 和 origin 都是 0
        //NSLog(@"size:{%f  %f} origin:{%f  %f}",rect.size.width, rect.size.height, rect.origin.x, rect.origin.y);
        if (rect.origin.x == 0 && rect.origin.y == 0) {
            return;
        }
        
        //没有在当前手势上
        if (indexpath.row != _currentIndex) {
            return;
        }
    }
    
    //执行UIView动画
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //coverImage
        CGRect coverFrame = swipeCell.coverImageView.frame;
        coverFrame.origin.y -= 100 * direction;
        swipeCell.coverImageView.frame = coverFrame;
        
        //bgView
        CGRect bgFrame = swipeCell.bgView.frame;
        bgFrame.size = CGSizeMake(swipeCell.bgView.frame.size.width + 30 * direction, swipeCell.bgView.frame.size.height + 20 * direction);
        bgFrame.origin.x -= 15 * direction;
        swipeCell.bgView.frame = bgFrame;
        swipeCell.bgView.alpha = direction < 0 ? 0.0 : 1.0;
        
        //titleView
        CGRect titleFrame = swipeCell.titleView.frame;
        titleFrame.size = CGSizeMake(swipeCell.titleView.frame.size.width + 30 * direction, swipeCell.titleView.frame.size.height);
        titleFrame.origin.x -= 15 * direction;
        swipeCell.titleView.frame = titleFrame;
        
    } completion:^(BOOL finished) {
        self.collectionView.scrollEnabled = direction > 0 ? NO : YES;
        swipeCell.coverImageView.userInteractionEnabled = direction > 0 ? YES : NO;
        
        if (direction == Up) {
            [self.collectionView removeGestureRecognizer:self.up];
            [swipeCell addGestureRecognizer:self.down];
        } else {
            [self.collectionView addGestureRecognizer:self.up];
            [swipeCell removeGestureRecognizer:self.down];
        }
    }];
    
}

@end










