//
//  UIView+Separator.m
//  XYCategories
//
//  Created by xieyan on 2017/6/3.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "UIView+Separator.h"
#import <objc/runtime.h>
#define XYSepKey(_C_) static char kSeparator##_C_##Key
#define XYSepSET(_O_,_K_) objc_setAssociatedObject(self, &_K_, _O_, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
#define XYSepGET(_K_) objc_getAssociatedObject(self, &_K_)
@interface UIView (xyseparator)
@property (nonatomic, strong, readonly) UIView * _Nonnull topSeparatorLineView;
@property (nonatomic, strong, readonly) UIView * _Nonnull bottomSeparatorLineView;
@end
@implementation UIView (xyseparator)
XYSepKey(TopView);
- (void)setTopSeparatorLineView:(UIView *)topSeparatorLineView {
    XYSepSET(topSeparatorLineView, kSeparatorTopViewKey);
}
- (UIView *)topSeparatorLineView {
    return XYSepGET(kSeparatorTopViewKey);
}

XYSepKey(BottomView);
- (void)setBottomSeparatorLineView:(UIView *)bottomSeparatorLineView {
    XYSepSET(bottomSeparatorLineView, kSeparatorBottomViewKey);
}
- (UIView *)bottomSeparatorLineView {
    return XYSepGET(kSeparatorBottomViewKey);
}

@end

#define XYSepSETFloat(_E_,_K_) objc_setAssociatedObject(self, &_K_, @(_K_), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
#define XYSepGETFloat(_K_) ((NSNumber*)objc_getAssociatedObject(self, &_K_))
static float separatorWidth = 0.5;
@implementation UIView (XYSeparator)
-(NSLayoutConstraint*)constraintTo:(UIView*)view attribute:(NSLayoutAttribute)att constant:(CGFloat)c {
    return [NSLayoutConstraint constraintWithItem:self attribute:att relatedBy:NSLayoutRelationEqual toItem:view attribute:att multiplier:1 constant:c];
}
-(NSLayoutConstraint*)constraintHeight:(CGFloat)c {
    return [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:c];
}
-(void)constrainUpdateAttribute:(NSLayoutAttribute)att constant:(CGFloat)c {
    for (NSLayoutConstraint* con in self.superview.constraints) {
        if (con.secondAttribute == att && con.secondItem == self) {
            con.constant = c;
            break;
        }
    }
}

XYSepKey(Color);
-(void)setSepColor:(UIColor *)sepColor {
    XYSepSET(sepColor, kSeparatorColorKey);
    self.topSeparatorLineView.backgroundColor = sepColor;
    self.bottomSeparatorLineView.backgroundColor = sepColor;
}
-(UIColor *)sepColor{
    UIColor * color = XYSepGET(kSeparatorColorKey);
    if (!color) {
        color = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    }
    return color;
}

#pragma mark - top separator
- (void)setTopSep:(BOOL)topSep {
    if (topSep) {
        if (!self.topSeparatorLineView) {
            self.topSeparatorLineView = [[UIView alloc] init];
            self.topSeparatorLineView.backgroundColor = self.sepColor;
            self.topSeparatorLineView.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:self.topSeparatorLineView];
            NSMutableArray* arr = @[].mutableCopy;
            [arr addObject:[self constraintTo:self.topSeparatorLineView attribute:NSLayoutAttributeTop constant:-self.tsTop]];
            [arr addObject:[self constraintTo:self.topSeparatorLineView attribute:NSLayoutAttributeLeft constant:-self.tsLeft]];
            [arr addObject:[self constraintTo:self.topSeparatorLineView attribute:NSLayoutAttributeRight constant:self.tsRight]];
            [self addConstraints:arr];
            [self.topSeparatorLineView addConstraint:[self.topSeparatorLineView constraintHeight:separatorWidth]];

        }else{
            [self.topSeparatorLineView constrainUpdateAttribute:NSLayoutAttributeTop constant:-self.tsTop];
            [self.topSeparatorLineView constrainUpdateAttribute:NSLayoutAttributeLeft constant:-self.tsLeft];
            [self.topSeparatorLineView constrainUpdateAttribute:NSLayoutAttributeRight constant:self.tsRight];
        }
        [self bringSubviewToFront:self.topSeparatorLineView];
    }else{
        [self.topSeparatorLineView removeFromSuperview];
        self.topSeparatorLineView = nil;
    }
}
- (BOOL)topSep {
    return self.topSeparatorLineView == nil;
}

XYSepKey(TopSepTop);
-(void)setTsTop:(CGFloat)tsTop{
    XYSepSETFloat(tsTop, kSeparatorTopSepTopKey);
    [self.topSeparatorLineView constrainUpdateAttribute:NSLayoutAttributeTop constant:-tsTop];
}
-(CGFloat)tsTop {
    NSNumber* num = XYSepGET(kSeparatorTopSepTopKey);
    return num ? num.doubleValue : 0;
}

XYSepKey(TopSepLeft);
-(void)setTsLeft:(CGFloat)tsLeft{
    XYSepSETFloat(tsLeft, kSeparatorTopSepLeftKey);
    [self.topSeparatorLineView constrainUpdateAttribute:NSLayoutAttributeLeft constant:-tsLeft];
}
-(CGFloat)tsLeft {
    NSNumber* num = XYSepGET(kSeparatorTopSepLeftKey);
    return num ? num.doubleValue : 0;
}

XYSepKey(TopSepRight);
-(void)setTsRight:(CGFloat)tsRight{
    XYSepSETFloat(tsRight, kSeparatorTopSepRightKey);
    [self.topSeparatorLineView constrainUpdateAttribute:NSLayoutAttributeRight constant:tsRight];
}
-(CGFloat)tsRight {
    NSNumber* num = XYSepGET(kSeparatorTopSepRightKey);
    return num ? num.doubleValue : 0;
}

#pragma mark - bottom separator
- (void)setBottomSep:(BOOL)bottomSep {
    if (bottomSep) {
        if (!self.bottomSeparatorLineView) {
            self.bottomSeparatorLineView = [[UIView alloc] init];
            self.bottomSeparatorLineView.backgroundColor = self.sepColor;
            self.bottomSeparatorLineView.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:self.bottomSeparatorLineView];
            NSMutableArray* arr = @[].mutableCopy;
            [arr addObject:[self constraintTo:self.bottomSeparatorLineView attribute:NSLayoutAttributeBottom constant:self.bsBottom]];
            [arr addObject:[self constraintTo:self.bottomSeparatorLineView attribute:NSLayoutAttributeLeft constant:-self.bsLeft]];
            [arr addObject:[self constraintTo:self.bottomSeparatorLineView attribute:NSLayoutAttributeRight constant:self.bsRight]];
            [self addConstraints:arr];
            [self.bottomSeparatorLineView addConstraint:[self.bottomSeparatorLineView constraintHeight:separatorWidth]];
        }else{
            [self.bottomSeparatorLineView constrainUpdateAttribute:NSLayoutAttributeBottom constant:self.bsBottom];
            [self.bottomSeparatorLineView constrainUpdateAttribute:NSLayoutAttributeLeft constant:-self.bsLeft];
            [self.bottomSeparatorLineView constrainUpdateAttribute:NSLayoutAttributeRight constant:self.bsRight];
        }
        [self bringSubviewToFront:self.bottomSeparatorLineView];
    }else{
        [self.bottomSeparatorLineView removeFromSuperview];
        self.bottomSeparatorLineView = nil;
    }
}
- (BOOL)bottomSep {
    return self.bottomSeparatorLineView == nil;
}

XYSepKey(BottomSepBottom);
-(void)setBsBottom:(CGFloat)bsBottom{
    XYSepSETFloat(bsBottom, kSeparatorBottomSepBottomKey);
    [self.bottomSeparatorLineView constrainUpdateAttribute:NSLayoutAttributeBottom constant:bsBottom];
}
-(CGFloat)bsBottom {
    NSNumber* num = XYSepGET(kSeparatorBottomSepBottomKey);
    return num ? num.doubleValue : 0;
}

XYSepKey(BottomSepLeft);
-(void)setBsLeft:(CGFloat)bsLeft{
    XYSepSETFloat(bsLeft, kSeparatorBottomSepLeftKey);
    [self.bottomSeparatorLineView constrainUpdateAttribute:NSLayoutAttributeLeft constant:-bsLeft];
}
-(CGFloat)bsLeft {
    NSNumber* num = XYSepGET(kSeparatorBottomSepLeftKey);
    return num ? num.doubleValue : 0;
}

XYSepKey(BottomSepRight);
-(void)setBsRight:(CGFloat)bsRight{
    XYSepSETFloat(bsRight, kSeparatorBottomSepRightKey);
    [self.bottomSeparatorLineView constrainUpdateAttribute:NSLayoutAttributeRight constant:bsRight];
}
-(CGFloat)bsRight {
    NSNumber* num = XYSepGET(kSeparatorBottomSepRightKey);
    return num ? num.doubleValue : 0;
}
@end
