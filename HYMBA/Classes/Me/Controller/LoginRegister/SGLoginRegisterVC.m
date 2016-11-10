//
//  LoginRegisterVC.m
//  HYMBA
//
//  Created by 尹雪松 on 2016/10/31.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGLoginRegisterVC.h"
#import "SGLoginViewController.h"
#import "SGRegisterViewController.h"

@interface SGLoginRegisterVC ()<UITextFieldDelegate>

//登录跳转
- (IBAction)loginAction:(UIButton *)sender;

//注册跳转
- (IBAction)registerAction:(UIButton *)sender;

//微信登录
- (IBAction)weixinLogin:(UIButton *)sender;

@end

@implementation SGLoginRegisterVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)loginAction:(UIButton *)sender {
    
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[SGLoginViewController alloc]init]];
    
    [self.navigationController pushViewController:[[SGLoginViewController alloc]init] animated:YES];
}

- (IBAction)registerAction:(UIButton *)sender {
    
    [self.navigationController pushViewController:[[SGRegisterViewController alloc]init] animated:YES];
}

- (IBAction)weixinLogin:(UIButton *)sender {
    
    
    // 微信登录
}
@end
