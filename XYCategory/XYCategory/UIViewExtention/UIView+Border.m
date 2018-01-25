//
//  UIView+Border.m
//  XYCategory
//
//  Created by xieyan on 2017/6/3.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (XYBorder)
- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
    if (borderWidth>0) self.layer.masksToBounds = YES;
}
-(CGFloat)borderWidth {
    return self.layer.borderWidth;
}
- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}
-(UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
- (void)setBorderRadius:(CGFloat)borderRadius {
    self.layer.cornerRadius = borderRadius;
    if (borderRadius>0) self.layer.masksToBounds = YES;
}
-(CGFloat)borderRadius {
    return self.layer.cornerRadius;
}
@end
