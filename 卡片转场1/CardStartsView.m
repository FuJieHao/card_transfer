//
//  CardStartsView.m
//  卡片转场1
//
//  Created by Mac on 2018/3/12.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CardStartsView.h"

#define StartCount 5

@implementation CardStartsView

- (instancetype)init
{
    if (self = [super init]) {
        
        //沿轴线进行布局（center to center)
        self.distribution = UIStackViewDistributionEqualCentering;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.distribution = UIStackViewDistributionEqualCentering;
    }
    return self;
}

- (void)setLevel:(CGFloat)level
{
    NSInteger startCount = (NSInteger)level;
    
    //满星
    for (NSInteger i = 0; i < startCount; i++) {
        [self createStartWithImageName:@"comtent_star_icon" startPosition:i];
    }
    //半星
    if (level - startCount) {
        [self createStartWithImageName:@"yiban_star_icon" startPosition:startCount];
        startCount++;
    }
    for (NSInteger i = startCount; i < StartCount; i++) {
        [self createStartWithImageName:@"comtent_star_icon nal" startPosition:i];
    }
    
    _level = level;
}

- (void)createStartWithImageName:(NSString *)imageName startPosition:(NSInteger)position
{
    UIImageView *imageView = nil;
    if (self.subviews.count == StartCount) {
        imageView = self.subviews[position];
        imageView.image = [UIImage imageNamed:imageName];
        return;
    }
    
    imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:imageName];
    [self addArrangedSubview:imageView];
}

@end








