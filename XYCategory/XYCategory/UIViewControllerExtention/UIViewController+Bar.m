//
//  UIViewController+Bar.m
//  XYCategory
//
//  Created by xieyan on 2017/6/3.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "UIViewController+Bar.h"
#import "UIColor+XYKey.h"
@interface _xycontrollerbarextention : NSObject @end
@implementation _xycontrollerbarextention @end

@implementation UIViewController (XYBar)
- (void)setBarColor:(UIColor*)color {
    if (!color) color = [UIColor colorForKey:keyColorTheme];
    [self.navigationController.navigationBar setBackgroundImage:[self xyimageWithColor:color] forBarMetrics:UIBarMetricsDefault];
}
- (UIImage *)xyimageWithColor:(UIColor *)color
{
    if (color == nil) {
        return nil;
    }
    CGRect rect=CGRectMake(0.0f, 0.0f, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
- (void)addReturnButton:(id _Nullable)content {
    if (!self.navigationController || self.navigationController.viewControllers.firstObject == self) {
        return;
    }
    UIImage* image = nil;
    if ([content isKindOfClass:[NSString class]]) {
        image = [UIImage imageNamed:content];
    }else if ([content isKindOfClass:[UIImage class]]){
        image = content;
    }
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (!image) {
         NSString* path = [[[[NSBundle bundleForClass:[_xycontrollerbarextention class]] resourcePath]
         stringByAppendingPathComponent:@"XYCategory.bundle"]stringByAppendingPathComponent:[NSString
         stringWithFormat:@"%@.png",@"return"]];
        image = [UIImage imageWithContentsOfFile:path];
    }
    [btn setImage:image forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn addConstraints:@[[NSLayoutConstraint constraintWithItem:btn attribute:(NSLayoutAttributeWidth) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1 constant:40],[NSLayoutConstraint constraintWithItem:btn attribute:(NSLayoutAttributeHeight) relatedBy:(NSLayoutRelationEqual) toItem:nil attribute:(NSLayoutAttributeNotAnAttribute) multiplier:1 constant:40]]];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
    [btn addTarget:self action:@selector(xybarpop) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}
- (void)xybarpop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton*)addLeftBar:(id)content sel:(SEL)sel {
    return [self addBar:content sel:sel left:YES];
}
- (UIButton*)addRightBar:(id)content sel:(SEL)sel {
    return [self addBar:content sel:sel left:NO];
}
- (UIButton*)addBar:(id)content sel:(SEL)sel left:(BOOL)isLeft{
    UIImage* image = nil;
    NSString* title = nil;
    if ([content isKindOfClass:[NSString class]]) {
        image = [UIImage imageNamed:content];
        if (!image) {
            title = content;
        }
    }else if ([content isKindOfClass:[UIImage class]]){
        image = content;
    }
    if (!image && !title) return nil;
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image) {
        [btn setImage:image forState:UIControlStateNormal];
    }else{
        [btn setTitle:title forState:UIControlStateNormal];
    }
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    NSArray* barbuttonItems = isLeft ? self.navigationItem.leftBarButtonItems : self.navigationItem.rightBarButtonItems;
    if (barbuttonItems) {
        NSMutableArray* items = barbuttonItems.mutableCopy;
        [items addObject:[[UIBarButtonItem alloc] initWithCustomView:btn]];
        isLeft ? (self.navigationItem.leftBarButtonItems = items) : (self.navigationItem.rightBarButtonItems = items);
    }else{
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        isLeft ? (self.navigationItem.leftBarButtonItem = item) : (self.navigationItem.rightBarButtonItem = item);
    }
    return btn;
}
@end
