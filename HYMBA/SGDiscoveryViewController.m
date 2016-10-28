//
//  SGDiscoveryViewController.m
//  HYMBA
//
//  Created by Tsnow on 2016/10/21.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import "SGDiscoveryViewController.h"
#import "SGMoviePlayVC.h"
#import <SDWebImageManager.h>



@interface SGDiscoveryViewController ()
- (IBAction)movieAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *testImage;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedAction;

@end

@implementation SGDiscoveryViewController

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

- (IBAction)movieAction:(UIButton *)sender {
    
    SGMoviePlayVC *movieVC = [[SGMoviePlayVC alloc]init];
    NSURL *URL = [NSURL URLWithString:@"http://baobab.wdjcdn.com/14564977406580.mp4"];
    movieVC.videoURL = URL;
    
    [self.navigationController pushViewController:movieVC animated:YES];
    
}
@end
