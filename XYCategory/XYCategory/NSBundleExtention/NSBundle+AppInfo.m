//
//  NSBundle+AppInfo.m
//  XYCategory
//
//  Created by xieyan on 2017/6/6.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "NSBundle+AppInfo.h"
#include <sys/sysctl.h>
@implementation NSBundle (XYAppInfo)
+ (NSString*)executableName{
    return [NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"];
}
+ (NSString *)machineModel {
    static dispatch_once_t one;
    static NSString *model;
    dispatch_once(&one, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *machine = malloc(size);
        sysctlbyname("hw.machine", machine, &size, NULL, 0);
        model = [NSString stringWithUTF8String:machine];
        free(machine);
    });
    return model;
}
+ (NSString*)deviceName{
    return [NSString stringWithFormat:@"%@_%@_%@",[UIDevice currentDevice].name,[self machineModel], [[UIDevice currentDevice] systemVersion]];
}
@end
