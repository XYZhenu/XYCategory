//
//  NSBundle+AppInfo.h
//  XYCategories
//
//  Created by xieyan on 2017/6/6.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN;
@interface NSBundle (XYAppInfo)
+ (NSString*)executableName;
+ (NSString *)machineModel;
+ (NSString*)deviceName;
@end
NS_ASSUME_NONNULL_END;
