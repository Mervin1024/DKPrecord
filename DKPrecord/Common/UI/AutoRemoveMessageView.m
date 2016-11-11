//
//  AutoRemoveMessageView.m
//  Training-Student
//
//  Created by dev on 12-12-1.
//
//

#import "AutoRemoveMessageView.h"
#import <QuartzCore/QuartzCore.h>
#import "BFEUICreator.h"
#import "BFECommonTools.h"
//#import "Boxfish.h"
#import "BFEDeviceTools.h"
#import "BFEPositionTools.h"

@interface AutoRemoveMessageView()
@property (nonatomic, copy) void(^actionAfterCompletion)();
@end

@implementation AutoRemoveMessageView

+ (void)show:(NSString*)message
{
    [self show:message withContainerView:[UIApplication sharedApplication].keyWindow completion:nil];
}

+ (void)show:(NSString*)message withContainerView:(UIView*)containerView completion:(void (^)(void))action
{
    CGFloat fontSize = [BFEDeviceTools isPad] ? 30 : 20;
    [self show:message withContainerView:containerView font:[UIFont systemFontOfSize:fontSize] fontColor:[UIColor whiteColor] completion:action];
}

+ (void)show:(NSString*)message withContainerView:(UIView*)containerView duration:(NSTimeInterval) duration completion:(void (^)(void))action
{
    CGFloat fontSize = [BFEDeviceTools isPad] ? 30 : 20;
    [[[AutoRemoveMessageView alloc] init] show:message
                             withContainerView:containerView
                                          font:[UIFont systemFontOfSize:fontSize]
                                     fontColor:[UIColor whiteColor]
                                      duration:duration
                                    completion:action];
}

+ (void)show:(NSString*)message
withContainerView:(UIView*)containerView
        font:(UIFont*)font
   fontColor:(UIColor*)fontColor
  completion:(void (^)(void))action
{
    [[[AutoRemoveMessageView alloc] init] show:message withContainerView:containerView font:font fontColor:fontColor completion:action];
}

- (void)show:(NSString*)message
withContainerView:(UIView*)containerView
        font:(UIFont*)font
   fontColor:(UIColor*)fontColor
  completion:(void (^)(void))action
{
    [self show:message withContainerView:containerView font:font fontColor:fontColor duration:1.25 completion:action];
}

- (void)show:(NSString*)message withContainerView:(UIView*)containerView font:(UIFont*)font fontColor:(UIColor*)fontColor duration:(NSTimeInterval) duration completion:(void (^)(void))action
{
    self.actionAfterCompletion = action;
    
    BOOL useKeyWindow = NO;
    if (!containerView) {
        containerView = [UIApplication sharedApplication].keyWindow;
        useKeyWindow = YES;
    }
    
    float widthLimit = containerView.frame.size.width - 80;
    CGSize size = [message boundingRectWithSize:CGSizeMake(widthLimit, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                     attributes:@{ NSFontAttributeName : font  }
                                        context:nil].size;
    UIView *bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width + 40, size.height + 20)];
    bkView.backgroundColor = [UIColor blackColor];
    bkView.alpha = .7;
    bkView.layer.cornerRadius = 10;
    bkView.center = CGPointMake(containerView.frame.size.width/2, containerView.frame.size.height/2);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    label.center = bkView.center;
    label.backgroundColor = [UIColor clearColor];
    label.text = message;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = fontColor;
    label.font = font;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    [containerView addSubview:bkView];
    [containerView addSubview:label];
    
    if ([self needRotateView:useKeyWindow]) {
        [self rotateView:label];
        [self rotateView:bkView];
    }
    
    NSArray *viewArray = @[bkView, label];
    [self performSelector:@selector(animateMessageWithViews:) withObject:viewArray afterDelay:duration];
}

- (BOOL)needRotateView:(BOOL)useKeyWindow
{
    return useKeyWindow && ![BFECommonTools isAfterIOS8] && [BFEDeviceTools isPad];
}

#define degreesToRadian(x) (M_PI * (x) / 180.0)

- (void)rotateView:(UIView*)view
{
    UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
    float angle = (statusBarOrientation == UIDeviceOrientationLandscapeLeft) ? 90 : -90;
    view.transform = CGAffineTransformMakeRotation(degreesToRadian(angle));
}

- (void)animateMessageWithViews:(NSArray*)views
{
    [UIView animateWithDuration:.5 animations:^{
        for (int i=0; i<views.count; i++) {
            ((UIView*)views[i]).alpha = 0;
        }
    } completion:^(BOOL finished) {
        for (int i=0; i<views.count; i++) {
            [((UIView*)views[i]) removeFromSuperview];
        }
        
        if (self.actionAfterCompletion) {
            self.actionAfterCompletion();
        }
    }];
}

//+ (void)showBoxfishWithMsg:(NSString*)message withContainerView:(UIView*)containerView font:(UIFont*)font fontColor:(UIColor*)fontColor duration:(NSTimeInterval) duration spitBubbleCompletion:(void (^)(void))actionAfterSpitBubble completion:(void (^)(void))action
//{
//    UIView *mask = [[UIView alloc] initWithFrame:containerView.frame];
//    mask.backgroundColor = [UIColor blackColor];
//    [containerView addSubview:mask];
//    mask.center = CGPointMake(containerView.frame.size.width/2, containerView.frame.size.height/2);
//    mask.alpha = .5;
//    
//    Boxfish *boxfish = [[Boxfish alloc] initWithScale:[BFEDeviceTools getUIScale]];
//    [containerView addSubview:boxfish];
//    boxfish.center = CGPointMake(containerView.frame.size.width + boxfish.frame.size.width/2, containerView.frame.size.height * .8);
//    
//    [UIView animateWithDuration:duration/2 animations:^{
//        boxfish.center = CGPointMake(containerView.frame.size.width * .85, boxfish.center.y);
//    } completion:^(BOOL finished) {
//        [boxfish spitBubble:message font:font textColor:fontColor playSound:NO completion:^{
//            if (actionAfterSpitBubble) {
//                actionAfterSpitBubble();
//            }
//            
//            [NSThread sleepForTimeInterval:1];
//            
//            [UIView animateWithDuration:duration/2 animations:^{
//                boxfish.center = CGPointMake(containerView.frame.size.width + boxfish.frame.size.width/2, boxfish.center.y);
//                mask.alpha = 0;
//            } completion:^(BOOL finished) {
//                [boxfish removeFromSuperview];
//                [mask removeFromSuperview];
//                
//                if (action) {
//                    action();
//                }
//                
//            }];
//            
//            [boxfish brokeBubble:^{
//            }];
//        }];
//    }];    
//}

+ (void)showBoxfishWithMsg:(NSString*)message withContainerView:(UIView*)containerView font:(UIFont*)font fontColor:(UIColor*)fontColor spitBubbleCompletion:(void (^)(void))actionAfterSpitBubble completion:(void (^)(void))action
{
    [self showBoxfishWithMsg:message withContainerView:containerView font:font fontColor:fontColor duration:0.6 spitBubbleCompletion:actionAfterSpitBubble completion:action];
}

+ (void)showMessageWithImage:(NSString *)imageName onView:(UIView *)containerView
{
    [self showMessageWithImage:imageName onView:containerView needAlter:NO];
}

+ (void)showMessageWithImage:(NSString *)imageName onView:(UIView *)containerView needAlter:(BOOL)needAlter
{
    NSString *name = [BFEDeviceTools isPad]?[NSString stringWithFormat:@"%@.png",imageName]:[NSString stringWithFormat:@"%@_iPhone.png",imageName];
    UIImageView *imageView = [BFEUICreator createImageViewFromImagename:name use2X:YES];
    [BFEPositionTools placeView:imageView atTheCenterOfTheView:containerView needAlter:needAlter];
    [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imageView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [imageView removeFromSuperview];
        }
    }];
}

+ (void)showMessage:(NSString *)message messageAttribute:(NSDictionary *)attributeDic withImage:(NSString *)imageName onView:(UIView *)containerView {
    if (!containerView) {
        containerView = [UIApplication sharedApplication].keyWindow;
    }
    float widthLimit = containerView.frame.size.width - 80;
    CGSize size = [message boundingRectWithSize:CGSizeMake(widthLimit, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                     attributes:attributeDic
                                        context:nil].size;
    
    UIView *bkView = [[UIView alloc] init];
    bkView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    bkView.layer.cornerRadius = 8;
    
    UIImageView *imageView = [BFEUICreator createImageViewFromImagename:imageName];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    label.center = bkView.center;
    label.backgroundColor = [UIColor clearColor];
    label.text = message;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = attributeDic[NSForegroundColorAttributeName];
    label.font = attributeDic[NSFontAttributeName];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGFloat bkWidth = CGRectGetWidth(label.frame)+52.f*2;
    bkView.frame = CGRectMake(0, 0, (bkWidth > widthLimit) ? widthLimit : bkWidth, CGRectGetHeight(imageView.frame)+14.f+size.height+35.f+32.f);
    bkView.center = CGPointMake(containerView.frame.size.width/2, containerView.frame.size.height/2);
    [containerView addSubview:bkView];
    [BFEPositionTools placeView:imageView atTheTopMiddleOfTheView:bkView offset:35.f];
    [BFEPositionTools placeView:label belowTheView:imageView span:14.f];
    [[[AutoRemoveMessageView alloc] init] performSelector:@selector(showMessageWithViews:) withObject:@[bkView, imageView, label] afterDelay:1.f];
}

- (void)showMessageWithViews:(NSArray *)views {
    [UIView animateWithDuration:1. animations:^{
        for (int i=0; i<views.count; i++) {
            ((UIView*)views[i]).alpha = 0;
        }
    } completion:^(BOOL finished) {
        for (int i=0; i<views.count; i++) {
            [((UIView*)views[i]) removeFromSuperview];
        }
        
        if (self.actionAfterCompletion) {
            self.actionAfterCompletion();
        }
    }];
}

@end
