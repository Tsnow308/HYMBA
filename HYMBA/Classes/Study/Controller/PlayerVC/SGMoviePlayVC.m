//
//  SGMoviePlayViC.m
//  HYMBA
//
//  Created by 尹雪松 on 2016/10/27.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import "SGMoviePlayVC.h"
#import "ZFPlayer.h"
#import <MediaPlayer/MediaPlayer.h>
#import <ZFDownload/ZFDownloadManager.h>
#import <AVFoundation/AVFoundation.h>
#import <ZFDownload/ZFDownloadManager.h>
#import <UINavigationController+FDFullscreenPopGesture.h>


@interface SGMoviePlayVC ()<ZFPlayerDelegate>

@property (weak,nonatomic)IBOutlet ZFPlayerView *playerView;
/** 离开页面时候是否在播放 */
@property (nonatomic,assign) BOOL isPlaying;
@property (nonatomic,strong) ZFPlayerModel *playerModel;


@end

@implementation SGMoviePlayVC

- (void)dealloc
{
//    NSLog(@"%@释放了",self.class);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    // pop 回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playerView
        && self.isPlaying) {
        self.isPlaying = NO;
        [self.playerView play];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[UIApplication sharedApplication] setStatusBarStyle:
//     UIStatusBarStyleDefault animated:YES];
    [UIApplication sharedApplication].statusBarStyle =
    UIStatusBarStyleDefault;
    //push出下一级页面时候暂停
    if (self.navigationController.viewControllers.count == 3 && self.playerView
        && self.playerView.isPauseByUser) {
        self.isPlaying = YES;
        [self.playerView pause];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 指定控制层
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc]init];
    self.playerView.controlView = controlView;
    self.playerView.playerModel = self.playerModel;
    
    //设置代理
    self.playerView.delegate = self;
    
    //打开下载功能（默认没有这个功能）
    self.playerView.hasDownload = YES;
    //打开预览图
    self.playerView.hasPreviewView = YES;
    
    //是否自动播放，默认不自动播放
    [self.playerView autoPlayTheVideo];
    
    
    // Do any additional setup after loading the view from its nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -ZFPlayerDelegate

- (void)zf_playerBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)zf_playerDownload:(NSString *)url
{
    // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
    NSString *name = [url lastPathComponent];
    [[ZFDownloadManager sharedDownloadManager] downFileUrl:url filename:name fileimage:nil];
    // 设置最多同时下载个数（默认是3）
    [ZFDownloadManager sharedDownloadManager].maxCount = 1;

}

#pragma mark - 转屏相关

// 是否自动转屏
- (BOOL)shouldAutorotate
{
   //调节ZFPlayerSingleton单例记录播放状态是否锁定屏幕方向
    return !ZFPlayerShared.isLockScreen;
}

// 支持哪些转屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

// 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法）
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.fd_interactivePopDisabled = NO;
        //if use Masonry,Please open this annotation
        /*
         [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.view).offset(20);
         }];
         */
    }else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        self.view.backgroundColor = [UIColor blackColor];
        self.fd_interactivePopDisabled = YES;
        //if use Masonry,Please open this annotation
        /*
         [self.playerView mas_updateConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.view).offset(0);
         }];
         */
    }
}

- (ZFPlayerModel *)playerModel
{
    if (!_playerModel) {
        _playerModel = [[ZFPlayerModel alloc]init];
        _playerModel.title = @"哈中少商";
        _playerModel.videoUrl = self.videoURL.absoluteString;
        _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
    }
    return _playerModel;
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
