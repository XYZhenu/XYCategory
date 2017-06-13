//
//  UIViewController+ErrorView.h
//  XYCategories
//
//  Created by xyzhenu on 2017/6/8.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN;
extern NSString * const keyErrorViewNoData;
extern NSString * const keyErrorViewNetFailure;

@interface UIViewController (XYErrorView)
//image accept image name, image fullpath string, image file url & UIImage;
+ (void(^)(UIView* view))addImage:(nullable id)image title:(nullable NSString*)title content:(nullable NSString*)content;
+ (void)registErrorViewID:(NSString*)identifier customView:(void(^)(UIView* view))buildBlock;
- (void)showErrorViewID:(NSString*)identifier;
- (void)hideErrorViewID:(NSString*)identifier;
- (void)hideErrorViewAll;
@end
NS_ASSUME_NONNULL_END;
