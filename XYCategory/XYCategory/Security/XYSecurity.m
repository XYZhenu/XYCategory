//
//  NSString+Security.m
//  qunyao
//
//  Created by xieyan on 16/4/12.
//  Copyright © 2016年 xieyan. All rights reserved.
//

#import "XYSecurity.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
@implementation NSData (Security)
- (NSData *)AES256EncryptWithKey:(NSString *)key   //加密
{
    NSData *keyData1;
    NSData* bytes = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSInteger length = 32;
    
    if (bytes.length>32) {
        length = bytes.length;
    }
    char keyPtr0[length+1];
    bzero(keyPtr0,sizeof(keyPtr0));
    [key getCString:keyPtr0 maxLength:sizeof(keyPtr0) encoding:NSUTF8StringEncoding];
    keyData1 = [[NSData alloc] initWithBytes:keyPtr0 length:32];
    //AES256加密，密钥应该是32位的
    //对于块加密算法，输出大小总是等于或小于输入大小加上一个块的大小
    //所以在下边需要再加上一个块的大小
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding/*这里就是刚才说到的PKCS7Padding填充了*/ | kCCOptionECBMode,
                                          [keyData1 bytes], kCCKeySizeAES256,
                                          NULL,/* 初始化向量(可选) */
                                          [self bytes], dataLength,/*输入*/
                                          buffer, bufferSize,/* 输出 */
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);//释放buffer
    return nil;
    
}


-(NSData *)AES256DecryptWithKey:(NSString *)key
{
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    
    NSData* bytes = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSInteger length = 32;
    
    if (bytes.length>32) {
        length = bytes.length;
    }
    
    char keyPtr[length+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
    
}

@end
@implementation NSString (Security)
-(NSString*)AES256Encrypt:(NSString*)key{
    NSData * plain=[self dataUsingEncoding:NSUTF8StringEncoding];
    NSData * cipher=[plain AES256EncryptWithKey:key];
    NSString * string=[cipher base64EncodedStringWithOptions:0];
    return string;
}
-(NSString*)AES256Dncrypt:(NSString*)key{
    NSData * plain=[self dataUsingEncoding:NSUTF8StringEncoding];
    NSData * cipher=[plain AES256DecryptWithKey:key];
    NSString * string=[cipher base64EncodedStringWithOptions:0];
    return string;
}









- (NSString *)MD5EncryptLower {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}
- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }
    
    return [strM copy];
}
/** 大写MD5*/
- (NSString *)MD5EncryptUpper {
    
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}




- (NSString*)Base64Encode{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}
- (NSString*)Base64Decode{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}
@end
