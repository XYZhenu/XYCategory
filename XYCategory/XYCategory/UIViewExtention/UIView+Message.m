//
//  UIView+Message.m
//  Video
//
//  Created by xieyan on 2017/2/3.
//  Copyright © 2017年 Video. All rights reserved.
//

#import "UIView+Message.h"
#import <objc/runtime.h>

@implementation UIView (XYMessage)
static char xydelegatekey;
-(void)setXyDelegate:(id<XYDelegate>)xyDelegate{
    objc_setAssociatedObject(self, &xydelegatekey, xyDelegate, OBJC_ASSOCIATION_ASSIGN);
}
-(id<XYDelegate>)xyDelegate{
    return objc_getAssociatedObject(self, &xydelegatekey);
}

static char xymessageKey;
-(void)setXyMessage:(NSDictionary*)xyMessage{
    objc_setAssociatedObject(self, &xymessageKey, xyMessage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self xyMessageSet:xyMessage];
}
-(NSDictionary*)xyMessage{
    return  objc_getAssociatedObject(self, &xymessageKey);
}
-(void)xyMessageSet:(NSDictionary*)message{}



+(CGSize)xySizeWithMsg:(NSDictionary*)message size:(CGSize)size{
    return CGSizeZero;
}
+(CGFloat)xyHeightWithMsg:(NSDictionary*)message width:(CGFloat)width{return -2;}
@end
