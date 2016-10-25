//
//  SGWatchLiveViewController.m
//  HYMBA
//
//  Created by Tsnow on 2016/10/22.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import "SGWatchLiveViewController.h"
#import "UIViewController+Extension.h"
#import "NSSafeObject.h"

@interface SGWatchLiveViewController ()

/** 直播播放器*/
@property (nonatomic,strong) IJKFFMoviePlayerController *moviePlayer;

/** 直播开始前的占位图片 */
@property(nonatomic, weak) UIImageView *placeHolderView;

/** 计时器 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SGWatchLiveViewController

//- (instancetype)init
//{
//    if (self == [super init]){
//        
//        NSSafeObject * safeObj = [[NSSafeObject alloc]initWithObject:self withSelector:@selector(autoSendBarrage)];
//        
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:safeObj selector:@selector(excute) userInfo:nil repeats:YES];
//    }
//    return self;
//}


- (void)setHotModel:(SGHotModel *)hotModel
{
    _hotModel = hotModel;
    
    [self plarFLV:hotModel.flv placeHolderUrl:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.moviePlayer.view];

    // Do any additional setup after loading the view from its nib.
}

- (UIImageView *)placeHolderView
{
    if (_placeHolderView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = self.view.bounds;
        
        imageView.image = [UIImage imageNamed:@"profile_user_414x414"];
        
        [self.view addSubview:imageView];
        [self showGifLoding:nil inView:imageView];
        _placeHolderView = imageView;
        // 强制布局
        [_placeHolderView layoutIfNeeded];
    }
    return _placeHolderView;
}

#pragma mark - private method
- (void)plarFLV:(NSString *)flv placeHolderUrl:(NSString *)placeHolderUrl
{
    NSLog(@"------+++++++%@",flv);
    
    if (_moviePlayer) {
        if (_moviePlayer) {
            [self.view insertSubview:self.placeHolderView aboveSubview:self.moviePlayer.view];
        }
       
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:nil] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __weak typeof(self) weakSelf = self;
            
            if(image){
                [weakSelf showGifLoding:nil inView:weakSelf.placeHolderView];
                weakSelf.placeHolderView.image = [UIImage blurImage:image blur:0.8];
            }
        });
    }];

    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
    
    // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97）
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    // 3.2 创建播放控制器
    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:RoomUrl withOptions: options];
    self.moviePlayer = moviePlayer;
    self.moviePlayer.view.frame = self.view.bounds;
    // 填充fill
    moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
    // 4.2 设置适配横竖屏(设置四边固定,长宽灵活)
    self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    //  4.3 设置播放视图的缩放模式
    self.moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFit;
    moviePlayer.shouldAutoplay = YES;
    
//    [self.view insertSubview:moviePlayer.view atIndex:0];
    //  4.5 自动更新子视图的大小
    self.view.autoresizesSubviews = YES;
    //  4.6 添加播放视图到控制器的View
    [self.view addSubview:self.moviePlayer.view];
    
//    [moviePlayer prepareToPlay];
//    
//    
//    
//    self.moviePlayer.view.backgroundColor = [UIColor grayColor];
//    self.view = self.moviePlayer.view;
    
    // 设置监听
//    [self initObserver];

}

- (void)initObserver
{
    [self.moviePlayer play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewWillDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    //  关闭播放
    [self.moviePlayer shutdown];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self plarFLV:nil placeHolderUrl:nil];    //  当试图即将展示的时候开始播放
    [self.moviePlayer prepareToPlay];
    
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
