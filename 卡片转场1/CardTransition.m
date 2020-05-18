//
//  CardTransition.m
//  卡片转场1
//
//  Created by Mac on 2018/3/13.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CardTransition.h"
#import "ViewController.h"
#import "AnotherViewController.h"
#import "CardCollectionViewCell.h"

//90 + i * 25, 141 + (ScreenHeight * (5.0 / 9))
#define AnimationDuration 0.5

@interface CardTransition () <CAAnimationDelegate>

@end

@implementation CardTransition
{
    CardTransitionType _type;
    NSMutableArray *_arrM;
}

+ (instancetype)transitionWithType:(CardTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(CardTransitionType)type{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

//动画时长设置
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return AnimationDuration;
}

//如何执行转场动画
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    switch (_type) {
        case CardTransitionPush:
            [self pushAnimation:transitionContext];
            break;
        
        case CardTransitionPop:
            [self popAnimation:transitionContext];
            break;
    }
}

//执行push动画
- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //起始页面
    ViewController *fromVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //目标页面
    AnotherViewController *toVC = (AnotherViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //拿到当前点击的cell的imageView
    CardCollectionViewCell *cell;
    NSArray<CardCollectionViewCell *> *cellArray = [fromVC.cardScrollView.collectionView visibleCells];
    for (int i = 0; i < cellArray.count; i++) {
        if (fromVC.currentIndex == cellArray[i].index) {
            cell = (CardCollectionViewCell *)cellArray[i];
        }
    }
    
    UIView *containerView = [transitionContext containerView];
    
    //图片
    UIView *imageView = [cell.coverImageView snapshotViewAfterScreenUpdates:NO];
    imageView.frame = [cell.coverImageView convertRect:cell.coverImageView.bounds toView: containerView];
    
    //titleView
    UIView *titleView = [cell.titleView snapshotViewAfterScreenUpdates:NO];
    titleView.frame = [cell.titleView convertRect:cell.titleView.bounds toView:containerView];
    
    //bgView
    UIView *bgView = [cell.bgView snapshotViewAfterScreenUpdates:NO];
    bgView.frame = [cell.bgView convertRect:cell.bgView.bounds toView:containerView];
    
    //设置动画前的各个控件的状态
    cell.coverImageView.hidden = YES;
    cell.titleView.hidden = YES;
    cell.bgView.hidden = YES;
    cell.usersView.hidden = YES;
    
    toVC.view.alpha = 0;
    toVC.topImageView.hidden = YES;
    toVC.titleView.hidden = YES;
    toVC.tableView.hidden = YES;
    
    //注意添加的层次关系
    [containerView addSubview:toVC.view];
    [containerView addSubview:bgView];
    [containerView addSubview:titleView];
    [containerView addSubview:imageView];
    
    _arrM = [toVC calculatePicCenter];
    
    [self animation:cell.usersPicCount.count];
    
    //开始做动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        //titleView frame
        CGRect titleFrame = titleView.frame;
        titleFrame.origin = [toVC.titleView convertPoint:toVC.titleView.bounds.origin toView:containerView];
        titleView.frame = titleFrame;
        //bgView
        bgView.frame = CGRectMake(toVC.tableView.frame.origin.x, toVC.tableView.frame.origin.y - 150, toVC.tableView.frame.size.width, toVC.tableView.frame.size.height + 150);
        //图片frame
        imageView.frame = [toVC.topImageView convertRect:toVC.topImageView.bounds toView:containerView];
        
        toVC.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        imageView.hidden = YES;
        toVC.topImageView.hidden = NO;
        titleView.hidden = YES;
        bgView.hidden = YES;
        toVC.titleView.hidden = NO;
        toVC.tableView.hidden = NO;
        [transitionContext completeTransition:YES];
    }];
}

//执行pop动画
- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //起始页面
    AnotherViewController *fromVC = (AnotherViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //目标页面
    ViewController *toVC = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //拿到当前点击的cell的imageView
    CardCollectionViewCell *cell;
    NSArray<CardCollectionViewCell *> *cellArray = [toVC.cardScrollView.collectionView visibleCells];
    for (int i = 0; i < cellArray.count; i++) {
        if (toVC.currentIndex == cellArray[i].index) {
            cell = (CardCollectionViewCell *)cellArray[i];
        }
    }
    
    UIView *containerView = [transitionContext containerView];
    
    //这个根据之前push时添加的顺序确定的
    //topImageView
    UIView *imageView = containerView.subviews.lastObject;
    //titleView
    UIView *titleView = containerView.subviews[2];
    //bgView
    UIView *bgView = containerView.subviews[1];
    
    //设置初始时的状态
    cell.coverImageView.hidden = YES;
    cell.titleView.hidden = YES;
    cell.usersView.hidden = NO;
    
    fromVC.topImageView.hidden = YES;
    fromVC.titleView.hidden = YES;
    imageView.hidden = NO;
    titleView.hidden = NO;
    bgView.hidden = NO;
    [containerView insertSubview:toVC.view atIndex:0];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        imageView.frame = [cell.coverImageView convertRect:cell.coverImageView.bounds toView:containerView];
        titleView.frame = [cell.titleView convertRect:cell.titleView.bounds toView:containerView];
        bgView.frame = [cell.bgView convertRect:cell.bgView.bounds toView:containerView];
        
        fromVC.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        cell.coverImageView.hidden = NO;
        cell.titleView.hidden = NO;
        cell.bgView.hidden = NO;
        [imageView removeFromSuperview];
        [titleView removeFromSuperview];
        [bgView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
}

//关键帧动画
- (void)animation:(NSInteger)count
{
    //90 + i * 25, 141 + (ScreenHeight * (5.0 / 9)) ？
    
    for (NSInteger i = 0; i < count; i++) {
        CGPoint point = CGPointMake(90 + i * 25, 141 + (ScreenHeight * (5.0 / 9)));
    
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage circleImage:[NSString stringWithFormat:@"%ld",(i + 1) * 10]]];
        imageView.frame = CGRectMake(0, 0, 30, 30);
        imageView.center = point;
    
        UIWindow *keyW = [UIApplication sharedApplication].keyWindow;
        [keyW addSubview:imageView];
    
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:point];
    
        CGPoint endP = CGPointFromString(_arrM[i]);
        [path addLineToPoint:endP];
    
        anim.path = path.CGPath;
        anim.duration = AnimationDuration;
        anim.delegate = self;
    
        imageView.center = endP;
    
        [anim setValue:imageView forKey:@"LL"];
    
        [imageView.layer addAnimation:anim forKey:nil];
    }
}

//动画停止的代理
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //从anim中取出图片，移除
    UIImageView *imgV = [anim valueForKey:@"LL"];
    [imgV removeFromSuperview];
}

@end






