//
//  UIViewController+ErrorView.m
//  XYCategory
//
//  Created by xyzhenu on 2017/6/8.
//  Copyright © 2017年 xieyan. All rights reserved.
//
#import "UIViewController+ErrorView.h"
#import <objc/runtime.h>
NSString * const keyErrorViewNoData = @"emptylist";
NSString * const keyErrorViewNetFailure = @"networkfailed";
@interface _xycontrollererrorviewextention : NSObject @end
@implementation _xycontrollererrorviewextention @end
@implementation UIViewController (XYErrorView)
static char errorViewDicKey;
-(NSMutableDictionary*)errorviewsDic{
    NSMutableDictionary* dic = objc_getAssociatedObject(self, &errorViewDicKey);
    if (!dic) {
        dic = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &errorViewDicKey, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dic;
}

static NSMutableDictionary* errorviewsBlockDic = nil;
+ (void(^)(UIView* view))addImage:(id)image title:(NSString*)title content:(NSString*)content {
    return ^(UIView* view){
        UIView* lastView = view;
        if (image) {
            UIImage* pic = nil;
            if ([image isKindOfClass:[UIImage class]]) {
                pic = image;
            }else if ([image isKindOfClass:[NSURL class]]){
                pic = [UIImage imageWithContentsOfFile:((NSURL*)image).absoluteString];
            }else if ([image isKindOfClass:[NSString class]]){
                if ([image componentsSeparatedByString:@"/"].count > 1) {
                    pic = [UIImage imageWithContentsOfFile:image];
                }else{
                    pic = [UIImage imageNamed:image];
                }
            }
            if (pic) {
                UIImageView* imageview = [[UIImageView alloc] initWithImage:pic];
                imageview.translatesAutoresizingMaskIntoConstraints = NO;
                [view addSubview:imageview];
                [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:imageview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
                [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[imageview]-(>=0)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(imageview)]];
                [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageview]-(>=0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageview)]];
                lastView = imageview;
            }
        }
        if (title) {
            UILabel* label1 = [[UILabel alloc] init];
            label1.font = [UIFont systemFontOfSize:14];
            label1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.text = title;
            [view addSubview:label1];
            label1.translatesAutoresizingMaskIntoConstraints = NO;
            [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:label1 attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
            [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[label1]-(>=0)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(label1)]];
            [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastView]-20-[label1]-(>=0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label1,lastView)]];
            lastView = label1;
        }
        if (content) {
            UILabel* label1 = [[UILabel alloc] init];
            label1.font = [UIFont systemFontOfSize:12];
            label1.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.text = content;
            [view addSubview:label1];
            label1.translatesAutoresizingMaskIntoConstraints = NO;
            [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:label1 attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
            [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=0)-[label1]-(>=0)-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(label1)]];
            [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lastView]-10-[label1]-(>=0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label1,lastView)]];
        }
    };
}
+ (UIImage*)imageName:(NSString*)name {
    UIImage* image = [UIImage imageNamed:name];
    if (image) return image;
    NSString* path = [[[[NSBundle bundleForClass:[_xycontrollererrorviewextention class]] resourcePath] stringByAppendingPathComponent:@"XYCategory.bundle"]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",name]];
    return [UIImage imageWithContentsOfFile:path];
}
+(void)load {
    errorviewsBlockDic = [NSMutableDictionary dictionary];
    id block = [UIViewController addImage:[self imageName:@"networkfailed"] title:@"网络链接失败" content:@"请检查您的网络"];
    [errorviewsBlockDic setValue:block forKey:keyErrorViewNetFailure];
    block = [UIViewController addImage:[self imageName:@"emptylist"] title:@"还没有任何数据" content:nil];
    [errorviewsBlockDic setValue:block forKey:keyErrorViewNoData];
}
+ (void)registErrorViewID:(NSString*)identifier customView:(void(^)(UIView* view))buildBlock {
    [errorviewsBlockDic setValue:buildBlock forKey:identifier];
}
- (UIView*)showErrorViewID:(NSString*)identifier {
    void(^block)(UIView* view) = errorviewsBlockDic[identifier];
    if (!block) return nil;
    UIView* view = nil;
    BOOL isNewView = YES;
    if ([self errorviewsDic][identifier]) {
        isNewView = NO;
        view = [self errorviewsDic][identifier];
        [view removeFromSuperview];
    }else{
        view = [UIView new];
        [[self errorviewsDic] setValue:view forKey:identifier];
    }
    [self.view addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.backgroundColor = [UIColor clearColor];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:60]];
    if (isNewView) block(view);
    return view;
}
- (void)hideErrorViewID:(NSString*)identifier {
    UIView* errorView = [self errorviewsDic][identifier];
    [errorView removeFromSuperview];
    [[self errorviewsDic] removeObjectForKey:identifier];
}
- (void)hideErrorViewAll {
    for (NSString* key in [self errorviewsDic]) {
        [((UIView*)[[self errorviewsDic] objectForKey:key]) removeFromSuperview];
    }
    [[self errorviewsDic] removeAllObjects];
}
@end

