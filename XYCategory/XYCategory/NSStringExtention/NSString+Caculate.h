//
//  NSString+Caculate.h
//  XYCategories
//
//  Created by xieyan on 2017/6/6.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN;
@interface NSString (XYCaculate)
+(NSString*)intString:(NSInteger)number;
+(NSString*)floatString:(double)number digit:(NSInteger)digit;

-(NSString*)addIntNum:(NSInteger)number;
-(NSString*)addFloatNum:(double)number;
-(NSString*)addStringIntNum:(NSString*)number;
-(NSString*)addStringFloatNum:(NSString*)number;
@end
NS_ASSUME_NONNULL_END;
