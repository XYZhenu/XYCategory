//
//  UIView+Layout.m
//  Video
//
//  Created by xieyan on 2017/2/3.
//  Copyright © 2017年 Video. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (XYLayout)
- (CGFloat)autoLayoutHeightForWidth:(CGFloat)width{
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
    [self addConstraint:widthFenceConstraint];
    CGFloat height = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    [self removeConstraint:widthFenceConstraint];
    return height+1;
}
@end
