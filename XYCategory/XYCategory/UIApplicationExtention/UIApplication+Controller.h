//
//  UIApplication+Controller.h
//  XYCategory
//
//  Created by xyzhenu on 2017/6/7.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN;
@interface UIApplication (XYController)
- (nullable UINavigationController *)navigationController;
- (UIViewController *)topViewController;
- (void)pushViewController:(UIViewController *)viewController animate:(BOOL)animate;
- (void)pushAlert:(nullable NSString*)title info:(NSString*)info cancel:(nullable void(^)(void))cancel confirm:(nullable void(^)(void))confirm;
+ (nullable UINavigationController *)navigationController;
+ (UIViewController *)topViewController;
+ (void)pushViewController:(UIViewController *)viewController animate:(BOOL)animate;
+ (void)pushAlert:(nullable NSString*)title info:(NSString*)info cancel:(nullable void(^)(void))cancel confirm:(nullable void(^)(void))confirm;
@end
NS_ASSUME_NONNULL_END;
