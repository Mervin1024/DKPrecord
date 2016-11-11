//
//  UINavigationItem+BackItem.h
//  operationalMaster
//
//  Created by mervin on 2016/10/17.
//  Copyright © 2016年 boxfish. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (BackItem)
+ (UIBarButtonItem *)myCustomBackButtonWithTarget:(id)target action:(SEL)action;
@end
