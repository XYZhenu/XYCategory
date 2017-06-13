//
//  NSFileManager+Dirctory.h
//  XYCategories
//
//  Created by xieyan on 2017/6/6.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (XYDirctory)
- ( float )cacheSize;//M
- ( float )folderSizeAtPath:(NSString *)folderPath;
- ( long long )fileSizeAtPath:(NSString *)filePath;

- (void)clearCache;
- (void)clearPath:(NSString*)path;
@end
