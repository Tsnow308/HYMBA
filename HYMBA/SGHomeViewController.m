//
//  SGHomeViewController.m
//  HYMBA
//
//  Created by Tsnow on 2016/10/21.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import "SGHomeViewController.h"
#import "SGRecommendCell.h"
#import "SGTeacherCell.h"
#import "SGSubscribeCell.h"
#import "SGCourseCell.h"

@interface SGHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

//首页TableView
@property (weak, nonatomic) IBOutlet UITableView *HomeTableView;
//广告头视图-表头
@property (strong, nonatomic) IBOutlet UIView *ADHeadView;
//第一分区表头
@property (strong, nonatomic) IBOutlet UIView *Head1;
//第二分区表头
@property (strong, nonatomic) IBOutlet UIView *Head2;
//第三分区表头
@property (strong, nonatomic) IBOutlet UIView *Head3;
//第四分区表头
@property (strong, nonatomic) IBOutlet UIView *Head4;

@end

@implementation SGHomeViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SetupMainView];
    
}

-(void)SetupMainView
{
    self.HomeTableView.dataSource = self;
    self.HomeTableView.delegate = self;
    
    self.HomeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.HomeTableView.backgroundColor = [UIColor clearColor];
    self.HomeTableView.showsVerticalScrollIndicator = NO;
    self.HomeTableView.showsHorizontalScrollIndicator = NO;
    [self.HomeTableView setContentInset:UIEdgeInsetsMake(0, 0, 30, 0)];

    self.HomeTableView.tableHeaderView = self.ADHeadView;
    
    //热门推荐
    [self.HomeTableView registerNib:[UINib nibWithNibName:@"SGRecommendCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    //权威导师
    [self.HomeTableView registerNib:[UINib nibWithNibName:@"SGTeacherCell" bundle:nil] forCellReuseIdentifier:@"cell2"];

    //专栏订阅
    [self.HomeTableView registerNib:[UINib nibWithNibName:@"SGSubscribeCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    
    //课程
    [self.HomeTableView registerNib:[UINib nibWithNibName:@"SGCourseCell" bundle:nil] forCellReuseIdentifier:@"cell4"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--UITableViewDataSource   UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    
    return 1;

}

//cell内容选择设置
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        SGRecommendCell *cell1 = [self.HomeTableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        
        return cell1;

    }else if (indexPath.section == 1)
    {
        SGTeacherCell *cell2 = [self.HomeTableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        return cell2;
    
    }else if (indexPath.section == 2)
    {
        SGSubscribeCell *cell3 = [self.HomeTableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        return cell3;
        
    }else{
        
        SGCourseCell *cell4 = [self.HomeTableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        return cell4;
    
    }


}

//cell的高度设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 200;
        
    }else if (indexPath.section == 1){
        
        return 200;
        
    }else{
        
        return 150;
        
    }
}

//表头高设置
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
        return 30;
   
}

//表头设置
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==0)
    {
        return self.Head1;
        
    }else if (section == 1){
    
        return self.Head2;
    }else if (section == 2){
        
        return self.Head3;
    }else{
        
        return self.Head4;
    }
    
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
