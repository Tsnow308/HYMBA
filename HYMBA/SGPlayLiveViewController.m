//
//  SGPlayLiveViewController.m
//  HYMBA
//
//  Created by Tsnow on 2016/10/22.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import "SGPlayLiveViewController.h"
#import "LFLiveKit.h"


@interface SGPlayLiveViewController ()<LFLiveSessionDelegate>
@property (weak, nonatomic) IBOutlet UIButton *livingBtn;
@property (weak, nonatomic) IBOutlet UIButton *switchBtn;

- (IBAction)beginLive:(UIButton *)sender;

/** RTMP地址*/
@property (nonatomic,copy) NSString *rtmpUrl;
@property (nonatomic,strong) LFLiveSession *session;
@property (nonatomic,weak) UIView *livingPreView;

@end

@implementation SGPlayLiveViewController

- (UIView *)livingPreView
{
    if (_livingPreView == nil){
        UIView *livingPreView = [[UIView alloc] initWithFrame:self.view.bounds];
        livingPreView.backgroundColor = [UIColor clearColor];
        [self.view insertSubview:livingPreView atIndex:0];
        _livingPreView = livingPreView;
    }
    return _livingPreView;
}

- (LFLiveSession *)session
{
    if (_session == nil) {
        
        _session = [[LFLiveSession alloc]initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Default] liveType:LFLiveRTMP];
    }
    
    // 设置代理
    _session.delegate = self;
    _session.running = YES;
    _session.preView = self.livingPreView;
   
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupBasic
{
    
    self.livingBtn.backgroundColor = XLBasicColor;
    self.livingBtn.layer.cornerRadius = self.livingBtn.height * 0.5;
    self.livingBtn.layer.masksToBounds = YES;
    
    //默认开启前置摄像头
    self.session.captureDevicePosition = AVCaptureDevicePositionFront;
    
}
- (IBAction)switchBtn:(UIButton *)sender {
    
    if (![self beginClick]) return;
    
    sender.selected = !sender.selected;
    
    if (sender.selected){
        
        self.session.captureDevicePosition = AVCaptureDevicePositionBack;
    }else{
        
        self.session.captureDevicePosition = AVCaptureDevicePositionFront;
    }

}

- (BOOL)beginClick
{
    //判断是否是模拟器
    if ([[UIDevice deviceVersion] isEqualToString:@"iPhone Simulator"]) {
        
//        [MBProgressHUD showMessage:@"请用真机进行测试, 此模块不支持模拟器测试"];
          [MBProgressHUD showError:@"请用真机进行测试, 此模块不支持模拟器测试"];
        return NO;
    }
    
    //判断是否有摄像头
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        [MBProgressHUD showAlertMessage:@"您的设备没有摄像头或者相关的驱动, 不能进行直播"];
        return NO;
    }
    
    //判断是否有摄像头权限
    AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied)
    {
        [MBProgressHUD showAlertMessage:@"app需要访问您的摄像头。\n请启用摄像头-设置/隐私/摄像头"];
        
        return NO;
    }
    
    // 开启麦克风权限
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                return YES;
            }
            else {
                [MBProgressHUD showAlertMessage:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"];
                return NO;
            }
        }];
    }
    
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

- (IBAction)beginLive:(id)sender {
    
    if (![self beginClick]) return;
    
    self.livingBtn.selected = !self.livingBtn.selected;
    if (self.livingBtn.selected) {//开始直播
        LFLiveStreamInfo *stream = [LFLiveStreamInfo new];
        //直播室地址
        stream.url = RoomUrl;
        self.rtmpUrl = stream.url;
        [self.session startLive:stream];
    }else{//结束直播
        [self.session stopLive];
        
    
    }
}

#pragma mark -- LFStreamingSessionDelegate
/** live status changed will callback */
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    NSString *tempStatus;
    switch (state) {
        case LFLiveReady:
            tempStatus = @"准备中";
            break;
        case LFLivePending:
            tempStatus = @"连接中";
            break;
        case LFLiveStart:
            tempStatus = @"已连接";
            break;
        case LFLiveStop:
            tempStatus = @"已断开";
            break;
        case LFLiveError:
            tempStatus = @"连接出错";
            break;
        default:
            break;
    }
//    self.statusLabel.text = [NSString stringWithFormat:@"状态: %@\nRTMP: %@", tempStatus, self.rtmpUrl];
}

/** live debug info callback */
- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug*)debugInfo{
    
}

/** callback socket errorcode */
- (void)liveSession:(nullable LFLiveSession*)session errorCode:(LFLiveSocketErrorCode)errorCode{
    
}


@end
