//
//  SGSubscriptionViewController.m
//  HYMBA
//
//  Created by Tsnow on 2016/10/21.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import "SGFoundViewController.h"
#import "SGPlayLiveViewController.h"
#import "SGHotModel.h"
#import "SGWatchLiveViewController.h"


@interface SGFoundViewController ()
- (IBAction)zhibo:(UIButton *)sender;

- (IBAction)guankan:(UIButton *)sender;
@end

@implementation SGFoundViewController

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

- (IBAction)zhibo:(UIButton *)sender {
    
    [self presentViewController:[[SGPlayLiveViewController alloc] init] animated:YES completion:nil];
}

- (IBAction)guankan:(UIButton *)sender {
    
    SGHotModel *hotModel = [[SGHotModel alloc] init];
    hotModel.flv = @"rtmp://192.168.2.60:1935/rtmplive/room";
    
    SGWatchLiveViewController *watchLive = [[SGWatchLiveViewController alloc]init];
//    watchLive.hotModel = hotModel;
    
    [self presentViewController:watchLive animated:YES completion:nil];
}
@end
