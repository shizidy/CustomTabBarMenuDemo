//
//  HomeViewController.m
//  CustomTabBarFrameWork
//
//  Created by wdyzmx on 2018/6/27.
//  Copyright © 2018年 wdyzmx. All rights reserved.
//

#import "HomeViewController.h"
#define kscreenWidth [UIScreen mainScreen].bounds.size.width
#define kscreenHeight [UIScreen mainScreen].bounds.size.height
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [self settingButtonItemWithTitle:@"左菜单" image:@"" tag:1];
    self.navigationItem.rightBarButtonItem = [self settingButtonItemWithTitle:@"右菜单" image:@"" tag:2];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    button.center = CGPointMake(kscreenWidth/2, kscreenHeight/2);
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:button];
    //改变push后返回键文字
    // 方式一
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    // 方式二
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
//    backButtonItem.image = [UIImage imageNamed:@""];
    self.navigationItem.backBarButtonItem = backButtonItem;
    //改变返回键颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}
-(UIBarButtonItem *)settingButtonItemWithTitle:(NSString *)title image:(NSString *)imageName tag:(NSInteger)tag{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonItemClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}
#pragma mark ========== buttonItem左右菜单点击事件 ==========
-(void)buttonItemClick:(UIButton *)btn{
    if (btn.selected==YES) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showMenu" object:btn];
}
-(void)buttonClick:(UIButton *)btn{
    UIViewController *uiVC = [[UIViewController alloc] init];
    uiVC.view.backgroundColor = [UIColor orangeColor];
    [uiVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:uiVC animated:YES];
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
