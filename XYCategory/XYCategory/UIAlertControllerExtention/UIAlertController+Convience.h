//
//  UIAlertController+Convience.h
//  Video
//
//  Created by xieyan on 2017/2/5.
//  Copyright © 2017年 Video. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN;
@interface UIAlertController (XYConvience)
- (UIAlertAction *)actionTitle:(nullable NSString *)title style:(UIAlertActionStyle)style handler:(nullable void (^)( UIAlertAction * action))handler;
@end

@interface UIViewController (XYAlert)
- (UIAlertController *)alertMsg:(nullable NSString *)msg cancel:(nullable void(^)())cancel;
- (UIAlertController *)alertMsg:(nullable NSString *)msg confirm:(nullable void(^)())confirm;
- (UIAlertController *)alertMsg:(nullable NSString *)msg cancel:(nullable void(^)())cancel confirm:(nullable void(^)())confirm;

@end

@interface UIViewController (XYSheet)
- (UIAlertController *)sheetMsg:(nullable id)msg title:(nullable NSString *)title cancel:(nullable void(^)())cancel confirm:(nullable void(^)(NSInteger index))confirm;

@end
NS_ASSUME_NONNULL_END;
