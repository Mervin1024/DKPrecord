//
//  NSString+Extension.h
//  boxfish-english
//
//  Created by 杨琦 on 16/8/16.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  去掉空格
 */
- (NSString *)BFERemoveSpaces;
/**
 *  去掉回车
 */
- (NSString *)BFERemoveLineBreaks;
/**
 *  去掉空格和回车
 */
- (NSString *)BFERemoveSpacesAndLineBreaks;
/**
 *  是否包含
 */
- (BOOL)BFEHasSubString:(NSString *)subStr;
/**
 *  根据fontSize和lineWith就算出行高
 */
- (CGFloat)BFEHeightWithFont:(UIFont *)font lineWidth:(CGFloat)width;
/**
 * 根据fontSize和Max Width计算行款
 */
- (CGFloat)BFEWidthWithFont:(UIFont *)font lineWidth:(CGFloat)width;
/**
 *  根据fontSize和行高计算出行宽
 */
- (CGFloat)BFEWidthWithFont:(UIFont *)font lineHeight:(CGFloat)height;

@end
