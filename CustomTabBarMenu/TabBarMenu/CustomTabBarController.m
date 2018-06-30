//
//  CustomTabBarController.m
//  CustomTabBarFrameWork
//
//  Created by wdyzmx on 2018/6/26.
//  Copyright © 2018年 wdyzmx. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomTabBar.h"
#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"

@interface CustomTabBarController ()<SamTabBarDelegate>
@property (nonatomic, strong)HomeViewController *homeVC;
@end

@implementation CustomTabBarController
#pragma mark ========== 初始化操作 ==========
//+(void)initialize{
//    //未选择状态下
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    //选择状态下
//    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
//    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    selectedAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
//    //取到TabBarItem的appearance
//    UITabBarItem *item = [UITabBarItem appearance];
//    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
//    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}
-(void)setupUI{
    //kvc添加自定义tabBar
    
    CustomTabBar *samTabBar = [[CustomTabBar alloc] initWithFrame:self.tabBar.frame samItemNum:SamItemNum_Five];
    samTabBar.centerBtnTitle = @"";
    samTabBar.centerBtnIcon = @"";
    samTabBar.samTabBarDelegate = self;
    //kvc添加tabBar
    [self setValue:samTabBar forKey:@"tabBar"];
//    samTabBar.barTintColor = [UIColor purpleColor];
    //
    //去除顶部很丑的border
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    
    //自定义分割线颜色
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(self.tabBar.bounds.origin.x-0.5, self.tabBar.bounds.origin.y, self.tabBar.bounds.size.width+1, self.tabBar.bounds.size.height+2)];
    bgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    bgView.layer.borderWidth = 0.5;
    [samTabBar insertSubview:bgView atIndex:0];
    samTabBar.opaque = YES;
    
    [self setupVC];
}
#pragma mark ========== SamTabBarDelegate ==========
-(void)tabBar:(CustomTabBar *)tabBar clickCenterButton:(UIButton *)btn{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击了中间按钮" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)setupVC{
    [self addChildVc:self.homeVC title:@"首页" image:@"" selectedImage:@""];
    [self addChildVc:[[BaseViewController alloc] init] title:@"发现" image:@"" selectedImage:@""];
    [self addChildVc:[[BaseViewController alloc] init] title:@"消息" image:@"" selectedImage:@""];
    [self addChildVc:[[BaseViewController alloc] init] title:@"个人中心" image:@"" selectedImage:@""];
}

-(void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字的样式
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];
    // 为子控制器包装导航控制器
    BaseNavigationController *navigationVc = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    
    // 添加子控制器
    [self addChildViewController:navigationVc];
}
#pragma mark ========== 懒加载 ==========
-(HomeViewController *)homeVC{
    if (_homeVC==nil) {
        _homeVC = [[HomeViewController alloc] init];
    }
    return _homeVC;
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
