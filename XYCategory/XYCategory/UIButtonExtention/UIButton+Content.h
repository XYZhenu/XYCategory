//
//  UIButton+Content.h
//  XYCategories
//
//  Created by xieyan on 2017/6/4.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE;
@interface UIButton (XYContent)
@property (nonatomic, assign)IBInspectable BOOL centerVertical;
@property (nonatomic, assign)IBInspectable CGFloat centerSpacing;
@end
