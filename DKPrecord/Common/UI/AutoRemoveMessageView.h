//
//  AutoRemoveMessageView.h
//  Training-Student
//
//  Created by dev on 12-12-1.
//
//

#import <UIKit/UIKit.h>

@interface AutoRemoveMessageView : UIView

+ (void)show:(NSString*)message;
+ (void)show:(NSString*)message withContainerView:(UIView*)containerView completion:(void (^)(void))action;
+ (void)show:(NSString*)message withContainerView:(UIView*)containerView duration:(NSTimeInterval) duration completion:(void (^)(void))action;

+ (void)show:(NSString*)message withContainerView:(UIView*)containerView font:(UIFont*)font fontColor:(UIColor*)fontColor completion:(void (^)(void))action;

+ (void)showBoxfishWithMsg:(NSString*)message withContainerView:(UIView*)containerView font:(UIFont*)font fontColor:(UIColor*)fontColor duration:(NSTimeInterval) duration spitBubbleCompletion:(void (^)(void))actionAfterSpitBubble completion:(void (^)(void))action;

+ (void)showBoxfishWithMsg:(NSString*)message withContainerView:(UIView*)containerView font:(UIFont*)font fontColor:(UIColor*)fontColor spitBubbleCompletion:(void (^)(void))actionAfterSpitBubble completion:(void (^)(void))action;

+ (void)showMessageWithImage:(NSString *)imageName onView:(UIView *)containerView;
+ (void)showMessageWithImage:(NSString *)imageName onView:(UIView *)containerView needAlter:(BOOL)needAlter;

+ (void)showMessage:(NSString *)message messageAttribute:(NSDictionary *)attributeDic withImage:(NSString *)imageName onView:(UIView *)containerView;

@end
