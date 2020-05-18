//
//  UIImage+CircleExtension.m
//  卡片转场1
//
//  Created by Mac on 2018/3/12.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "UIImage+CircleExtension.h"

@implementation UIImage (CircleExtension)

- (instancetype)circleImage
{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)circleImage:(NSString *)image
{
    return [[self imageNamed:image] circleImage];
}

@end
