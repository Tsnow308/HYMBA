//
//  SGWeixinBoundMobileVC.m
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/4.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGWeixinBoundMobileVC.h"
#import "SGLoginHttp.h"

@interface SGWeixinBoundMobileVC ()

//绑定手机号
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberField;

//短信验证码
@property (weak, nonatomic) IBOutlet UITextField *mobileAuthCode;

//短信获取按钮
@property (weak, nonatomic) IBOutlet UIButton *authcodeButton;

@property (nonatomic,strong) NSTimer *countDownTimer;

//短信获取
- (IBAction)AuthCodeAction:(UIButton *)sender;

//发送
- (IBAction)sendAction:(UIButton *)sender;

@end

@implementation SGWeixinBoundMobileVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@".....................%@",self.messageDic);

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

- (IBAction)sendAction:(UIButton *)sender {
    
    NSLog(@".....................%@",self.messageDic);

    if ([self.mobileNumberField.text isEqualToString:@""]) {
        
        [MBProgressHUD showError:@"请输入手机号码"];
        
    } else {
        
        SGLoginHttp *loginHttpAction = [[SGLoginHttp alloc]init];
       loginHttpAction.completion = ^(NSDictionary *result, BOOL succ){
            
            if (succ) {
                if([[result objectForKey:@"code"] isEqualToString:@"1"]){
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }
                else{
                    
                    [MBProgressHUD showMessage:[result objectForKey:@"message"]];
                }
            }else{
                
                [MBProgressHUD showError:@"网络有问题"];
            }
            
        };
        
        [loginHttpAction weixinBoundMobile:self.mobileNumberField.text openid:self.messageDic[@"openid"] code:self.messageDic[@"code"] avatar:self.messageDic[@"avatar"] nickname:self.messageDic[@"nickname"] gender:self.messageDic[@"gender"]];

    }
    
}
- (IBAction)AuthCodeAction:(UIButton *)sender {
    
    if([self.mobileNumberField.text isEqualToString:@""]){
        
        [MBProgressHUD showError:@"请输入手机号码"];
        
    }else{
        //获取短信验证码接口
                SGLoginHttp *RegisterAuthCode = [[SGLoginHttp alloc] init];
                RegisterAuthCode.completion = ^(NSDictionary *result, BOOL succ){
        
                    if (succ) {
                            if([[result objectForKey:@"code"] intValue]==1){
        
                                        [_countDownTimer invalidate];
        
                                        [_authcodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        
                                    }
                                    else{
        
                                        [MBProgressHUD showError:[result objectForKey:@"message"]];
                                    }
                    }else{
        
                        [MBProgressHUD showError:@"网络有问题"];
                    }
        
                };
                [RegisterAuthCode authCodeWithMobile:self.mobileNumberField.text type:@"1"];
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

@end
