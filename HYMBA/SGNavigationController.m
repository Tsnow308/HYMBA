//
//  SGNavigationController.m
//  HYMBA
//
//  Created by Tsnow on 2016/10/21.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import "SGNavigationController.h"
#import "UIBarButtonItem+SG.h"

@interface SGNavigationController ()

@end

@implementation SGNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navBar_bg_414x70"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.childViewControllers.count) {//隐藏导航栏
    
        viewController.hidesBottomBarWhenPushed = YES;
        
        //自定义返回按钮
        viewController.navigationItem.leftBarButtonItem =
        [UIBarButtonItem barButtonItemWithImage:@"back_9x16" highlightImage:nil targer:self action:@selector(back)];
        
        //如果自定义返回按钮后，滑动返回可能失效，需要添加下面的代码
        __weak typeof (viewController)Weakself = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)Weakself;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    
    // 判断两种情况：push 和 present
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1){
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }else [self popViewControllerAnimated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
