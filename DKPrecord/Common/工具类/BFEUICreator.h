//
//  UICreator.h
//  grammar
//
//  Created by user on 12-6-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFEUICreator : NSObject

+ (UIImage*)createImage:(NSString*)imagename;

//根据图像名创建UIImageView
+ (UIImageView*)createImageViewFromImagename:(NSString*)imagename;
+ (UIImageView*)createImageViewFromImagename:(NSString*)imagename use2X:(BOOL)use2X;
+ (UIImageView*)createImageViewFromImagename:(NSString*)imagename
                                       use2X:(BOOL)use2X
                             useIphone6Image:(BOOL)useIphone6Image;
+ (UIImageView*)createImageViewFromImagePath:(NSString*)imagePath use2X:(BOOL)use2X;

+ (UILabel*)createLabel:(NSString*) content color:(UIColor*) color font:(UIFont*) font;
+ (UILabel*)createLabel:(NSString*) content frame:(CGRect)frame color:(UIColor*) color font:(UIFont*) font;
+ (UILabel*)createLabel:(NSString*) content fontSize:(int) fontSize;
+ (UILabel*)createLabel:(NSString*) content frame:(CGRect)frame fontSize:(int) fontSize;
+ (UILabel*)createLabel:(NSString*)content constrainedSize:(CGSize)constrainedSize color:(UIColor*)color font:(UIFont*)font;

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame
                                    font:(UIFont*)font
                               textColor:(UIColor*)textColor
                             borderStyle:(UITextBorderStyle)borderStyle
                             placeholder:(NSString*)placeholder
                                delegate:(id<UITextFieldDelegate>)delegate;

+ (UIButton*)createButtonWithTitle:(NSString*)title
                        titleColor:(UIColor*)titleColor 
                             frame:(CGRect)frame 
                            target:(id)target 
                            action:(SEL)action;

+ (UIButton*)createButtonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font
                            target:(id)target
                            action:(SEL)action;

+ (UIButton*)createButtonWithTitle:(NSString *)title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *)font
                   additionalWidth:(CGFloat)additionalWidth
                  additionalHeight:(CGFloat)additionalHeight
                            target:(id)target
                            action:(SEL)action;

+ (UIButton*)createButtonWithTitle:(NSString*)title
                        titleColor:(UIColor*)titleColor
                              font:(UIFont*)font
                             frame:(CGRect)frame
                        buttonType:(UIButtonType)buttonType
                            target:(id)target
                            action:(SEL)action;

+ (UIButton*)createToggleBtn:(NSString*)imageName1 
                  alterImage:(NSString*)imageName2 
                      target:(id)target 
                      action:(SEL)action;

+ (UIButton*)createButtonWithNormalImage:(NSString*)normalImageName 
                        highlightedImage:(NSString*)highlightedImageName 
                                  target:(id)target
                                  action:(SEL)action
                                   use2X:(BOOL)use2X;

+ (UIButton*)createButtonWithNormalImage:(NSString*)normalImageName
                        highlightedImage:(NSString*)highlightedImageName
                                  target:(id)target
                                  action:(SEL)action
                                   use2X:(BOOL)use2X
                         useIphone6Image:(BOOL)useIphone6Image;

+ (UIButton*)createButtonWithNormalImage:(NSString*)normalImageName 
                        highlightedImage:(NSString*)highlightedImageName 
                                  target:(id)target
                                  action:(SEL)action;

+ (UIBarButtonItem*)creatBarButtonWithNormalImage:(NSString*)normalImageName
                                 highlightedImage:(NSString*)highlightedImageName
                                           target:(id)target
                                           action:(SEL)action;

+ (UIBarButtonItem*)creatDefaultBackBarButtonWithtarget:(id)target
                                                 action:(SEL)action;

+ (UITableView*)createGroupedTable:(id<UITableViewDelegate, UITableViewDataSource>)delegate 
                             frame:(CGRect)frame 
                            inView:(UIView*)view;

+ (CGSize)resetImageSizeIfStudentInphoneVersion:(UIImage *)image;
+ (UIImage*)getScaledImage:(UIImage*)originalImage scale:(CGFloat)scale;
+ (UIImage*)getScaledImage:(UIImage*)originalImage withFixHeight:(float)height;
+ (UIImage*)getScaledImage:(UIImage*)originalImage withFixWidth:(float)width;
+ (UIImage*)getInscribedImage:(UIImage*)srcImage withSize:(CGSize)inscribedSize;
+ (UIImage*)getCircumscribedImage:(UIImage*)srcImage withSize:(CGSize)circumscribedSize;
+ (UIImage*)getCircumscribedImage:(UIImage*)srcImage withSize:(CGSize)circumscribedSize offset:(CGSize)offset;
+ (UIImage*)reflectedImage:(UIImageView *)fromImageView withHeight:(NSUInteger)height;

+ (UIImage*)getEmergedImageFromFirstImage:(UIImage*)firstImage
                                firstSize:(CGSize)firstSize
                              secondImage:(UIImage*)secondImage
                               secondRect:(CGRect)secondRect;

+ (UIVisualEffectView *)createBlurViewWithFrame:(CGRect)frame
                                          style:(UIBlurEffectStyle)style;

+ (void)makeRoundCorner:(float)value withView:(UIView*)view;

+ (void)addShadowToView:(UIView*)view withColor:(UIColor*)shadowColor;
+ (void)createBlurBackground:(UIView*)underView container:(UIView*)containter;
+ (void)createBlurBackground:(UIView*)underView
                   container:(UIView*)containter
                   tintColor:(UIColor*)tintColor
              blurViewCenter:(CGPoint)center;
+ (void)createBlurBackgroundWithView:(UIView*)view alpha:(CGFloat)alpha;
+ (void)createBlurBackgroundWithView:(UIView*)view alpha:(CGFloat)alpha style:(UIBarStyle)style;

+ (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)size;
+ (UIImage*)circleImage:(UIImage *)image withBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end
