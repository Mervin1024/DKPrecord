//
//  BFEPageControl.m
//  operationalMaster
//
//  Created by mervin on 2016/10/13.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import "BFEPageControl.h"

@implementation BFEPageControl


- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIImageView *dot = [self.subviews objectAtIndex:i];
        [dot setFrame:CGRectMake(ORIGIN_X_FROM_VIEW(dot), ORIGIN_Y_FROM_VIEW(dot), 7, 7)];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
