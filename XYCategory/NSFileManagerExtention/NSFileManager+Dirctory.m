//
//  NSFileManager+Dirctory.m
//  XYCategory
//
//  Created by xieyan on 2017/6/6.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "NSFileManager+Dirctory.h"

@implementation NSFileManager (XYDirctory)
+(NSDictionary*)getCachedDic:(NSString*)cacheName{
    NSDictionary* dic = nil;
    if (cacheName) {
        NSString* cachepath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches/%@.json",cacheName]];
        dic = [NSDictionary dictionaryWithContentsOfFile:cachepath];
    }
    return dic;
}
+(void)setCachedDic:(NSDictionary*)dic name:(NSString*)cacheName{
    if (!cacheName) return;
    NSString* cachepath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Library/Caches/%@.json",cacheName]];
    if (!dic) {
        if ([[NSFileManager defaultManager ] fileExistsAtPath :cachepath]) {
            [[NSFileManager defaultManager ] removeItemAtPath:cachepath error:nil];
        }
    }else{
        [dic writeToFile:cachepath atomically:YES];
    }
}
+( float )cacheSize
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [ self folderSizeAtPath :cachePath];
}

//由于缓存文件存在沙箱中，我们可以通过NSFileManager API来实现对缓存文件大小的计算。
// 遍历文件夹获得文件夹大小，返回多少 M
+( float ) folderSizeAtPath:( NSString *) folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0);
}

// 计算 单个文件的大小
+( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}

+(void)clearCache
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    [self clearPath:cachePath];
}
+(void)clearPath:(NSString*)path {
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :path];
    //NSLog ( @"cachpath = %@" , cachePath);
    for ( NSString * p in files) {
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [path stringByAppendingPathComponent :p];

        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
}
@end
