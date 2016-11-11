//
//  UICreator.m
//  grammar
//
//  Created by user on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BFEUICreator.h"
#import <QuartzCore/QuartzCore.h>
///#import "NSData+Encryption.h"
#import "BFEDeviceTools.h"
///#import "UIImage+ImageEffects.h"

//负责创建通用的UI控件
@implementation BFEUICreator

+ (UIImage*)createImage:(NSString*)imagename
{
    UIImage *image = [UIImage imageNamed:imagename];
    
    if ([BFEDeviceTools isPhone]) {
        image = [UIImage imageWithCGImage:image.CGImage
                                    scale:(1/0.427)
                              orientation:image.imageOrientation];
    }
    
    return image;
}

+ (UIImageView*)createImageViewFromImagename:(NSString*)imagename use2X:(BOOL)use2X
{
    return [self createImageViewFromImagename:imagename
                                        use2X:use2X
                              useIphone6Image:YES];
}

+ (UIImageView*)createImageViewFromImagename:(NSString*)imagename
                                       use2X:(BOOL)use2X
                             useIphone6Image:(BOOL)useIphone6Image
{
    UIImage *image = [UIImage imageNamed:imagename];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    CGSize imageSize;
    
    if (useIphone6Image) {
        imageSize = [self resetImageSizeIfStudentInphoneVersion:image];
    } else {
        imageSize = image.size;
    }
    
    if (use2X) {
        imageView.frame = CGRectMake(0, 0, imageSize.width/2, imageSize.height/2);
    } else {
        imageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
    }
    
    imageView.userInteractionEnabled = YES;
    
    return imageView;
}

+ (UIImageView*)createImageViewFromImagePath:(NSString*)imagePath use2X:(BOOL)use2X
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        CGSize imageSize = [self resetImageSizeIfStudentInphoneVersion:image];
        
        if (use2X) {
            imageView.frame = CGRectMake(0, 0, imageSize.width/2, imageSize.height/2);
        }
        
        imageView.userInteractionEnabled = YES;
        
        return imageView;
    } else {
        return nil;
    }
}

+ (UIImageView*)createImageViewFromImagename:(NSString*)imagename
{
    return [BFEUICreator createImageViewFromImagename:imagename use2X:NO];
}

+ (UIButton*)createButtonWithTitle:(NSString*)title
                        titleColor:(UIColor*)titleColor
                              font:(UIFont*)font
                             frame:(CGRect)frame
                        buttonType:(UIButtonType)buttonType
                            target:(id)target
                            action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:buttonType]; //创建圆角矩形button
    [button setFrame:frame]; //设置button的frame
    [button setTitle:title forState:UIControlStateNormal]; //设置button的标题
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside]; //定义点击时的响应函数
    button.backgroundColor = [UIColor clearColor];
    button.titleLabel.backgroundColor = [UIColor clearColor];
    
    if (font) {
        button.titleLabel.font = font;
    }
    return button;
}

+ (UIButton*)createButtonWithTitle:(NSString*)title
                        titleColor:(UIColor*)titleColor
                             frame:(CGRect)frame
                            target:(id)target
                            action:(SEL)action
{
    return [self createButtonWithTitle:title
                            titleColor:titleColor
                                  font:nil
                                 frame:frame
                            buttonType:UIButtonTypeSystem
                                target:target
                                action:action];
}

+ (UIButton*)createButtonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font
                            target:(id)target
                            action:(SEL)action
{
    return [self createButtonWithTitle:title
                            titleColor:titleColor
                                  font:font
                       additionalWidth:[BFEDeviceTools isPad] ? 10 : 5
                      additionalHeight:[BFEDeviceTools isPad] ? 10 : 5
                                target:target
                                action:action];
}

+ (UIButton*)createButtonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font
                   additionalWidth:(CGFloat)additionalWidth
                  additionalHeight:(CGFloat)additionalHeight
                            target:(id)target
                            action:(SEL)action
{
    CGSize size = [title sizeWithAttributes:@{ NSFontAttributeName : font }];
    size.width += additionalWidth;
    size.height += additionalHeight;
    return [self createButtonWithTitle:title
                            titleColor:titleColor
                                  font:font
                                 frame:CGRectMake(0, 0, size.width, size.height)
                            buttonType:UIButtonTypeCustom
                                target:target
                                action:action];
}

+ (UIButton*)createButtonWithNormalImage:(NSString*)normalImageName
                        highlightedImage:(NSString*)highlightedImageName
                                  target:(id)target
                                  action:(SEL)action
{
    BOOL use2X = ([BFEDeviceTools isPhone]);
    
    return [self createButtonWithNormalImage:normalImageName
                            highlightedImage:highlightedImageName
                                      target:target
                                      action:action
                                       use2X:use2X];
}

+ (UIButton*)createButtonWithNormalImage:(NSString*)normalImageName
                        highlightedImage:(NSString*)highlightedImageName
                                  target:(id)target
                                  action:(SEL)action
                                   use2X:(BOOL)use2X
{
    return [self createButtonWithNormalImage:normalImageName
                            highlightedImage:highlightedImageName
                                      target:target action:action
                                       use2X:use2X
                             useIphone6Image:YES];
}

+ (UIButton*)createButtonWithNormalImage:(NSString*)normalImageName
                        highlightedImage:(NSString*)highlightedImageName
                                  target:(id)target
                                  action:(SEL)action
                                   use2X:(BOOL)use2X
                         useIphone6Image:(BOOL)useIphone6Image
{
    UIButton* btn = [[UIButton alloc] init];
    
    UIImage* normalImage = [UIImage imageNamed:normalImageName];
    UIImage* highlightedImage = [UIImage imageNamed:highlightedImageName];
    
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    CGSize normalImageSize;
    if (useIphone6Image) {
        normalImageSize = [self resetImageSizeIfStudentInphoneVersion:normalImage];
    } else {
        normalImageSize = normalImage.size;
    }
    
    if (use2X) {
        btn.frame = CGRectMake(0, 0, normalImageSize.width/2, normalImageSize.height/2);
    } else {
        btn.frame = CGRectMake(0, 0, normalImageSize.width, normalImageSize.height);
    }
    
    return btn;
}

+ (UIButton*)createToggleBtn:(NSString*)imageName1
                  alterImage:(NSString*)imageName2
                      target:(id)target
                      action:(SEL)action
{
    UIImage *image1 = [UIImage imageNamed:imageName1];
    UIImage *image2 = [UIImage imageNamed:imageName2];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, image1.size.width, image1.size.height);
    [btn setImage:image1 forState:UIControlStateNormal];
    [btn setImage:image2 forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor clearColor]];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    btn.frame = CGRectMake(0, 0, image1.size.width/2, image1.size.height/2);
    
    return btn;
}

+ (UIBarButtonItem*)creatBarButtonWithNormalImage:(NSString *)normalImageName
                                 highlightedImage:(NSString *)highlightedImageName
                                           target:(id)target
                                           action:(SEL)action{
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *highlightedImage = [UIImage imageNamed:highlightedImageName];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, normalImage.size.width, normalImage.size.height);
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    if (highlightedImageName) {
        [btn setBackgroundImage:highlightedImage forState:UIControlStateSelected];
    }
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barBtn;
}

+ (UIBarButtonItem*)creatDefaultBackBarButtonWithtarget:(id)target
                                                 action:(SEL)action{
    UIImage *normalImage = [UIImage imageNamed:@"back_chevron"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 65, normalImage.size.height);
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:COLOR(0, 118, 255) forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 6);
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barBtn;
}

+ (UITableView*)createGroupedTable:(id<UITableViewDelegate, UITableViewDataSource>)delegate
                             frame:(CGRect)frame
                            inView:(UIView*)view
{
    UITableView *table = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    table.delegate = delegate;
    table.dataSource = delegate;
    [view addSubview:table];
    return table;
}

+ (UILabel*)createLabel:(NSString*) content color:(UIColor*) color font:(UIFont*) font
{
    CGSize size = [content sizeWithAttributes:@{ NSFontAttributeName : font }];
    
    UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(0,0,size.width,size.height)];
    lab.text = content;
    lab.textColor = color;
    lab.backgroundColor = [UIColor clearColor];
    lab.font = font;
    
    return lab;
}

+ (UILabel*)createLabel:(NSString*)content constrainedSize:(CGSize)constrainedSize color:(UIColor*) color font:(UIFont*)font
{
    CGSize size = [content boundingRectWithSize:constrainedSize
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:@{ NSFontAttributeName : font }
                                        context:nil].size;
    
    UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(0,0,size.width,size.height)];
    lab.text = content;
    lab.textColor = color;
    lab.backgroundColor = [UIColor clearColor];
    lab.font = font;
    lab.numberOfLines = 0;
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    lab.textAlignment = NSTextAlignmentCenter;
    
    [lab sizeToFit];
    
    return lab;
}

+ (UILabel*)createLabel:(NSString*) content frame:(CGRect)frame color:(UIColor*) color font:(UIFont*) font
{
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = content;
    lab.textColor = color;
    lab.backgroundColor = [UIColor clearColor];
    lab.font = font;
    lab.adjustsFontSizeToFitWidth = YES;
    lab.textAlignment = NSTextAlignmentCenter;
    
    return lab;
}

+ (UILabel*)createLabel:(NSString*) content fontSize:(int) fontSize
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGSize size = [content sizeWithAttributes:@{ NSFontAttributeName : font }];
    return [self createLabel:content frame:CGRectMake(0,0,size.width,size.height) fontSize:fontSize];
}

+ (UILabel*)createLabel:(NSString*) content frame:(CGRect)frame fontSize:(int) fontSize
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = content;
    lab.textColor = [UIColor blackColor];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = font;
    lab.adjustsFontSizeToFitWidth = YES;
    
    return lab;
}

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame
                                    font:(UIFont*)font
                               textColor:(UIColor*)textColor
                             borderStyle:(UITextBorderStyle)borderStyle
                             placeholder:(NSString*)placeholder
                                delegate:(id<UITextFieldDelegate>)delegate
{
    UITextField *textFiled = [[UITextField alloc] initWithFrame:frame];
    textFiled.backgroundColor = [UIColor clearColor];
    textFiled.textColor = textColor;
    textFiled.borderStyle = borderStyle;
    textFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    textFiled.autocorrectionType = UITextAutocorrectionTypeNo;
    textFiled.placeholder = placeholder;
    textFiled.delegate = delegate;
    textFiled.font = font;
    
    return textFiled;
}

+ (UIImage*)getScaledImage:(UIImage*)originalImage scale:(CGFloat)scale
{
    scale = 1 / scale;
    UIImage *scaledImage = [UIImage imageWithCGImage:[originalImage CGImage]
                                               scale:scale orientation:originalImage.imageOrientation];
    
    return scaledImage;
}

+ (UIImage*)getScaledImage:(UIImage*)originalImage withFixHeight:(float)height
{
    float scale = originalImage.size.height / height;
    
    UIImage *scaledImage = [UIImage imageWithCGImage:[originalImage CGImage]
                                               scale:scale
                                         orientation:originalImage.imageOrientation];
    
    return scaledImage;
}

+ (UIImage*)getScaledImage:(UIImage*)originalImage withFixWidth:(float)width
{
    float scale = originalImage.size.width / width;
    
    UIImage *scaledImage = [UIImage imageWithCGImage:[originalImage CGImage]
                                               scale:scale
                                         orientation:originalImage.imageOrientation];
    return scaledImage;
}

#pragma mark - Image Reflection

CGImageRef CreateGradientImage(int pixelsWide, int pixelsHigh)
{
    CGImageRef theCGImage = NULL;
    
    // gradient is always black-white and the mask must be in the gray colorspace
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // create the bitmap context
    CGContextRef gradientBitmapContext = CGBitmapContextCreate(NULL, pixelsWide, pixelsHigh,
                                                               8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    
    // define the start and end grayscale values (with the alpha, even though
    // our bitmap context doesn't support alpha the gradient requires it)
    CGFloat colors[] = {0.0, 1.0, 1.0, 1.0};
    
    // create the CGGradient and then release the gray color space
    CGGradientRef grayScaleGradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
    CGColorSpaceRelease(colorSpace);
    
    // create the start and end points for the gradient vector (straight down)
    CGPoint gradientStartPoint = CGPointZero;
    CGPoint gradientEndPoint = CGPointMake(0, pixelsHigh);
    
    // draw the gradient into the gray bitmap context
    CGContextDrawLinearGradient(gradientBitmapContext, grayScaleGradient, gradientStartPoint,
                                gradientEndPoint, kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(grayScaleGradient);
    
    // convert the context into a CGImageRef and release the context
    theCGImage = CGBitmapContextCreateImage(gradientBitmapContext);
    CGContextRelease(gradientBitmapContext);
    
    // return the imageref containing the gradient
    return theCGImage;
}

CGContextRef MyCreateBitmapContext(int pixelsWide, int pixelsHigh)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create the bitmap context
    CGContextRef bitmapContext = CGBitmapContextCreate (NULL, pixelsWide, pixelsHigh, 8,
                                                        0, colorSpace,
                                                        // this will give us an optimal BGRA format for the device:
                                                        (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    CGColorSpaceRelease(colorSpace);
    
    return bitmapContext;
}

+ (UIImage*)reflectedImage:(UIImageView *)fromImageView withHeight:(NSUInteger)height
{
    if(height == 0)
        return nil;
    
    // create a bitmap graphics context the size of the image
    CGContextRef mainViewContentContext = MyCreateBitmapContext(fromImageView.bounds.size.width, (int)height);
    
    // create a 2 bit CGImage containing a gradient that will be used for masking the
    // main view content to create the 'fade' of the reflection.  The CGImageCreateWithMask
    // function will stretch the bitmap image as required, so we can create a 1 pixel wide gradient
    CGImageRef gradientMaskImage = CreateGradientImage(1, (int)height);
    
    // create an image by masking the bitmap of the mainView content with the gradient view
    // then release the  pre-masked content bitmap and the gradient bitmap
    CGContextClipToMask(mainViewContentContext, CGRectMake(0.0, 0.0, fromImageView.bounds.size.width, height), gradientMaskImage);
    CGImageRelease(gradientMaskImage);
    
    // In order to grab the part of the image that we want to render, we move the context origin to the
    // height of the image that we want to capture, then we flip the context so that the image draws upside down.
    CGContextTranslateCTM(mainViewContentContext, 0.0, height);
    CGContextScaleCTM(mainViewContentContext, 1.0, -1.0);
    
    // draw the image into the bitmap context
    CGContextDrawImage(mainViewContentContext, fromImageView.bounds, fromImageView.image.CGImage);
    
    // create CGImageRef of the main view bitmap content, and then release that bitmap context
    CGImageRef reflectionImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    // convert the finished reflection image to a UIImage
    UIImage *theImage = [UIImage imageWithCGImage:reflectionImage];
    
    // image is retained by the property setting above, so we can release the original
    CGImageRelease(reflectionImage);
    
    return theImage;
}

+ (UIImage*)getInscribedImage:(UIImage*)srcImage withSize:(CGSize)inscribedSize
{
    float srcWidth = srcImage.size.width;
    float srcHeight = srcImage.size.height;
    
    float dstWidth = 0;
    float dstHeight = 0;
    
    if (srcWidth > inscribedSize.width / inscribedSize.height * srcHeight) {
        dstWidth = inscribedSize.width;
        dstHeight = dstWidth / srcWidth * srcHeight;
    } else {
        dstHeight = inscribedSize.height;
        //        dstWidth = dstHeight / srcHeight * srcWidth;
    }
    
    UIImage *newImage = [self getScaledImage:srcImage withFixHeight:dstHeight];
    return newImage;
}

+ (UIImage*)getCircumscribedImage:(UIImage*)srcImage withSize:(CGSize)circumscribedSize
{
    return [self getCircumscribedImage:srcImage withSize:circumscribedSize offset:CGSizeMake(0, 0)];
}

+ (UIImage*)getCircumscribedImage:(UIImage*)srcImage withSize:(CGSize)circumscribedSize offset:(CGSize)offset
{
    if (srcImage) {
        CGImageRef imageRef = srcImage.CGImage;
        
        float srcWidth = srcImage.size.width;
        float srcHeight = srcImage.size.height;
        
        float dstWidth = 0;
        float dstHeight = 0;
        
        if (srcWidth > circumscribedSize.width / circumscribedSize.height * srcHeight) {
            dstHeight = srcHeight;
            dstWidth = dstHeight / circumscribedSize.height * circumscribedSize.width;
        } else {
            dstWidth = srcWidth;
            dstHeight = dstWidth / circumscribedSize.width * circumscribedSize.height;
        }
        
        CGRect myImageRect = CGRectMake((srcWidth - dstWidth)/2 + offset.width, (srcHeight - dstHeight)/2 + offset.height, dstWidth, dstHeight);
        CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
        
        UIGraphicsBeginImageContext(CGSizeMake(dstWidth, dstHeight));
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, myImageRect, subImageRef);
        UIImage* newImage = [UIImage imageWithCGImage:subImageRef];
        CFRelease(subImageRef);
        UIGraphicsEndImageContext();
        
        newImage = [self getScaledImage:newImage withFixHeight:circumscribedSize.height];
        
        return newImage;
    } else {
        return nil;
    }
}

+ (UIImage*)getEmergedImageFromFirstImage:(UIImage*)firstImage
                                firstSize:(CGSize)firstSize
                              secondImage:(UIImage*)secondImage
                               secondRect:(CGRect)secondRect
{
    CGImageRef firstCGImage = [firstImage CGImage];
    CGImageRef secondCGImage = [secondImage CGImage];
    
    UIGraphicsBeginImageContextWithOptions(firstSize, NO, 0.0);
    // below context presumes a number of things about the images and may need to be more aware
    CGContextRef ctx = CGBitmapContextCreate(NULL, firstSize.width, firstSize.height,
                                             8, firstSize.width * 4, CGImageGetColorSpace(firstCGImage),
                                             kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little);
    
    // we presume ctx succeeded; it may be NULL if it did not
    CGContextDrawImage(ctx, (CGRect){CGPointZero, firstSize}, firstCGImage);
    CGContextDrawImage(ctx, secondRect, secondCGImage);
    CGImageRef result = CGBitmapContextCreateImage(ctx);
    CGContextRelease(ctx);
    
    UIImage *image = [[UIImage alloc] initWithCGImage:result];
    CGImageRelease(result);
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (void)makeRoundCorner:(float)value withView:(UIView*)view
{
    CALayer *layer = view.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:value];
}

+ (void)addShadowToView:(UIView*)view withColor:(UIColor*)shadowColor
{
    view.layer.shadowColor = [shadowColor CGColor];
    view.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    view.layer.shadowOpacity = 1.0f;
    view.layer.shadowRadius = 1.0f;
}

+ (UIVisualEffectView *)createBlurViewWithFrame:(CGRect)frame
                                          style:(UIBlurEffectStyle)style {
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    return effectView;
}

+ (void)createBlurBackground:(UIView*)underView
                   container:(UIView*)containter
                   tintColor:(UIColor*)tintColor
              blurViewCenter:(CGPoint)center
{
    UIGraphicsBeginImageContextWithOptions(underView.bounds.size, YES, 0.0f);
    BOOL result = [underView drawViewHierarchyInRect:underView.bounds afterScreenUpdates:YES];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (result) {
//        UIImage *blurredImage = [snapshotImage applyBlurWithRadius:4 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
//        UIImageView *blurredImageView = [[UIImageView alloc] initWithImage:blurredImage];
//        [containter addSubview:blurredImageView];
//        blurredImageView.center = center;
    }
}

+ (void)createBlurBackground:(UIView*)underView container:(UIView*)containter
{
    UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.95];
    CGPoint blurViewCenter = CGPointMake(containter.bounds.size.width/2, containter.bounds.size.height/2);
    [self createBlurBackground:underView container:containter tintColor:tintColor blurViewCenter:blurViewCenter];
}

+ (void)createBlurBackgroundWithView:(UIView*)view alpha:(CGFloat)alpha
{
    [self createBlurBackgroundWithView:view alpha:alpha style:UIBarStyleBlack];
}

+ (void)createBlurBackgroundWithView:(UIView*)view alpha:(CGFloat)alpha style:(UIBarStyle)style
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:view.bounds];
    toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    toolbar.barStyle = style;
    toolbar.alpha = alpha;
    [view insertSubview:toolbar atIndex:0];
}

+ (CGSize)resetImageSizeIfStudentInphoneVersion:(UIImage *)image
{
    CGSize imageSize = image.size;
    if ([BFEDeviceTools is3p5InchPhone] || [BFEDeviceTools is4InchPhone]) {
        imageSize.width = imageSize.width * 0.854;
        imageSize.height = imageSize.height * 0.854;
    }
    return imageSize;
}

+ (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)size{
    
    CGRect rect = CGRectMake(0.0f,0.0f,size.width,size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}

+ (UIImage*)circleImage:(UIImage *)image withBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    
    // borderWidth 表示边框的宽度
    CGFloat imageW = image.size.width + 2 * borderWidth;
    CGFloat imageH = imageW;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // borderColor表示边框的颜色
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5;
    CGFloat centerX = bigRadius;
    CGFloat centerY = bigRadius;
    CGContextAddArc(context, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(context, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    CGContextClip(context);
    [image drawInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

@end
