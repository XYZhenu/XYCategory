//
//  DeepCopy.h
//  YiMiApp
//
//  Created by xieyan on 16/4/18.
//  Copyright © 2016年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN;
@interface NSArray (XYDeepCopy)
-(NSMutableArray*)MutableDeepCopyToString:(BOOL)toString;
@end

@interface NSDictionary (XYDeepCopy)
-(NSMutableDictionary*)MutableDeepCopyToString:(BOOL)toString;
@end
NS_ASSUME_NONNULL_END;
