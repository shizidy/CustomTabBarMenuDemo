//
//  CustomTabBar.m
//  CustomTabBarFrameWork
//
//  Created by wdyzmx on 2018/6/26.
//  Copyright © 2018年 wdyzmx. All rights reserved.
//

#import "CustomTabBar.h"

@interface CustomTabBar ()
@property (nonatomic, strong) UIButton *centerBtn;
@property (nonatomic, strong) UILabel *centerlb;
@property (nonatomic, assign) SamItemNum num;
@end

@implementation CustomTabBar
-(instancetype)initWithFrame:(CGRect)frame samItemNum:(SamItemNum)num{
    if (self = [super initWithFrame:frame]) {
        self.num = num;
        self.translucent = NO;
        //
        self.centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.centerBtn addTarget:self action:@selector(centerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.centerBtn];
        self.centerBtn.backgroundColor = [UIColor orangeColor];
        //
        self.centerlb = [[UILabel alloc] init];
        self.centerlb.font = [UIFont systemFontOfSize:12];
        self.centerlb.textAlignment = NSTextAlignmentCenter;
        self.centerlb.textColor = [UIColor blackColor];
        [self addSubview:self.centerlb];
    }
    return self;
}
//调整subViews视图
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.items objectAtIndex:0].badgeValue = @"10";//设置消息badgeView,根据具体场景设置
    CGFloat itemWidth = self.frame.size.width/self.num;
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *view in self.subviews) {
        if ([view isEqual:self.centerlb]) {
            view.frame = CGRectMake(0, 0, itemWidth, 15);
            view.center = CGPointMake(self.frame.size.width/2, self.frame.size.height-view.frame.size.height+8);
        }else if ([view isEqual:self.centerBtn]){
            view.frame = CGRectMake(0, 0, itemWidth, self.frame.size.height-10);
            [view sizeToFit];
            view.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        }else if ([view isKindOfClass:class]){//系统的UITabBarButton
            CGRect frame = view.frame;
            int indexFromOrign = view.frame.origin.x/itemWidth;//防止UIView *view in self.subviews 获取到的不是有序的
            if (indexFromOrign >= (self.num - 1) / 2) {
                indexFromOrign++;
            }
            CGFloat x = indexFromOrign * itemWidth;
            //如果是系统的UITabBarButton，那么就调整子控件位置，空出中间位置
            view.frame = CGRectMake(x, view.frame.origin.y, itemWidth, frame.size.height);
            
            //调整badge postion
//            for (UIView *badgeView in view.subviews){
//                NSString *className = NSStringFromClass([badgeView class]);
//                // Looking for _UIBadgeView
//                if ([className rangeOfString:@"BadgeView"].location != NSNotFound){
//                    badgeView.layer.transform = CATransform3DIdentity;
//                    badgeView.layer.transform = CATransform3DMakeTranslation(10, .5, .5);
//                    break;
//                }
//            }
        }
    }
}
//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
//    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
//    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
//    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
//    if (self.isHidden == NO) {
//        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
//        CGPoint newP = [self convertPoint:point toView:self.centerBtn];
//
//        //判断如果这个新的点是在发布按钮身上，那么处理点击事件最合适的view就是发布按钮
//        if ( [self.centerBtn pointInside:newP withEvent:event]) {
//            return self.centerBtn;
//        }else{//如果点不在发布按钮身上，直接让系统处理就可以了
//            return [super hitTest:point withEvent:event];
//        }
//    }
//    else {//tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
//        return [super hitTest:point withEvent:event];
//    }
//}

-(void)setCenterBtnIcon:(NSString *)centerBtnIcon{
    _centerBtnIcon = centerBtnIcon;
    [self.centerBtn setBackgroundImage:[UIImage imageNamed:self.centerBtnIcon] forState:UIControlStateNormal];
    [self.centerBtn setBackgroundImage:[UIImage imageNamed:self.centerBtnIcon] forState:UIControlStateHighlighted];
}
-(void)setCenterBtnTitle:(NSString *)centerBtnTitle{
    _centerBtnTitle = centerBtnTitle;
    self.centerlb.text = centerBtnTitle;
}
//调用代理方法
-(void)centerBtnClick:(UIButton *)btn{
    if ([self.samTabBarDelegate respondsToSelector:@selector(tabBar:clickCenterButton:)]) {
        [self.samTabBarDelegate tabBar:self clickCenterButton:self.centerBtn];
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
