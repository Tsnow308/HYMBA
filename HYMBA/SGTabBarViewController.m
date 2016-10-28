//
//  SGTabBarViewController.m
//  HYMBA
//
//  Created by Tsnow on 2016/10/21.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import "SGTabBarViewController.h"
#import "SGNavigationController.h"
#import "SGHomeViewController.h"
#import "SGDiscoveryViewController.h"
#import "SGSubscriptionViewController.h"
#import "SGMeViewController.h"

@interface SGTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation SGTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    [self setupBasic];
}

- (void)setupBasic
{
    //首页
    [self addChildViewController:[[SGHomeViewController alloc]init] notmalimageNamed:@"toolbar_home" selectedImage:@"toolbar_home_sel" title:@"首页"];
    //学习
    [self addChildViewController:[[SGDiscoveryViewController alloc]init] notmalimageNamed:@"toolbar_study" selectedImage:@"toolbar_study_sel" title:@"学习"];
    //订阅
    [self addChildViewController:[[SGSubscriptionViewController alloc]init] notmalimageNamed:@"toolbar_discovery" selectedImage:@"toolbar_discovery_sel" title:@"发现"];
    //我的
    [self addChildViewController:[[SGMeViewController alloc]init] notmalimageNamed:@"toolbar_me" selectedImage:@"toolbar_me_sel" title:@"我的"];
}

- (void)addChildViewController:(UIViewController *)childController notmalimageNamed:(NSString *)imageName
                 selectedImage:(NSString *)selectedImageName title:(NSString *)title
{
    SGNavigationController *nav = [[SGNavigationController alloc] initWithRootViewController:childController];
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childController.title = title;
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :XLNormalColor} forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :XLSelectedColor} forState:UIControlStateSelected];

    [self addChildViewController:nav];
}

#pragma mark 代理方法
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
//    if ([viewController.tabBarItem.image isEqual:[UIImage imageNamed:@"toolbar_live"]]) {
//        
//        [self presentViewController:[....] animated:YES completion:nil];
//        return NO;
//    }

    return YES;
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
