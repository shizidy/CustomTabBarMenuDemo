//
//  BadgeView.h
//  CustomTabBarFrameWork
//
//  Created by wdyzmx on 2018/6/27.
//  Copyright © 2018年 wdyzmx. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface BadgeView : UIView

@property (nonatomic, strong) IBInspectable UIColor *bgColor;
@property (nonatomic, strong) IBInspectable NSString *badgeValue;
@property (nonatomic, strong) IBInspectable UIColor *textColor;
@property (nonatomic, strong) IBInspectable UIFont *textFont;

@end
