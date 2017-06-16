//
//  UIView+Separator.h
//  XYCategories
//
//  Created by xieyan on 2017/6/3.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
extern NSString* const keySepatorColor;
@interface UIView (XYSeparator)
@property (nonatomic, assign)IBInspectable BOOL topSep;
@property (nonatomic, assign)IBInspectable CGFloat tsTop;
@property (nonatomic, assign)IBInspectable CGFloat tsLeft;
@property (nonatomic, assign)IBInspectable CGFloat tsRight;
@property (nonatomic, assign)IBInspectable BOOL bottomSep;
@property (nonatomic, assign)IBInspectable CGFloat bsBottom;
@property (nonatomic, assign)IBInspectable CGFloat bsLeft;
@property (nonatomic, assign)IBInspectable CGFloat bsRight;
@property (nonatomic, strong)IBInspectable UIColor *sepColor;
@end
NS_ASSUME_NONNULL_END
