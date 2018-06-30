//
//  BaseViewController.m
//  CustomTabBarFrameWork
//
//  Created by wdyzmx on 2018/6/26.
//  Copyright © 2018年 wdyzmx. All rights reserved.
//

#import "BaseViewController.h"
#define kscreenWidth [UIScreen mainScreen].bounds.size.width
#define kscreenHeight [UIScreen mainScreen].bounds.size.height

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] init];
    backButtonItem.title = @"";
    //    backButtonItem.image = [UIImage imageNamed:@""];
    self.navigationItem.backBarButtonItem = backButtonItem;
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    button.center = CGPointMake(kscreenWidth/2, kscreenHeight/2);
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:button];
    
    // Do any additional setup after loading the view.
}
-(void)buttonClick:(UIButton *)btn{
//    SecondViewController *secondVC = [[SecondViewController alloc] init];
//    [secondVC setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:secondVC animated:YES];
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
