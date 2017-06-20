//
//  NSBundle+Extention.m
//  XYCategory
//
//  Created by xieyan on 2017/6/6.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "NSObject+Extention.h"

@implementation NSObject (XYExtention)

+ (NSString *)xy_ClassName{
    return [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@.",[NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"]] withString:@""];
}
- (NSString *)xy_ClassName{
    return [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@.",[NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"]] withString:@""];
}
@end
