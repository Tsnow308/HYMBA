//
//  LoginViewController.m
//  HYMBA
//
//  Created by 尹雪松 on 2016/10/31.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGLoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "SGRegisterViewController.h"
#import "SGLoginHttp.h"
#import "SGWeixinBoundMobileVC.h"
#import "SGForgetPasswordVC.h"
#import "SGAccount.h"
#import "SGAccountTool.h"


#define UMSUserInfoPlatformTypeKey @"UMSUserInfoPlatformTypeKey"
#define UMSUserInfoPlatformNameKey @"UMSUserInfoPlatformNameKey"
#define UMSUserInfoPlatformIconNameKey @"UMSUserInfoPlatformIconNameKey"

@interface SGLoginViewController ()<UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *platformInfoArray;
//会员手机号
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberField;
//会员密码
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

// 会员登录
- (IBAction)userLoginAction:(UIButton *)sender;

//微信登录
- (IBAction)weixinLoginAction:(UIButton *)sender;
//注册跳转
- (IBAction)registerAction:(UIButton *)sender;
//忘记密码跳转
- (IBAction)forgetPasswordAction:(UIButton *)sender;

@end

@implementation SGLoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SetupMainView];
    
//    self.platformInfoArray = [NSMutableArray arrayWithCapacity:10];
//    
//    NSArray *paltformTypeArray = [NSArray arrayWithObjects:@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ), nil];
//    
//    for (NSNumber *platformType in paltformTypeArray) {
//        NSMutableDictionary *dict = [self dictWithPlatformName:platformType];
//        [dict setValue:platformType forKey:UMSUserInfoPlatformTypeKey];
//        if (dict) {
//            [self.platformInfoArray addObject:dict];
//        }
//    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)SetupMainView
{
    
#pragma mark --键盘类型设置代理
        self.mobileNumberField.returnKeyType = UIReturnKeyDone;
        self.passwordField.returnKeyType = UIReturnKeyDone;

  
        self.mobileNumberField.delegate = self;
        self.passwordField.delegate = self;

    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableDictionary *)dictWithPlatformName:(NSNumber *)platformType
{
    UMSocialPlatformType platformType_int = [platformType integerValue];
    NSString *imageName = nil;
    NSString *paltFormName = nil;
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:1];
    switch (platformType_int) {
        case UMSocialPlatformType_Sina:
            imageName = @"UMS_sina_icon";
            paltFormName = @"新浪";
            break;
        case UMSocialPlatformType_WechatSession:
            imageName = @"UMS_wechat_icon";
            paltFormName = @"微信";
            break;
        case UMSocialPlatformType_QQ:
            imageName = @"UMS_qq_icon";
            paltFormName = @"QQ";
            break;
            
        default:
            break;
    }
    [dict setValue:UMSocialPlatformIconWithName(imageName) forKey:UMSUserInfoPlatformIconNameKey];
    [dict setValue:paltFormName forKey:UMSUserInfoPlatformNameKey];
    return dict;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark --微信登录
- (IBAction)weixinLoginAction:(UIButton *)sender {
    
//    NSDictionary *dict = self.platformInfoArray[2];
//    UMSocialPlatformType platformType = [[dict objectForKey:UMSUserInfoPlatformTypeKey] integerValue];
    
    //如果需要获得用户信息直接跳转的话，需要先取消授权
    //step1 取消授权
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_WechatSession completion:^(id result, NSError *error) {
        
        //step2 获得用户信息(获得用户信息中包含检查授权的信息了)
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
            
            NSString *message = nil;
            NSMutableDictionary *messageDic = [NSMutableDictionary dictionary];
            
            if (error) {
                message = @"Get user info fail";
                NSLog(@"Get user info fail with error %@",error);
            }else{
                if ([result isKindOfClass:[UMSocialUserInfoResponse class]]) {
                    UMSocialUserInfoResponse *resp = result;
                    // 授权信息
                    NSLog(@"UserInfoAuthResponse uid: %@", resp.uid);
                    NSLog(@"UserInfoAuthResponse accessToken: %@", resp.accessToken);
                    NSLog(@"UserInfoAuthResponse refreshToken: %@", resp.refreshToken);
                    NSLog(@"UserInfoAuthResponse expiration: %@", resp.expiration);
                    
                    // 用户信息
                    NSLog(@"UserInfoResponse name: %@", resp.name);
                    NSLog(@"UserInfoResponse iconurl: %@", resp.iconurl);
                    NSLog(@"UserInfoResponse gender: %@", resp.gender);
                    
                    // 存储信息
                    messageDic[@"openid"] = resp.openid;
                    messageDic[@"nickname"] = resp.name;
                    messageDic[@"avatar"] = resp.iconurl;
                    messageDic[@"gender"] = resp.gender;
                    
                    // 第三方平台SDK源数据,具体内容视平台而定
                    NSLog(@"OriginalUserProfileResponse: %@", resp.originalResponse);
                    
                    message = [NSString stringWithFormat:@"name: %@\n icon: %@\n gender: %@\n",resp.name,resp.iconurl,resp.gender];
                }else{
                    message = @"Get user info fail";
                    NSLog(@"Get user info fail with  unknow error");
                }
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UserInfo"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                                  otherButtonTitles:nil];
            [alert show];
            
#pragma mark -- 微信回调后向自己服务器第一次发送
            
            [self weixincallbackWithMessage:messageDic];
            
            
        }];
    }];
    
}

- (IBAction)registerAction:(UIButton *)sender {
    
    [self.navigationController pushViewController:[[SGRegisterViewController alloc]init] animated:YES];
    
}

- (IBAction)forgetPasswordAction:(UIButton *)sender {
    
    [self.navigationController pushViewController:[[SGForgetPasswordVC alloc]init] animated:YES];
}
- (IBAction)userLoginAction:(UIButton *)sender {
    
    SGLoginHttp *LoginHttpAction = [[SGLoginHttp alloc] init];
    LoginHttpAction.completion = ^(NSDictionary *result, BOOL succ){
        
        if (succ) {
            if([[result objectForKey:@"code"] intValue]==1){
                
                [MBProgressHUD showSuccess:@"会员登录成功!"];
                
                
                [self dismissViewControllerAnimated:YES completion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:kJumpToHomeViewNotification object:nil];
            }
            else{
                
                [MBProgressHUD showError:[result objectForKey:@"message"]];
            }
        }else{
            
            [MBProgressHUD showError:@"网络有问题!"];
        }
        
    };
    
    [LoginHttpAction loginWithMobile:self.mobileNumberField.text password:self.passwordField.text];
    
}


-(void)weixincallbackWithMessage:(NSMutableDictionary *)message
{

      NSLog(@"_______%@",message);
    SGLoginHttp *LoginHttpAction = [[SGLoginHttp alloc] init];
    LoginHttpAction.completion = ^(NSDictionary *result, BOOL succ){
        
        if (succ) {
            if([[result objectForKey:@"code"] intValue]==1){
                
                [MBProgressHUD showSuccess:@"微信会员登录成功!"];
                NSLog(@"?????????????%@",result);
                
                if ([result[@"message"] isEqualToString:@"该用户未绑定手机号"]) {
                    
                    SGWeixinBoundMobileVC *weixinBund = [[SGWeixinBoundMobileVC alloc]init];
                    weixinBund.messageDic = message;
                    
                    [self.navigationController pushViewController:weixinBund animated:YES];
                    
                } else {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                
               
            }
            else{
                
                [MBProgressHUD showError:[result objectForKey:@"message"]];
            }
        }else{
            
            [MBProgressHUD showError:@"网络有问题!"];
        }
        
    };
    
    
    [LoginHttpAction weixinLoginWith:message[@"openid"] nickname:message[@"nickname"] avatar:message[@"avatar"] gender:message[@"gender"]];
    
}

// 保存用户信息
- (void)saveUserInfo:(NSDictionary *)result
{
    SGAccount *account = [[SGAccount alloc]init];
    account.userId = result[@"userId"];
    account.userName = result[@"userName"];
    account.userType = result[@"userType"];
    account.mobile = result[@"mobile"];
    account.avatar = result[@"avatar"];
    account.gender = result[@"gender"];
    account.nickname = result[@"nickname"];
    [SGAccountTool saveAccount:account];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:account.userId forKey:@"userId"];
    [userDefaults setObject:account.avatar forKey:@"avatar"];
    
}

@end
