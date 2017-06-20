//
//  NSString+Caculate.m
//  XYCategory
//
//  Created by xieyan on 2017/6/6.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "NSString+Caculate.h"

@implementation NSString (XYCaculate)
+(NSString*)intString:(NSInteger)number{
    return [NSString stringWithFormat:@"%ld",(long)number];
}
+(NSString*)floatString:(double)number digit:(NSInteger)digit{
    NSNumberFormatter* formater = [NSNumberFormatter new];
    formater.numberStyle = NSNumberFormatterDecimalStyle;
    formater.maximumFractionDigits = digit;
    formater.minimumFractionDigits = 0;
    formater.usesGroupingSeparator = NO;
    return [formater stringFromNumber:@(number)];
}

-(NSString*)addIntNum:(NSInteger)number{
    NSString* num = [NSString intString:[self integerValue]+number];
    return num;
}
-(NSString*)addFloatNum:(double)number{
    NSString* num = [NSString floatString:[self doubleValue]+number digit:3];
    return num;
}
-(NSString*)addStringIntNum:(NSString*)number{
    NSString* num = [NSString intString:[self integerValue]+[number integerValue]];
    return num;
}
-(NSString*)addStringFloatNum:(NSString*)number{
    NSString* num = [NSString floatString:[self floatValue]+[number floatValue] digit:3];
    return num;
}

@end
