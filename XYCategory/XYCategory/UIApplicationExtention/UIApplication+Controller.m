//
//  UIApplication+Controller.m
//  XYCategories
//
//  Created by xyzhenu on 2017/6/7.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "UIApplication+Controller.h"

@implementation UIApplication (XYController)
- (UINavigationController *)navigationController
{
    UIWindow *window = self.keyWindow;
    
    if ([window.rootViewController isKindOfClass:[UINavigationController class]])
    {
        return (UINavigationController *)window.rootViewController;
    }
    else if ([window.rootViewController isKindOfClass:[UITabBarController class]])
    {
        UIViewController *selectVc = [((UITabBarController *)window.rootViewController) selectedViewController];
        if ([selectVc isKindOfClass:[UINavigationController class]])
        {
            return (UINavigationController *)selectVc;
        }
    }
    return nil;
}
- (UIViewController *)topViewController
{
    UINavigationController *nav = [self navigationController];
    if (nav) {
        return nav.topViewController;
    }else{
        return self.keyWindow.rootViewController;
    }
}
- (void)pushViewController:(UIViewController *)viewController animate:(BOOL)animate
{
    @autoreleasepool
    {
        [[self navigationController] pushViewController:viewController animated:animate];
    }
}
- (void)pushAlert:(nullable NSString*)title info:(NSString*)info cancel:(nullable void(^)())cancel confirm:(nullable void(^)())confirm
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:info preferredStyle:UIAlertControllerStyleAlert];
    if (cancel) {
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            cancel();
        }]];
    }
    if (confirm) {
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            confirm();
        }]];
    }
    [[self topViewController] presentViewController:alert animated:YES completion:nil];
}

+ (nullable UINavigationController *)navigationController {
    return [[UIApplication sharedApplication] navigationController];
}
+ (UIViewController *)topViewController {
    return [[UIApplication sharedApplication] topViewController];
}
+ (void)pushViewController:(UIViewController *)viewController animate:(BOOL)animate {
    [[UIApplication sharedApplication] pushViewController:viewController animate:animate];
}
+ (void)pushAlert:(nullable NSString*)title info:(NSString*)info cancel:(nullable void(^)())cancel confirm:(nullable void(^)())confirm {
    [[UIApplication sharedApplication] pushAlert:title info:info cancel:cancel confirm:confirm];
}
@end
