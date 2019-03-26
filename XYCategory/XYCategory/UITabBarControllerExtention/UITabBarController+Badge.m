//
//  UITabBarController+Badge.m
//  XYCategory
//
//  Created by xyzhenu on 2017/6/8.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "UITabBarController+Badge.h"

@implementation UITabBar (XYBadge)
- (void)setItemsImage:(NSArray*)images selectedImages:(NSArray*)selectedImages titles:(NSArray*)titles {
    NSArray* tabs = self.items;
    UITabBarItem* item;
    for (int i=0; i<tabs.count; i++) {
        item = tabs[i];
        item.tag = i;
        UIImage* image1 = nil;
        if ([images[i] isKindOfClass:[UIImage class]]) {
            image1 = images[i];
        }else if ([images[i] isKindOfClass:[NSString class]]){
            image1 = [UIImage imageNamed:images[i]];
        }
        item.image = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        if ([selectedImages[i] isKindOfClass:[UIImage class]]) {
            image1 = selectedImages[i];
        }else if ([selectedImages[i] isKindOfClass:[NSString class]]){
            image1 = [UIImage imageNamed:selectedImages[i]];
        }
        item.selectedImage = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        if (titles) {
            item.title = titles[i];
        }
    }
}
- (void)setTab:(NSUInteger)tabIndex badgeValue:(id)value {
    if (self.items.count < tabIndex + 1) return;
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
    self.items[tabIndex].badgeValue = badgevalue;
}
- (void)showRedDotOnIndex:(int)index{
    if (self.items.count < index + 1) return;
    //移除之前的小红点
    self.items[index].badgeValue = nil;
    [self removeRedDotOnIndex:index];
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 4;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / self.items.count;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 8, 8);
    [self addSubview:badgeView];
}

- (void)hideRedDotOnIndex:(int)index{
    if (self.items.count < index + 1) return;
    //移除小红点
    [self removeRedDotOnIndex:index];
}

- (void)removeRedDotOnIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}
@end

@implementation UITabBarController (XYBadge)
- (void)setItemsImage:(NSArray*)images selectedImages:(NSArray*)selectedImages {
    [self.tabBar setItemsImage:images selectedImages:selectedImages titles:nil];
}
- (void)setTab:(NSUInteger)tabIndex badgeValue:(id)value {
    [self.tabBar setTab:tabIndex badgeValue:value];
}
- (void)showRedDotOnIndex:(int)index {
    [self.tabBar showRedDotOnIndex:index];
}
- (void)hideRedDotOnIndex:(int)index {
    [self.tabBar hideRedDotOnIndex:index];
}
@end
