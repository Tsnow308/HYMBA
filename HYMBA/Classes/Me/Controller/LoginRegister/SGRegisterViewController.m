//
//  RegisterViewController.m
//  HYMBA
//
//  Created by 尹雪松 on 2016/10/31.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGRegisterViewController.h"
#import "SGRegister.h"
#import "SGHttpTool.h"

@interface SGRegisterViewController ()<UITextFieldDelegate>
// 手机号码
@property (weak, nonatomic) IBOutlet UITextField *mobileNumber;
// 短信验证码
@property (weak, nonatomic) IBOutlet UITextField *mobileAuthCode;

// 短信验证按钮
@property (weak, nonatomic) IBOutlet UIButton *authcodeButton;
// 登录密码
@property (weak, nonatomic) IBOutlet UITextField *passWord;
//再次输入登录密码
@property (weak, nonatomic) IBOutlet UITextField *againPassWord;

@property (nonatomic,strong) NSTimer *countDownTimer;

// 获取短信验证码
- (IBAction)AuthCodeAction:(UIButton *)sender;

// 会员注册
- (IBAction)UserRegisterAction:(UIButton *)sender;

@end

@implementation SGRegisterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SetupMainView];
    // Do any additional setup after loading the view from its nib.
}

- (void)SetupMainView
{

#pragma mark --键盘类型设置代理
    self.mobileNumber.returnKeyType = UIReturnKeyDone;
    self.mobileAuthCode.returnKeyType = UIReturnKeyDone;
    self.passWord.returnKeyType = UIReturnKeyDone;
    self.againPassWord.returnKeyType = UIReturnKeyDone;

    self.mobileNumber.delegate = self;
    self.mobileAuthCode.delegate = self;
    self.passWord.delegate = self;
    self.againPassWord.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark  --获取短信验证码
//获取短信验证码
- (IBAction)AuthCodeAction:(UIButton *)sender {
    
    if([self.mobileNumber.text isEqualToString:@""]){
        
        [MBProgressHUD showError:@"请输入手机号码"];
      
    }else{
        
        //获取短信验证码接口
        NSString *messageAuthCodeStr = [NSString stringWithFormat:@"%@",@"http://192.168.11.29?r=users/smscode"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"mobile"] = self.mobileNumber.text;
        params[@"type"] = @1;
        
        NSLog(@"---------------%@",params);
        
        [SGHttpTool postWithURL:messageAuthCodeStr params:params success:^(id json) {
            NSLog(@"请求成功");
            NSLog(@"+++++++%@",json);
            NSLog(@"%@",[json objectForKey:@"message"]);
        } failure:^(NSError *error) {
            NSLog(@"请求失败");
            NSLog(@"----%@",error);
        }];
        
        //倒计时
        [self timeFireMethod];
        
    }
}


-(void)timeFireMethod{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.authcodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.authcodeButton.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //                NSLog(@"____%@",strTime);
                [self.authcodeButton setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                self.authcodeButton.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
    
}

- (IBAction)UserRegisterAction:(UIButton *)sender {
    NSLog(@"注册按钮");
    SGRegister *RegisterAction = [[SGRegister alloc] init];
    RegisterAction.completion = ^(NSDictionary *result, BOOL succ){
        
        if (succ) {
            if([[result objectForKey:@"code"] intValue]==1){
                
                [MBProgressHUD showSuccess:@"会员注册成功!"];
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            else{
                
                [MBProgressHUD showError:[result objectForKey:@"message"]];
            }
        }else{
            
            [MBProgressHUD showError:@"网络有问题!"];
        }
        
    };
    
    [RegisterAction registerWithMobile:self.mobileNumber.text password:self.againPassWord.text code:self.mobileAuthCode.text];
}
@end
