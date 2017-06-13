//
//  UITabBarController+Badge.h
//  XYCategories
//
//  Created by xyzhenu on 2017/6/8.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (XYBadge)
- (void)setTab:(NSUInteger)tabIndex badgeValue:(id)value;
- (void)showRedDotOnIndex:(int)index;   //显示小红点
- (void)hideRedDotOnIndex:(int)index; //隐藏小红点
@end
