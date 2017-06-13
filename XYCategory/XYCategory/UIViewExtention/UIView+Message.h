//
//  UIView+Message.h
//  Video
//
//  Created by xieyan on 2017/2/3.
//  Copyright © 2017年 Video. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN;
@protocol XYDelegate <NSObject>
-(void)XYResponse:(UIView* )view;
@end

@interface UIView (XYMessage)
@property(nonatomic,weak,nullable) id<XYDelegate>xyDelegate;

@property(nonatomic,strong,nullable) NSDictionary* xyMessage;
-(void)xyMessageSet:(NSDictionary*)message;

+(CGSize)xySizeWithMsg:(NSDictionary*)message size:(CGSize)size;
+(CGFloat)xyHeightWithMsg:(NSDictionary*)message width:(CGFloat)width;
@end
NS_ASSUME_NONNULL_END;
