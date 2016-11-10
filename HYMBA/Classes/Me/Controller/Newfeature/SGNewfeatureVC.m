//
//  SGNewfeatureVC.m
//  HYMBA
//
//  Created by 尹雪松 on 2016/10/31.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGNewfeatureVC.h"
#import "SGTabBarViewController.h"
#import "SGLoginRegisterVC.h"
#import "SGLoginViewController.h"
#define NewfeatureImageCount 3

@interface SGNewfeatureVC ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,strong) SGLoginRegisterVC *loginRegisterVC;


@end

@implementation SGNewfeatureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupScrollView];
    // Do any additional setup after loading the view from its nib.
}

/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
    self.scrollView.frame = [UIScreen mainScreen].bounds;
    self.scrollView.delegate = self;
    
    //添加图片
    CGFloat imageW = MW;
    CGFloat imageH = MH;
    for (int index = 0; index<NewfeatureImageCount; index++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        
        //设置图片
        NSString *name = nil;
        if (fourInch) { // 4inch
            name = [NSString stringWithFormat:@"new_feature_%d-568h", index + 1];
        } else {
            name = [NSString stringWithFormat:@"new_feature_%d",index+1];
        }
        
        imageView.image = [UIImage imageWithName:name];
        
        //设置frame
        CGFloat imageX = index *imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [self.scrollView addSubview:imageView];
        
        //在最后一张图片上加按钮
        if (index == NewfeatureImageCount-1) {
            
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.设置滚动的内容尺寸
    self.scrollView.contentSize = CGSizeMake(imageW * NewfeatureImageCount, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  添加内容到最后一个图片
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 0.让imageView能跟用户交互
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 2.设置frame
    CGFloat centerX = imageView.frame.size.width * 0.5;
    CGFloat centerY = imageView.frame.size.height * 0.6;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    
    // 3.设置文字
    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
   }

/**
 *  开始
 */
- (void)start
{
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    
   UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[SGLoginViewController alloc]init]];
    
    [self presentViewController:nav animated:YES completion:^{
    }];
    // 切换窗口的根控制器
    self.view.window.rootViewController = [[SGTabBarViewController alloc] init];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:kPresentLoginViewNotification object:nil];
    
}


/**
 *  只要UIScrollView滚动了,就会调用
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 2.求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
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
