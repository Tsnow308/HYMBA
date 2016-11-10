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
#import "SGStudyViewController.h"
#import "SGFoundViewController.h"
#import "SGMeViewController.h"
#import "SGLoginViewController.h"

@interface SGTabBarViewController ()<UITabBarControllerDelegate>

@property (nonatomic,strong) SGLoginViewController *loginVC;

@property (nonatomic,assign) BOOL fromGuide;

@end

@implementation SGTabBarViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    [self setupBasic];
    
    [self setupNotification];
    
    // 判断用户是否登录
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:@"token"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPresentLoginViewNotification object:nil];
    }
    

}

- (void)setupBasic
{
   //首页
    [self addChildViewController:[[SGHomeViewController alloc]init] notmalimageNamed:@"toolbar_home" selectedImage:@"toolbar_home_sel" title:@"首页"];
   //学习
    [self addChildViewController:[[SGStudyViewController alloc]init] notmalimageNamed:@"toolbar_study" selectedImage:@"toolbar_study_sel" title:@"学习"];
   //订阅
    [self addChildViewController:[[SGFoundViewController alloc]init] notmalimageNamed:@"toolbar_discovery" selectedImage:@"toolbar_discovery_sel" title:@"发现"];
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

/**
 *设置监听
 */
- (void)setupNotification
{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:kPresentLoginViewNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:kUserDidLogoutNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:kJumpToHomeViewNotification object:nil];

}

- (void)handleNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:kPresentLoginViewNotification]) {
        
        [self showLoginView];
        
    }else if ([notification.name isEqualToString:kUserDidLogoutNotification]){
        
        [self showLoginView];
        
    }else if ([notification.name isEqualToString:kJumpToHomeViewNotification]){
    
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction1) userInfo:nil repeats:NO];
    
    }

}

- (void)showLoginView
{

    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.loginRegisterVC];
    
    [self presentViewController:nav animated:YES completion:^{
    }];
    if (_fromGuide) {
        _fromGuide = NO;
        [_loginVC.navigationController pushViewController:[[SGLoginViewController alloc] init] animated:NO];
    }

}

- (SGLoginViewController *)loginRegisterVC
{
//    __weak SGTabBarViewController *weakSelf = self;
    //    if (!_loginViewController) {
    //    _loginViewController = [[SGLoginAndRegisterViewController alloc] init];
    //    }
    
    _loginVC = [[SGLoginViewController alloc]init];
    
//    _loginViewController.onDismissButtonHandler = ^{
//        if (!weakSelf.noNeedGotoHomeView) {
//            weakSelf.selectedIndex = SGTabBarStatus_ASTHMACLUB;
//        }
//        
//    };
    
    return _loginVC;
}

- (void)timerAction1
{
    self.selectedIndex = SGTabBarStatus_HOME;
    [self.view setNeedsLayout];

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
