//
//  UIViewController+Bar.h
//  XYCategories
//
//  Created by xieyan on 2017/6/3.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN;
@interface UIViewController (XYBar)
- (void)setBarColor:(UIColor*)color;
- (void)addReturnButton:(nullable id)content;
- (nullable UIButton*)addLeftBar:(id)content sel:(SEL)sel;
- (nullable UIButton*)addRightBar:(id)content sel:(SEL)sel;
@end
NS_ASSUME_NONNULL_END;
