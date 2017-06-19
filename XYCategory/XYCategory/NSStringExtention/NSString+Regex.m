//
//  NSString+Regex.m
//  XYCategories
//
//  Created by xieyan on 2017/6/6.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (XYRegex)
-(BOOL)validBankCard{
    NSString *pattern = @"^[0-9]{16}|[0-9]{19}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
}
-(BOOL)validPhoneNum{
    NSString *pattern = @"^(1[3|4|5|7|8][0-9])\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
}
-(BOOL)validEmail{
    NSString *pattern = @"^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
}

-(BOOL)validPassword{
    NSString *pattern = @"[A-Z0-9a-z._%+-]{6,15}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:self];
}
@end
