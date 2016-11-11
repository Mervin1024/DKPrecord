//
//  NSData+AES256.h
//  CommonLib
//
//  Created by dev on 13-3-25.
//  Copyright (c) 2013年 boxfishedu. All rights reserved.
//

#import <CommonCrypto/CommonCryptor.h>

@interface NSData(Encryption)

-(NSData*)AES256EncryptWithKey:(NSString*)key;
-(NSData*)AES256DecryptWithKey:(NSString*)key;

- (NSString *)newStringInBase64FromData;

@end
