//
//  UIView+Border.h
//  XYCategories
//
//  Created by xieyan on 2017/6/3.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE;
@interface UIView (XYBorder)
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;
@property (nonatomic, strong)IBInspectable UIColor *borderColor;
@property (nonatomic, assign)IBInspectable CGFloat borderRadius;
@end
