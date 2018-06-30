//
//  DiscoveryViewController.m
//  CustomTabBarMenu
//
//  Created by wdyzmx on 2018/6/30.
//  Copyright © 2018年 wdyzmx. All rights reserved.
//

#import "DiscoveryViewController.h"
#define kscreenWidth [UIScreen mainScreen].bounds.size.width
#define kscreenHeight [UIScreen mainScreen].bounds.size.height
@interface DiscoveryViewController ()

@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
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
