//
//  SGDiscoveryViewController.m
//  HYMBA
//
//  Created by Tsnow on 2016/10/21.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import "SGStudyViewController.h"
#import "SGMoviePlayVC.h"
#import <SDWebImageManager.h>
#import "SGStudyCell.h"



@interface SGStudyViewController ()<UITableViewDelegate,UITableViewDataSource>

- (IBAction)movieAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *testImage;
// 学习选择器模块
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedStudy;

// 学习tableView
@property (weak, nonatomic) IBOutlet UITableView *tableviewStudy;

// 选择器父视图
@property (weak, nonatomic) IBOutlet UIView *segmentedView;

// 下滑线
@property (weak, nonatomic) IBOutlet UILabel *underlineLabel;

@end

@implementation SGStudyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (self.segmentedStudy.selectedSegmentIndex) {
        [self.view layoutIfNeeded];
    }

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    if (self.segmentedStudy.selectedSegmentIndex == 0) {
        
        [self setupMainView];
        
    }

    // Do any additional setup after loading the view from its nib.
}

- (void)setupMainView
{
    self.segmentedStudy.tintColor = [UIColor clearColor];
    [self.segmentedStudy setTitleTextAttributes:@{NSForegroundColorAttributeName:SGColor(74, 74, 74),NSFontAttributeName:[UIFont systemFontOfSize:17]} forState:UIControlStateNormal];
    
    [self.segmentedStudy setTitleTextAttributes:@{NSForegroundColorAttributeName:SGColor(86, 199, 134)} forState:UIControlStateSelected];
    [self.segmentedStudy addTarget:self action:@selector(segmentedControlDidChange:) forControlEvents:UIControlEventAllEvents];
    
#pragma mark --设置学习TableView
    
    self.tableviewStudy.dataSource = self;
    self.tableviewStudy.delegate = self;
    
    self.tableviewStudy.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableviewStudy.backgroundColor = [UIColor clearColor];
    self.tableviewStudy.showsVerticalScrollIndicator = NO;
    self.tableviewStudy.showsHorizontalScrollIndicator = NO;
    [self.tableviewStudy setContentInset:UIEdgeInsetsMake(0, 0, 40, 0)];
    
    [self.tableviewStudy registerNib:[UINib nibWithNibName:@"SGStudyCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];

}

- (void)segmentedControlDidChange:(UISegmentedControl *)sender
{
    
    if (sender.selectedSegmentIndex == 0) {
        
        self.underlineLabel.frame = CGRectMake(0,self.segmentedView.frame.size.height-4,self.segmentedView.frame.size.width/2, 4);
            }
    
    if (sender.selectedSegmentIndex == 1) {
        
        self.underlineLabel.frame = CGRectMake(self.segmentedView.frame.size.width/2, self.segmentedView.frame.size.height-4, self.segmentedView.frame.size.width/2, 4);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --TableView代理

#pragma mark --UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SGStudyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SGMoviePlayVC *movieVC = [[SGMoviePlayVC alloc]init];
    NSURL *URL = [NSURL URLWithString:@"http://baobab.wdjcdn.com/14564977406580.mp4"];
    movieVC.videoURL = URL;
    
    [self.navigationController pushViewController:movieVC animated:YES];

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
