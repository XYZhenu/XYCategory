//
//  UIApplication+OpenUrl.h
//  XYCategory
//
//  Created by xyzhenu on 2017/6/8.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN;
@interface UIApplication (XYOpenUrl)
- (void)registOpenUrlHandler:(BOOL(^)(NSURL * url))handler;
@end
NS_ASSUME_NONNULL_END;
