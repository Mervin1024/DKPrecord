//
//  BFEAccumulatedProgressView.h
//  boxfish-english
//
//  Created by 杨琦 on 16/7/30.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import "BFEWordStatisticProgressView.h"
#import <QuartzCore/QuartzCore.h>


static const CGFloat kBorderWidth = 2.0f;


@interface ETTProgressLayer : CALayer
@property (nonatomic, strong) UIColor* progressTintColor;
@property (nonatomic, strong) UIColor* borderTintColor;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) UIColor* progressBackgroundColor;
@end

@implementation ETTProgressLayer

@dynamic progressTintColor;
@dynamic borderTintColor;
@dynamic progressBackgroundColor;

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    return [key isEqualToString:@"progress"] ? YES : [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx
{
    CGRect rect = CGRectInset(self.bounds, kBorderWidth, kBorderWidth);
    CGFloat radius = CGRectGetHeight(rect) / 2.0f;
    CGContextSetLineWidth(ctx, kBorderWidth);
    CGContextSetStrokeColorWithColor(ctx, self.borderTintColor.CGColor);
    [self drawRectangleInContext:ctx inRect:rect withRadius:radius];
    CGContextStrokePath(ctx);
    
    CGContextSetFillColorWithColor(ctx, self.progressBackgroundColor.CGColor);
    CGRect invariantProgressRect = CGRectInset(rect, 2 * kBorderWidth, 2 * kBorderWidth);
    CGFloat invariantProgressRadius = CGRectGetHeight(invariantProgressRect) / 2.0f;
    invariantProgressRect.size.width = fmaxf(invariantProgressRect.size.width, 2.0f * invariantProgressRadius);
    [self drawRectangleInContext:ctx inRect:invariantProgressRect withRadius:invariantProgressRadius];
    CGContextFillPath(ctx);
    
    CGContextSetFillColorWithColor(ctx, self.progressTintColor.CGColor);
    CGRect progressRect = CGRectInset(rect, 2 * kBorderWidth, 2 * kBorderWidth);
    CGFloat progressRadius = CGRectGetHeight(progressRect) / 2.0f;
    progressRect.size.width = fmaxf(self.progress * progressRect.size.width, 2.0f * progressRadius);
    [self drawRectangleInContext:ctx inRect:progressRect withRadius:progressRadius];
    CGContextFillPath(ctx);
}

- (void)drawRectangleInContext:(CGContextRef)context inRect:(CGRect)rect withRadius:(CGFloat)radius
{
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, radius, M_PI, M_PI / 2, 1);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, radius, 0.0f, -M_PI / 2, 1);
    CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius, -M_PI / 2, M_PI, 1);
}

@end

@implementation BFEWordStatisticProgressView

- (instancetype)initWithBoderColor:(UIColor *)boderColor
                       bottomColor:(UIColor *)bottomColor
                     progressColor:(UIColor *)progressColor
                         lineWidth:(CGFloat)lineWidth
                     limitProgress:(CGFloat)limitProgress
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.borderColor = boderColor;
        self.progressColor = progressColor;
        self.bottomColor = bottomColor;
        _lineWidth = lineWidth;
        _limitProgress = limitProgress;
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)didMoveToWindow
{
    self.progressLayer.contentsScale = self.window.screen.scale;
}

+ (Class)layerClass
{
    return [ETTProgressLayer class];
}

- (ETTProgressLayer *)progressLayer
{
    return (ETTProgressLayer *)self.layer;
}

- (CGFloat)progress
{
    return self.progressLayer.progress;
}

- (void)setProgress:(CGFloat)progress
{
    [self setProgress:progress animated:YES];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [self.progressLayer removeAnimationForKey:@"progress"];
    CGFloat pinnedProgress = MIN(MAX(progress, 0.0f), 1.0f);
    
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
        animation.duration = fabs(self.progress - pinnedProgress) + 0.1f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.fromValue = [NSNumber numberWithFloat:self.progress];
        animation.toValue = [NSNumber numberWithFloat:pinnedProgress];
        [self.progressLayer addAnimation:animation forKey:@"progress"];
    }
    else {
        [self.progressLayer setNeedsDisplay];
    }
    
    self.progressLayer.progress = pinnedProgress;
}

- (UIColor *)progressColor
{
    return self.progressLayer.progressTintColor;
}

- (void)setProgressColor:(UIColor *)progressColor
{
    self.progressLayer.progressTintColor = progressColor;
    [self.progressLayer setNeedsDisplay];
}

- (UIColor *)borderColor
{
    return self.progressLayer.borderTintColor;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.progressLayer.borderTintColor = borderColor;
    [self.progressLayer setNeedsDisplay];
}

- (void)setBottomColor:(UIColor *)bottomColor
{
    self.progressLayer.progressBackgroundColor = bottomColor;
    [self.progressLayer setNeedsDisplay];
}

@end
