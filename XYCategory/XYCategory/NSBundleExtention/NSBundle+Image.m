//
//  NSBundle+Image.m
//  XYCategories
//
//  Created by xieyan on 2017/6/6.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "NSBundle+Image.h"

@implementation NSBundle (XYImage)
+ (UIImage*)lanuchImage {
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString* viewOrientation = @"Portrait";
    NSString* launchImage = nil;
    NSArray* imageDic = [[NSBundle mainBundle] infoDictionary][@"UILaunchImages"];
    for (NSDictionary* dic in imageDic) {
        CGSize imageSize = CGSizeFromString(dic[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dic[@"UILaunchImageOrientation"]]) {
            launchImage = dic[@"UILaunchImageName"];
            break;
        }
    }
    if (launchImage) {
        NSString* path = [[NSBundle mainBundle] pathForResource:launchImage ofType:@"png"];
        return [[UIImage alloc] initWithContentsOfFile:path];
    }
    return nil;
}
@end
