//
//  UIButton+Content.m
//  XYCategory
//
//  Created by xieyan on 2017/6/4.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "UIButton+Content.h"
#import <objc/runtime.h>
#define XYBtnContentKey(_C_) static char kBtnContent##_C_##Key
#define XYBtnContentSET(_O_,_K_) objc_setAssociatedObject(self, &_K_, _O_, OBJC_ASSOCIATION_RETAIN_NONATOMIC)
#define XYBtnContentGET(_K_) objc_getAssociatedObject(self, &_K_)
@implementation UIButton (XYContent)

+(void)load {
    Method method =class_getInstanceMethod([UIButton class], @selector(layoutSubviews));
    Method new =class_getInstanceMethod([UIButton class], @selector(layoutSubviewsXY));
    method_exchangeImplementations(method, new);
}
- (void)layoutSubviewsXY {
    [self layoutSubviewsXY];
    if (self.centerVertical) [self centerImageAndTitle:self.centerSpacing];
}
- (void)centerImageAndTitle:(float)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;

    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);

    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);

    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height), 0.0);
}
XYBtnContentKey(CenterContent);
- (void)setCenterVertical:(BOOL)centerVertical {
    XYBtnContentSET(@(centerVertical), kBtnContentCenterContentKey);
}
- (BOOL)centerVertical {
    NSNumber* num = XYBtnContentGET(kBtnContentCenterContentKey);
    if (!num) {
        num = @NO;
    }
    return num.boolValue;
}
XYBtnContentKey(CenterSpacing);
-(void)setCenterSpacing:(CGFloat)centerSpacing {
    XYBtnContentSET(@(centerSpacing), kBtnContentCenterSpacingKey);
}
- (CGFloat)centerSpacing {
    NSNumber* num = XYBtnContentGET(kBtnContentCenterSpacingKey);
    if (!num) {
        num = @4;
    }
    return num.floatValue;
}
@end
