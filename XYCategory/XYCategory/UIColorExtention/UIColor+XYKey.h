//
//  UIColor+XYKey.h
//  XYCategory
//
//  Created by xyzhenu on 2017/6/16.
//  Copyright © 2017年 xyzhenu. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIColor (XYKey)
+(void)registColor:(nullable NSString*)color key:(NSString*)key;
+(void)registColorsDefault:(NSDictionary<NSString*,NSString*>*)dic transformer:(UIColor*(^)(NSString* value))transformer;
+(instancetype)colorForKey:(NSString*)key;
@end
NS_ASSUME_NONNULL_END
