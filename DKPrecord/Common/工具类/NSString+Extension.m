//
//  NSString+Extension.m
//  boxfish-english
//
//  Created by 杨琦 on 16/8/16.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


- (NSString *)BFERemoveSpaces
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)BFERemoveLineBreaks
{
    return [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

- (NSString *)BFERemoveSpacesAndLineBreaks
{
    return [[self stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

- (BOOL)BFEHasSubString:(NSString *)subStr
{
    BOOL result = NO;
    NSRange range = [self rangeOfString:subStr];
    if (range.location != NSNotFound) {
        result = YES;
    }
    return result;
}

- (CGFloat)BFEHeightWithFont:(UIFont *)font lineWidth:(CGFloat)width
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_0
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.height;
    
#else
    CGSize size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
    
#endif
}

- (CGFloat)BFEWidthWithFont:(UIFont *)font lineWidth:(CGFloat)width
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_0
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
    
#else
    CGSize size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return size.wide;
    
#endif
}

- (CGFloat)BFEWidthWithFont:(UIFont *)font lineHeight:(CGFloat)height
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_0
    CGRect rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
    
#else
    CGSize size = [self sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX,height) lineBreakMode:NSLineBreakByWordWrapping];
    return size.wide;
    
#endif
}

@end
