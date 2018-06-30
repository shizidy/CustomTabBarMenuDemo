//
//  CustomTabBar.h
//  CustomTabBarFrameWork
//
//  Created by wdyzmx on 2018/6/26.
//  Copyright © 2018年 wdyzmx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SamItemNum_Three = 3,
    SamItemNum_Five = 5,
} SamItemNum;

@class CustomTabBar;
@protocol SamTabBarDelegate <NSObject>
-(void)tabBar:(CustomTabBar *)tabBar clickCenterButton:(UIButton *)btn;
@end


@interface CustomTabBar : UITabBar
//代理
@property (nonatomic, weak)id<SamTabBarDelegate>samTabBarDelegate;

@property (nonatomic, strong) NSString *centerBtnIcon;//button图片
@property (nonatomic, strong) NSString *centerBtnTitle;//button文字
-(instancetype)initWithFrame:(CGRect)frame samItemNum:(SamItemNum)num;

@end
