//
//  NSBundle+AppInfo.m
//  XYCategories
//
//  Created by xieyan on 2017/6/6.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "NSBundle+AppInfo.h"

@implementation NSBundle (XYAppInfo)
+ (NSString*)executableName{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"];
}
@end
