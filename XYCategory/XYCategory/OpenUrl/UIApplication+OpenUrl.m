//
//  UIApplication+OpenUrl.m
//  XYCategories
//
//  Created by xyzhenu on 2017/6/8.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "UIApplication+OpenUrl.h"
static NSMutableArray* openurlHandlerArray = nil;
@implementation UIApplication (XYOpenUrl)
- (void)registOpenUrlHandler:(BOOL(^)(NSURL *))handler {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        openurlHandlerArray = [NSMutableArray array];
    });
    [openurlHandlerArray addObject:handler];
}
- (BOOL)processOpenUrl:(NSURL*)url sourceBundleID:(NSString *)sourceBundleID annotation:(id)annotation fileNeedCopy:(BOOL)needCopy{
    for (BOOL(^block)(NSURL *) in openurlHandlerArray) {
        if (block(url)) {
            return YES;
        }
    }
    return NO;
}
@end
@interface UIResponder (XYOpenUrl)

@end
@implementation UIResponder (XYOpenUrl)

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [application processOpenUrl:url sourceBundleID:nil annotation:nil fileNeedCopy:NO];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    return [application processOpenUrl:url sourceBundleID:sourceApplication annotation:annotation fileNeedCopy:NO];
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    return [app processOpenUrl:url sourceBundleID:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey] fileNeedCopy:[options[UIApplicationOpenURLOptionsOpenInPlaceKey] boolValue]];
}
@end
