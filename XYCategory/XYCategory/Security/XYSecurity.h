//
//  NSString+Security.h
//  qunyao
//
//  Created by xieyan on 16/4/12.
//  Copyright © 2016年 xieyan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Security)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end


@interface NSString (Security)
-(NSString*)AES256Encrypt:(NSString*)key;
-(NSString*)AES256Dncrypt:(NSString*)key;


- (NSString *)MD5EncryptLower;
- (NSString *)MD5EncryptUpper;


- (NSString*)Base64Encode;
- (NSString*)Base64Decode;
@end
