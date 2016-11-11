//
//  BFEPageScrollView.h
//  boxfish-english
//
//  Created by lvhuan on 16/6/16.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFEUPageScrollViewDelegate <NSObject>
@optional
- (void)didEndDecelerating:(int)pageIndex;
- (void)didOverPageEdge;
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
@end

//创建带有PageControl的ScrollView 逐步替代BFEUIScrollViewWithPageControl
@interface BFEPageScrollView : UIView

@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, weak) id<BFEUPageScrollViewDelegate> delegate;
@property (nonatomic, assign) CGFloat pageControlMargin;  // default = 20;

- (instancetype)initWithFrame:(CGRect)frame subViews:(NSArray *)subViews;

@end
