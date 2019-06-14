//
//  UIColor+XYKey.m
//  XYCategory
//
//  Created by xyzhenu on 2017/6/16.
//  Copyright © 2017年 xyzhenu. All rights reserved.
//

#import "UIColor+XYKey.h"
NSString* const keyColorTheme = @"theme";
@implementation UIColor (XYKey)
static UIColor*(^xytransformer)(NSString* value) = nil;
+(NSMutableDictionary*)colorDic{
    static NSMutableDictionary* colorDic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        colorDic = [NSMutableDictionary dictionary];
    });
    return colorDic;
}
+(void)registColor:(NSString*)color key:(NSString*)key{
    NSMutableDictionary* colordic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"xycolors"].mutableCopy;
    [colordic setValue:color forKey:key];
    [[NSUserDefaults standardUserDefaults] setValue:colordic forKey:@"xycolors"];
    if (!color) [self colorDic][key] = nil; else if (xytransformer) [self colorDic][key] = xytransformer(color);
}
+(void)registColorsDefault:(NSDictionary<NSString*,NSString*>*)dic transformer:(UIColor*(^)(NSString* value))transformer{
    NSDictionary* colordic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"xycolors"];
    if (!colordic) {
        colordic = dic;
    }
    xytransformer = transformer;
    for (NSString* key in colordic.allKeys) {
        if (xytransformer) [self colorDic][key] = xytransformer(colordic[key]);
    }
}
+(instancetype)colorForKey:(NSString*)key{
    return [self colorDic][key];
}
@end
