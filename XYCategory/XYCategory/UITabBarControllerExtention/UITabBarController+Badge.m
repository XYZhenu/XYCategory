//
//  UITabBarController+Badge.m
//  XYCategories
//
//  Created by xyzhenu on 2017/6/8.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "UITabBarController+Badge.h"

@implementation UITabBarController (XYBadge)
- (void)setTab:(NSUInteger)tabIndex badgeValue:(id)value {
    if (self.tabBar.items.count < tabIndex + 1) return;
    NSString* badgevalue = nil;
    if ([value isKindOfClass:[NSString class]]) {
        
        NSString *pattern = @"/^[0-9]*$/";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
        if ([pred evaluateWithObject:value]) {
            NSUInteger num = [value integerValue];
            if (num > 99) {
                badgevalue = @"99*";
            }else if (num > 0){
                badgevalue = @(num).stringValue;
            }
        }else{
            badgevalue = value;
        }
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSUInteger num = [value integerValue];
        if (num > 99) {
            badgevalue = @"99*";
        }else if (num > 0){
            badgevalue = @(num).stringValue;
        }
    }
    self.tabBar.items[tabIndex].badgeValue = badgevalue;
}
- (void)showRedDotOnIndex:(int)index{
    if (self.tabBar.items.count < index + 1) return;
    //移除之前的小红点
    self.tabBar.items[index].badgeValue = nil;
    [self removeRedDotOnIndex:index];
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 4;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.tabBar.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / self.tabBar.items.count;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 8, 8);
    [self.tabBar addSubview:badgeView];
}

- (void)hideRedDotOnIndex:(int)index{
    if (self.tabBar.items.count < index + 1) return;
    //移除小红点
    [self removeRedDotOnIndex:index];
}

- (void)removeRedDotOnIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.tabBar.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}
@end
