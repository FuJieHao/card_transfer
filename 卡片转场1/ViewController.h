//
//  ViewController.h
//  卡片转场1
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardScrollView.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) CardScrollView *cardScrollView;

//记录当前点击的IndexPath
@property (nonatomic, assign) NSInteger currentIndex;

@end

