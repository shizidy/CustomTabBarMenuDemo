//
//  RootViewController.h
//  CustomTabBarFrameWork
//
//  Created by wdyzmx on 2018/6/26.
//  Copyright © 2018年 wdyzmx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LeftMenuStyle,
    RightMenuStyle,
    LeftandRightMenuStyle,
} MenuStyle;

@interface RootViewController : UIViewController
-(instancetype)initWithMenuStyle:(MenuStyle)style;
@end
