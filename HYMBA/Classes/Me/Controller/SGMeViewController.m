//
//  SGMeViewController.m
//  HYMBA
//
//  Created by Tsnow on 2016/10/21.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import "SGMeViewController.h"


@interface SGMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//表头视图
@property (strong, nonatomic) IBOutlet UIView *headView;

/**数据数组 */
@property (nonatomic,strong)NSArray *datalist;
/**用户头像*/
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@end

@implementation SGMeViewController

- (NSArray *)datalist{
    if (!_datalist) {
        NSMutableDictionary *myMessage = [NSMutableDictionary dictionary];
        myMessage[@"title"] = @"我的消息";
        myMessage[@"icon"] = @"";
        //要跳转到的控制器
//        myMessage[@"controller"] = [XLOtherViewController class];
        
        NSMutableDictionary *downloadManager = [NSMutableDictionary dictionary];
        downloadManager[@"title"] = @"下载管理";
        downloadManager[@"icon"] = @"";
        //要跳转到的控制器
        // downloadManager[@"controller"] = [XLOtherViewController class];
        NSMutableDictionary *myActivity = [NSMutableDictionary dictionary];
        myActivity[@"title"] = @"我的活动";
        myActivity[@"icon"] = @"";
        //要跳转到的控制器
        // myActivity[@"controller"] = [XLOtherViewController class];
        NSMutableDictionary *systemSetings = [NSMutableDictionary dictionary];
        systemSetings[@"title"] = @"系统设置";
        systemSetings[@"icon"] = @"";
        //要跳转到的控制器
        // systemSetings[@"controller"] = [XLOtherViewController class];
        
        NSArray *section1 = @[myMessage];
        NSArray *section2 = @[downloadManager,myActivity];
        NSArray *section3 = @[systemSetings];
        
        _datalist = [NSArray arrayWithObjects:section1,section2,section3, nil];
    }
    return _datalist;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMainView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupMainView
{
    [self setupHeadView];
    
    self.tableView.y = -20;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
//    self.tableView.separatorStyle = UITableViewStyleGrouped;
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 40, 0)];
    
    self.tableView.tableHeaderView = self.headView;

    
}

- (void)setupHeadView
{

    self.userIcon.layer.cornerRadius = self.userIcon.height*0.5;
    self.userIcon.layer.masksToBounds = YES;
    self.userIcon.contentMode = UIViewContentModeScaleAspectFill;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDelegate, UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.datalist.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datalist[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *ID = @"mineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    NSDictionary *dict = self.datalist[indexPath.section][indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    
//    if (!indexPath.section && !indexPath.row) {
//        cell.detailTextLabel.text = @"270枚";
//        cell.detailTextLabel.textColor = XLColor(0.935, 210, 0);
//    }
//    
//    cell.selected = YES;
//    
//    if ([cell.textLabel.text isEqualToString:@"清空缓存"]){
//        
//        cell.accessoryView = [[UIView alloc] init];
//        cell.detailTextLabel.text = [self caCheSize];
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    
//    
//    if (self.dataList[indexPath.section][indexPath.row][@"controller"]){
//        UIViewController *vc = [[self.dataList[indexPath.section][indexPath.row][@"controller"] alloc] init];
//        
//        vc.title = self.dataList[indexPath.section][indexPath.row][@"title"];
//        
//        vc.view.backgroundColor = XLColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
//        
//        
//        [self.navigationController pushViewController:vc animated:YES];
//        self.navigationController.navigationBar.hidden = NO;
//    }else{
//        
//        
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        
//        [[SDImageCache sharedImageCache] clearDisk];
//        [[SDWebImageManager sharedManager] cancelAll];
//        
//        cell.detailTextLabel.text = [self caCheSize];
//    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return !section ? 1 : CGFLOAT_MIN;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat offsetY = scrollView.contentOffset.y;

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
