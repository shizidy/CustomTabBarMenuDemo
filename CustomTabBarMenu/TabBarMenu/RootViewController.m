//
//  RootViewController.m
//  CustomTabBarFrameWork
//
//  Created by wdyzmx on 2018/6/26.
//  Copyright © 2018年 wdyzmx. All rights reserved.
//

#import "RootViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "CustomTabBarController.h"

#define kscreenWidth [UIScreen mainScreen].bounds.size.width
#define kscreenHeight [UIScreen mainScreen].bounds.size.height

@interface RootViewController ()<UIAlertViewDelegate>{
    BOOL isLeftMenuShow;
    BOOL isRightMenuShow;
}
@property (nonatomic, strong)LeftViewController *leftVC;
@property (nonatomic, strong)RightViewController *rightVC;
@property (nonatomic, strong)CustomTabBarController *tabBarVC;
@property (nonatomic, assign)MenuStyle menuStyle;
@end

@implementation RootViewController

#pragma mark ========== init ==========
-(instancetype)initWithMenuStyle:(MenuStyle)style{
    if (self = [super init]) {
        self.menuStyle = style;
        isLeftMenuShow = NO;
        isRightMenuShow = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:self.leftVC];
    [self addChildViewController:self.rightVC];
    [self addChildViewController:self.tabBarVC];
    [self.view addSubview:self.leftVC.view];
    [self.view addSubview:self.rightVC.view];
    [self.view addSubview:self.tabBarVC.view];
    //添加拖动手势
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:panGR];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMenu:) name:@"showMenu" object:nil];
    // Do any additional setup after loading the view.
}
#pragma mark ========== 拖动手势事件 ==========
-(void)pan:(UIPanGestureRecognizer *)gesture{
    CGPoint point = [gesture translationInView:self.view];
    CGFloat offset_X = point.x;
    CGFloat margin = 80;
    CGFloat originX = self.tabBarVC.view.frame.origin.x;
    CGFloat rightX = kscreenWidth-margin;//self.view滑到最右边时的origin.x(如果允许leftMenu样式)
    CGFloat leftX = -kscreenWidth+margin;//self.view滑到最左边时的origin.x(如果允许rightMenu样式)
    CGFloat middleX = 0;//self.view在初始位置时的origin.x
    
    if (gesture.state==UIGestureRecognizerStateBegan) {
//        NSLog(@"开始拖动");
    }
    if (gesture.state==UIGestureRecognizerStateEnded) {
//        NSLog(@"结束拖动");
#pragma mark ========== 左侧菜单样式 ==========
        if (self.menuStyle==LeftMenuStyle) {
            isRightMenuShow = NO;
            if (isLeftMenuShow==NO) {//关闭
                if (originX>rightX/3) {
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(rightX, 0);
                    }];
                    isLeftMenuShow = YES;
                }else{
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                    }];
                    isLeftMenuShow = NO;
                }
            }else{//打开
                if (originX>rightX/3*2) {
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(rightX, 0);
                    }];
                    isLeftMenuShow = YES;
                }else{
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                    }];
                    isLeftMenuShow = NO;
                }
                
            }
        }
#pragma mark ========== 右侧菜单样式 ==========
        if (self.menuStyle==RightMenuStyle) {
            isLeftMenuShow = NO;
            if (isRightMenuShow==NO) {
                if (originX<-rightX/3) {
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(leftX, 0);
                    }];
                    isRightMenuShow = YES;
                }else{
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                    }];
                    isRightMenuShow = NO;
                }
            }else{
                if (originX<leftX+rightX/3) {
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(leftX, 0);
                    }];
                    isRightMenuShow = YES;
                }else{
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                    }];
                    isRightMenuShow = NO;
                }
            }
        }
#pragma mark ========== 左，右侧菜单都开启样式 ==========
        if (self.menuStyle==LeftandRightMenuStyle) {
            if (isLeftMenuShow==NO&&isRightMenuShow==NO) {
                
                if (originX<0&&originX<-rightX/3) {
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(leftX, 0);
                    }];
                    isRightMenuShow = YES;
                    isLeftMenuShow = NO;
                }else if (originX>0&&originX>rightX/3) {
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(rightX, 0);
                    }];
                    isLeftMenuShow = YES;
                    isRightMenuShow = NO;
                }
                else{
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                    }];
                    isLeftMenuShow = NO;
                    isRightMenuShow = NO;
                }
                
            }else if (isLeftMenuShow==NO&&isRightMenuShow==YES) {
                
                if (originX<leftX+rightX/3) {
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(leftX, 0);
                    }];
                    isRightMenuShow = YES;
                    isLeftMenuShow = NO;
                }else{
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                    }];
                    isRightMenuShow = NO;
                    isLeftMenuShow = NO;
                }
                
            }else if (isLeftMenuShow==YES&&isRightMenuShow==NO) {
                
                if (originX>rightX/3*2) {
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(rightX, 0);
                    }];
                    isLeftMenuShow = YES;
                    isRightMenuShow = NO;
                }else{
                    [UIView animateWithDuration:0.2 animations:^{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                    }];
                    isLeftMenuShow = NO;
                    isRightMenuShow = NO;
                }
            }else{
                
                
            }
        }
        
        
        
    }
    if (gesture.state==UIGestureRecognizerStateChanged) {
//        NSLog(@"正在拖动");
//        NSLog(@"%.1f", point.x);
#pragma mark ========== 只开启左边菜单样式 ==========
        if (self.menuStyle==LeftMenuStyle) {//只开启左边菜单样式
            [self.view insertSubview:self.leftVC.view aboveSubview:self.rightVC.view];
            if (isLeftMenuShow==NO) {//左边菜单关闭状态
                if (offset_X>0) {
                    if (originX<rightX) {
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(offset_X, 0);
                    }else{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(rightX, 0);
                    }
                }else{
                    self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                }
            }else {//打开状态
                if (offset_X<0) {
                    if (originX>middleX) {
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(rightX+offset_X, 0);
                    }else{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                    }
                }else{
                    self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(rightX, 0);
                }
            }
        }
#pragma mark ========== 只开启右边菜单样式 ==========
        if (self.menuStyle==RightMenuStyle) {//只开启右边菜单样式
            [self.view insertSubview:self.rightVC.view aboveSubview:self.leftVC.view];
            if (isRightMenuShow==NO) {//右边菜单关闭状态
                if (offset_X<0) {
                    if (originX>leftX) {
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(offset_X, 0);
                    }else{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(leftX, 0);
                    }
                }else{
                    self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                }
            }else{//打开状态
                if (offset_X>0) {
                    if (originX<middleX) {
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(leftX+offset_X, 0);
                    }else{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                    }
                }else{
                    self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(leftX, 0);
                }
            }
        }
#pragma mark ========== 左边,右边菜单都开启样式 ==========
        if (self.menuStyle==LeftandRightMenuStyle) {//左边,右边菜单都开启样式
            if (isLeftMenuShow==NO&&isRightMenuShow==NO) {//左右菜单关闭状态(这个地方要动态判断要显示的左，右菜单)
                if (originX<0) {//显示右边的菜单
                    [self.view insertSubview:self.rightVC.view aboveSubview:self.leftVC.view];
                }
                if (originX>0) {//显示左边的菜单
                    [self.view insertSubview:self.leftVC.view aboveSubview:self.rightVC.view];
                }
                
                if (originX<=leftX) {
                    self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(leftX, 0);
                }
                if (originX>=rightX) {
                    self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(rightX, 0);
                }
                if (originX>leftX&&originX<rightX) {
                    self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(offset_X, 0);
                }
            }else{//左（右）菜单打开状态
                //判断是左还是右菜单打开了
                if (isLeftMenuShow==YES&&isRightMenuShow==NO) {//左菜单打开，右菜单关闭
                    if (offset_X<0) {//向左滑
                        if (originX>middleX) {
                            self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(rightX+offset_X, 0);
                        }else{
                            self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                        }
                    }else{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(rightX, 0);
                    }
                }
                if (isLeftMenuShow==NO&&isRightMenuShow==YES) {//右菜单打开，左菜单关闭
                    if (offset_X>0) {//向右滑
                        if (originX<middleX) {
                            self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(leftX+offset_X, 0);
                        }else{
                            self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                        }
                    }else{
                        self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(leftX, 0);
                    }
                }
                
            }
        }
    }
}
#pragma mark ========== 通知 ==========
-(void)showMenu:(NSNotification *)noti{
    UIButton *button = (UIButton *)noti.object;
//    NSLog(@"=========%ld", button.tag);
    CGFloat margin = 80;
    CGFloat rightX = kscreenWidth-margin;//self.view滑到最右边时的origin.x(如果允许leftMenu样式)
    CGFloat leftX = -kscreenWidth+margin;//self.view滑到最左边时的origin.x(如果允许rightMenu样式)
    CGFloat middleX = 0;//self.view在初始位置时的origin.x
    if (button.tag==1) {
        if (self.menuStyle==RightMenuStyle) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"未开启左菜单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            alertView.alertViewStyle = UIAlertViewStyleDefault;
            [alertView show];
            
        }else{
            [self.view insertSubview:self.leftVC.view aboveSubview:self.rightVC.view];
            if (button.selected) {//menu打开
                [UIView animateWithDuration:0.2 animations:^{
                    self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(rightX, 0);
                }];
            }else{//关闭
                [UIView animateWithDuration:0.2 animations:^{
                    self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                }];
            }
        }
        
    }else{
        if (self.menuStyle==LeftMenuStyle) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"未开启右菜单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            alertView.alertViewStyle = UIAlertViewStyleDefault;
            [alertView show];
        }else{
            [self.view insertSubview:self.rightVC.view aboveSubview:self.leftVC.view];
            if (button.selected) {//menu打开
                [UIView animateWithDuration:0.2 animations:^{
                    self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(leftX, 0);
                }];
            }else{//关闭
                [UIView animateWithDuration:0.2 animations:^{
                    self.tabBarVC.view.transform = CGAffineTransformMakeTranslation(middleX, 0);
                }];
            }
        }
        
    }
    
    
}
#pragma mark ========== AlertViewDelegate ==========
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark ========== 懒加载 ==========
-(LeftViewController *)leftVC{
    if (_leftVC==nil) {
        _leftVC = [[LeftViewController alloc] init];
    }
    return _leftVC;
}
-(RightViewController *)rightVC{
    if (_rightVC==nil) {
        _rightVC = [[RightViewController alloc] init];
    }
    return _rightVC;
}

-(CustomTabBarController *)tabBarVC{
    if (_tabBarVC==nil) {
        _tabBarVC = [[CustomTabBarController alloc] init];
    }
    return _tabBarVC;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
