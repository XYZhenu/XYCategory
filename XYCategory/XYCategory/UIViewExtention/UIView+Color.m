//
//  UIView+Color.m
//  XYCategory
//
//  Created by xyzhenu on 2017/6/16.
//  Copyright © 2017年 xyzhenu. All rights reserved.
//

#import "UIView+Color.h"
#import "UIColor+XYKey.h"
#import <objc/runtime.h>
@implementation UIView (XYColor)
static char xycolorkey;
-(NSString *)colorKey{
    return objc_getAssociatedObject(self, &xycolorkey);
}
-(void)setColorKey:(NSString *)colorKey{
    objc_setAssociatedObject(self, &xycolorkey, colorKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.backgroundColor = [UIColor colorForKey:colorKey];
}
@end
