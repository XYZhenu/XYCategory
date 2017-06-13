//
//  NSString+Regex.h
//  XYCategories
//
//  Created by xieyan on 2017/6/6.
//  Copyright © 2017年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XYRegex)
-(BOOL)validBankCard;
-(BOOL)validPhoneNum;
-(BOOL)validEmail;
-(BOOL)validPassword;
@end
