//
//  UIView+CornerRadius.h
//  operationalMaster
//
//  Created by mervin on 2016/10/12.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *	@brief	方便直接在xib文件中对UIView的边框做操作
 */

IB_DESIGNABLE

@interface UIView (CornerRadius)
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat borderWidth;
@property (nonatomic, strong)IBInspectable UIColor *borderColor;
@end
