//
//  SGHomeViewController.m
//  HYMBA
//
//  Created by Tsnow on 2016/10/21.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import "SGHomeViewController.h"
#import "SGTeacherCell.h"
#import "SGLimitFreeCell.h"
#import "SGColumnCell.h"
#import "SGCourseCell.h"
#import "SGAdHeaderView.h"
#import "HDSliderTabBar.h"
#import "SGAdModel.h"
#import "SGHomeHttp.h"
#import "SGAdHeaderView.h"
#import "SGTeacherModel.h"

@interface SGHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

//首页TableView
@property (weak, nonatomic) IBOutlet UITableView *HomeTableView;
//表头视图
@property (strong, nonatomic) IBOutlet UIView *HeadView;
//广告头视图-表头
@property (strong, nonatomic) IBOutlet SGAdHeaderView *ADHeadView;
//滑动选项卡
@property (weak, nonatomic) IBOutlet HDSliderTabBar *sliderBarView;

//第一分区表头
@property (strong, nonatomic) IBOutlet UIView *Head1;
//第二分区表头
@property (strong, nonatomic) IBOutlet UIView *Head2;
//第三分区表头
@property (strong, nonatomic) IBOutlet UIView *Head3;
//第四分区表头
@property (strong, nonatomic) IBOutlet UIView *Head4;
//导航icon
@property (weak, nonatomic) IBOutlet UIImageView *navIcon;

//广告头模型数组
@property (strong,nonatomic) NSArray *headsArray;

//导师数据
//导师装载数组
@property (strong,nonatomic) NSMutableArray *teacherArray;


@end

@implementation SGHomeViewController

- (SGAdHeaderView *)ADHeadView
{
    if (_ADHeadView == nil) {
        
        SGAdHeaderView *headerView = [[SGAdHeaderView alloc]init];
        [self.ADHeadView setImageClickBlock:^(SGAdModel *adModel) {
            
            // 广告点击事件
        }];
        
        _ADHeadView = headerView;
    }
    return _ADHeadView;
}

- (NSArray *)headsArray
{
    if (_headsArray == nil) {
        
        _headsArray = [NSArray array];
    }
    return _headsArray;
}

- (NSMutableArray *)teacherArray
{
    if (_teacherArray == nil) {
        _teacherArray = [NSMutableArray array];
    }
    return _teacherArray;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    

//    [self refreshInfo];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SetupMainView];
    
    [self ADHeadView];
    
    [self refreshAds];
    
}

-(void)SetupMainView
{
    [self setupNavView];
    
    self.HomeTableView.dataSource = self;
    self.HomeTableView.delegate = self;
    
    self.HomeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.HomeTableView.backgroundColor = [UIColor clearColor];
    self.HomeTableView.showsVerticalScrollIndicator = NO;
    self.HomeTableView.showsHorizontalScrollIndicator = NO;
    [self.HomeTableView setContentInset:UIEdgeInsetsMake(0, 0, 40, 0)];

    self.HomeTableView.tableHeaderView = self.HeadView;
    
    //权威导师
    [self.HomeTableView registerNib:[UINib nibWithNibName:@"SGTeacherCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    //限时免费
    [self.HomeTableView registerNib:[UINib nibWithNibName:@"SGLimitFreeCell" bundle:nil] forCellReuseIdentifier:@"cell2"];

    //专栏订阅
    [self.HomeTableView registerNib:[UINib nibWithNibName:@"SGColumnCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    
    //课程
    [self.HomeTableView registerNib:[UINib nibWithNibName:@"SGCourseCell" bundle:nil] forCellReuseIdentifier:@"cell4"];
    
}

- (void)setupNavView{
    
    self.navIcon.layer.cornerRadius = self.navIcon.frame.size.height;
    self.navIcon.layer.masksToBounds = YES;
    self.navIcon.contentMode = UIViewContentModeScaleAspectFill;
    
    
    //使用滑动选项卡方法
    
    self.sliderBarView.itemArray = @[@"创造力",@"领导力",@"财商",@"兴趣",@"社交",@"兴趣",@"社交",@"培养",@"社交"];
//    __weak typeof(self) weakSelf = self;
    self.sliderBarView.selectBlock = ^(NSInteger index,UITableView *tableView){
        //点击后的回调
        NSLog(@"\\\\\\\\\\刷新");
    };

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
    if (section == 1) {
        return 2;
    }
    
    return 1;

}

//cell内容选择设置
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        SGTeacherCell *cell1 = [self.HomeTableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
//        //第一个导师
//        SGTeacherModel *teacherModel = [[SGTeacherModel alloc]init];
//        teacherModel = self.teacherArray[0];
//        [cell1.tOneImageView sd_setImageWithURL:[NSURL URLWithString:teacherModel.orginImage]];
//        cell1.teacherTagsLabel.text = teacherModel.tags;
//        cell1.tOneNameLabel.text = teacherModel.tname;
//        cell1.tOneIntroduceLabel.text = teacherModel.introduce;
//        //第二个导师
//        teacherModel = self.teacherArray[1];
//        [cell1.tTwoImageView sd_setImageWithURL:[NSURL URLWithString:teacherModel.thumb]];
//        cell1.tTwoNameLabel.text = teacherModel.tname;
//        //第三个导师
//        teacherModel = self.teacherArray[2];
//        [cell1.tThreeImageView sd_setImageWithURL:[NSURL URLWithString:teacherModel.thumb]];
//        cell1.tThreeNameLabel.text = teacherModel.tname;
//        
//        //第四个导师
//        teacherModel = self.teacherArray[3];
//        [cell1.tFourImageView sd_setImageWithURL:[NSURL URLWithString:teacherModel.thumb]];
//        cell1.tFourNameLabel.text = teacherModel.tname;
//        
//        //第五个导师
//        teacherModel = self.teacherArray[4];
//        [cell1.tFiveImageView sd_setImageWithURL:[NSURL URLWithString:teacherModel.thumb]];
//        cell1.tFiveNameLabel.text = teacherModel.tname;
        
        return cell1;

    }else if (indexPath.section == 1)
    {
        SGLimitFreeCell *cell2 = [self.HomeTableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        
        return cell2;
    
    }else if (indexPath.section == 2)
    {
        SGColumnCell *cell3 = [self.HomeTableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        
        return cell3;
        
    }else{
        
        SGCourseCell *cell4 = [self.HomeTableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
        
        return cell4;
    
    }

}

//cell的高度设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 260;
        
    }else if (indexPath.section == 1){
        
        return 182;
        
    }else if (indexPath.section == 2){
        
        return 118;
        
    }else{
        
        return 232;
        
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

#pragma mark --刷新广告轮播图
-(void)refreshAds
{
    __weak typeof(self) weakSelf = self;
    SGHomeHttp *homeHttp = [[SGHomeHttp alloc]init];
    homeHttp.completion = ^(NSDictionary *result, BOOL succ){
       
        if (succ) {
            NSLog(@"\\\\\\\\\%@",result);
#pragma mark  --临时数组装载器
            NSMutableArray *tempArray = [NSMutableArray array];
#pragma mark  --返回数据数组装载器
            NSMutableArray *dataList = [NSMutableArray array];
            dataList = result[@"object"];
            
            for (NSDictionary *adDic in dataList) {
                
                SGAdModel *adModel = [[SGAdModel alloc]init];
                [adModel setValuesForKeysWithDictionary:adDic];
                adModel.Banner_addr = [NSString stringWithFormat:@"%@%@",kWebImageUrl,adDic[@"banner_addr"]];
                
                [tempArray addObject:adModel];
            }
            
            [MBProgressHUD showSuccess:@"广告刷新成功"];
            
            weakSelf.ADHeadView.headerModels = [NSArray arrayWithArray:tempArray];
        
            
        } else {
            [MBProgressHUD showSuccess:@"广告刷新失败"];
        }
    
    };
    
    [homeHttp refreshAdsData];
}


#pragma mark -- 刷新首页所有信息
-(void) refreshInfo
{
    SGHomeHttp *homeHttp = [[SGHomeHttp alloc]init];
    homeHttp.completion = ^(NSDictionary *result, BOOL succ){
    
        if (succ) {
#pragma mark  --返回字典数据装载器
          
//            NSLog(@"cate_infouuuuuuuuuuuu%@",result[@"object"][@"cate_info"]);
              NSLog(@"teacher_infouuuuuuuuuuuu%@",result[@"object"][@"teacher_info"][@"data"]);
//            NSLog(@"time_limit_freeuuuuuuuuuuuu%@",result[@"object"][@"time_limit_free"]);
//            NSLog(@"columnuuuuuuuuuuuu%@",result[@"object"][@"column"]);
//            NSLog(@"courseuuuuuuuuuuuu%@",result[@"object"][@"course"]);
            [MBProgressHUD showSuccess:@"首页信息刷新成功"];
 
#pragma mark --权威导师数据
//临时数组装载器
            NSMutableArray *teacherTempArray = [NSMutableArray array];
//返回数据数组装载器
            NSMutableArray *dataList = [NSMutableArray array];
            dataList = result[@"object"][@"teacher_info"][@"data"];
            
            for (NSDictionary *teacherDic in dataList) {
                SGTeacherModel *teacherModel = [[SGTeacherModel alloc]init];
                [teacherModel setValuesForKeysWithDictionary:teacherDic];
                [teacherTempArray addObject:teacherModel];
            }
            self.teacherArray = teacherTempArray;
            
#pragma mark --限时免费数据
            [self.HomeTableView reloadData];
            
        } else {
            
            [MBProgressHUD showError:@"首页信息刷新失败"];
        }
        
    };
    
    [homeHttp refresHomeAllInfo];

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
