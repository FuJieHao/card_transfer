//
//  ViewController.m
//  卡片转场1
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "AnotherViewController.h"

@interface ViewController () <CardScrollViewDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    self.cardScrollView = [[CardScrollView alloc] initWithFrame:self.view.bounds];
    self.cardScrollView.delegate = self;
    [self.view addSubview:self.cardScrollView];
}

- (void)cardScrollViewDelegateDidSelectAtIndex:(NSInteger)index
{
    self.currentIndex = index;
    
    AnotherViewController *vc = [[AnotherViewController alloc] init];
    vc.index = index;
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
