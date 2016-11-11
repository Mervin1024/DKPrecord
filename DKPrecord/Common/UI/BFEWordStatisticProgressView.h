//
//  BFEAccumulatedProgressView.h
//  boxfish-english
//
//  Created by 杨琦 on 16/7/30.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFEWordStatisticProgressView : UIView

@property (nonatomic, strong) UIColor* progressColor;
@property (nonatomic, strong) UIColor* borderColor;
@property (nonatomic, strong) UIColor* bottomColor;
@property (nonatomic, assign) CGFloat limitProgress;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat progress;


- (id)initWithBoderColor:(UIColor *)boderColor
             bottomColor:(UIColor *)bottomColor
           progressColor:(UIColor *)progressColor
               lineWidth:(CGFloat)lineWidth
           limitProgress:(CGFloat)limitProgress;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
