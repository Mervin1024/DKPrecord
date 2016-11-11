//
//  BFEPageScrollView.m
//  boxfish-english
//
//  Created by lvhuan on 16/6/16.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import "BFEPageScrollView.h"
#import "BFEPositionTools.h"
#import "BFEPageControl.h"

@interface BFEPageScrollView ()<UIScrollViewDelegate>
{
    NSArray *_subViews;
    
    BFEPageControl *_pageControl;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation BFEPageScrollView

- (void)dealloc {
    _scrollView.delegate = nil;
}

- (instancetype)initWithFrame:(CGRect)frame subViews:(NSArray *)subViews {
    self = [super initWithFrame:frame];
    if (self) {
        _subViews = subViews;
        _pageControlMargin = 20;
        [self initUI];
    }
    return self;
}

- (void)setPageControlMargin:(CGFloat)pageControlMargin{
    _pageControlMargin = pageControlMargin;
    [BFEPositionTools placeView:_pageControl
     atTheBottomMiddleOfTheView:self
                         offset:pageControlMargin];
}

- (void)initUI {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * _subViews.count, CGRectGetHeight(self.frame));
    for (int i = 0; i < _subViews.count; i++) {
        UIView *view = _subViews[i];
        if (view) {
            [BFEPositionTools placeView:view
               atTheLeftMiddleOfTheView:_scrollView
                                 offset:i * CGRectGetWidth(self.frame)];
        }
    }
    [self addSubview:_scrollView];
    
    _pageControl = [[BFEPageControl alloc] initWithFrame:CGRectMake(0, 0, 16, 5)];
    _pageControl.numberOfPages = _subViews.count;
    _pageControl.hidesForSinglePage = YES;
    _pageControl.userInteractionEnabled = NO;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    
    [BFEPositionTools placeView:_pageControl
     atTheBottomMiddleOfTheView:self
                         offset:self.pageControlMargin];
}

- (void)updatePageControlCurrentPage {
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (page > _pageControl.numberOfPages - 1) {
        NSLog(@"page is overflow.");
    } else {
        _pageControl.currentPage = page;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView      // called when scroll view grinds to a halt
{
    [self updatePageControlCurrentPage];
    
    if ([self.delegate respondsToSelector:@selector(didEndDecelerating:)]) {
        [self.delegate didEndDecelerating:(int)_pageControl.currentPage];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.delegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (0 == velocity.x && 0 == velocity.y)
    {
        // pan
    } else {
        if (_pageControl.currentPage == (_pageControl.numberOfPages - 1)) {
            if (velocity.x > 0) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:MsgScrollPageDidEnded object:nil userInfo:@{@"ScrollDirection":@(SwipeLeft)}];
                
                if (_pageControl.currentPage == _pageControl.numberOfPages - 1) {
                    if ([self.delegate respondsToSelector:@selector(didOverPageEdge)]) {
                        [self.delegate didOverPageEdge];
                    }
                }
            }
        } else if (0 ==  _pageControl.currentPage) {
            if (velocity.x < 0) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:MsgScrollPageDidEnded object:nil userInfo:@{@"ScrollDirection":@(SwipeRight)}];
            }
        }
    }
}

@end
