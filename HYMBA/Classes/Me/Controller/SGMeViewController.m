//
//  SGMeViewController.m
//  HYMBA
//
//  Created by Tsnow on 2016/10/21.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import "SGMeViewController.h"
#import "SGSystemSetVC.h"
#import "SGAccount.h"
#import "SGAccountTool.h"
#import "SGMeHttp.h"
#import "SGHttpTool.h"
#import "TransformTool.h"

@import AVFoundation;

@interface SGMeViewController ()<UITableViewDelegate,UITableViewDataSource,
    UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//表头视图
@property (strong, nonatomic) IBOutlet UIView *headView;
/**数据数组 */
@property (nonatomic,strong)NSArray *datalist;
/**用户头像*/
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
/**用户名称*/
@property (weak, nonatomic) IBOutlet UILabel *userName;

/**
 *提示跳转相册或者打开照相机
 */
@property (nonatomic,strong) UIActionSheet *actionSheet;


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
        systemSetings[@"controller"] = [SGSystemSetVC class];
        
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
    
    [self refreshUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMainView];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupMainView
{
    [self setupHeadView];
    
//    self.tableView.y = -20;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
//    self.tableView.separatorStyle = UITableViewStyleGrouped;
//    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    self.tableView.tableHeaderView = self.headView;

}

- (void)setupHeadView
{

    self.userIcon.layer.cornerRadius = self.userIcon.height*0.5;
    self.userIcon.layer.masksToBounds = YES;
    self.userIcon.contentMode = UIViewContentModeScaleAspectFill;
    self.userIcon.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapImg = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateImgAction)];
    [self.userIcon addGestureRecognizer:tapImg];

}

#pragma mark -- 刷新用户信息
- (void)refreshUserInfo
{
    SGAccount *account = [SGAccountTool account];
    self.userIcon.image = [UIImage imageNamed:account.avatar];
    self.userName.text = account.userName;

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
    
    if (self.datalist[indexPath.section][indexPath.row][@"controller"]){
        UIViewController *vc = [[self.datalist[indexPath.section][indexPath.row][@"controller"] alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        self.navigationController.navigationBar.hidden = NO;
    }
//        else{
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

#pragma mark --点击头像进行修改
- (void)updateImgAction
{
    [self callActionSheetFunc];
}

- (void)callActionSheetFunc
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil, nil];
        
    } else {
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil, nil];

    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];

}

#pragma mark --sheet
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (actionSheet.tag == 1000) {
        
        if(buttonIndex == 0){
            
            [self takeCameraPhoto];
        }else if(buttonIndex == 1){
            
            [self takeLocationImage];
        }else{
            return ;
        }
    }
}

-(BOOL)isAvailableSelectAVCapture:(NSString *)type isphoto:(BOOL)is
{
    
    __block BOOL isAvalible = NO;
    BOOL showAlertView = YES;

    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:type];
    if (status == AVAuthorizationStatusRestricted) {
    }else if (status == AVAuthorizationStatusDenied)
    {
    }else if (status == AVAuthorizationStatusAuthorized)
    {
        isAvalible = YES;
    }else if (status == AVAuthorizationStatusNotDetermined)
    {
        [AVCaptureDevice requestAccessForMediaType:type completionHandler:^(BOOL granted) {
            if (granted) {
                isAvalible = YES;
            }else
            {
                isAvalible = NO;
            }
        }];
        showAlertView = NO;
    } else {
    }
    if ( isAvalible==NO && showAlertView ) {
        NSString *alterStr = nil;
        if (is) {
            alterStr = @"应用尚未获取访问相机的权限,如需使用请到系统设置->隐私->相机中开启";
        }else
        {
            alterStr = @"应用尚未获取访问麦克风的权限,如需使用请到系统设置->隐私->麦克风中开启";
        }
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:alterStr
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alter show];
    }
    return isAvalible;
}


#pragma mark 拍照
-(void)takeCameraPhoto
{
 
    if ([self isAvailableSelectAVCapture:AVMediaTypeAudio isphoto:YES]) {
        
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:nil];
        
    }else
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"手机不支持拍照。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alter show];
    }
}


-(void)takeLocationImage
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *imagePick = [[UIImagePickerController alloc]init];
        imagePick.delegate = self;
        imagePick.sourceType = sourceType;
        
        [self presentViewController:imagePick animated:YES completion:nil];
    }else
    {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"手机不支持选择照片"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alter show];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1.销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 2.去的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self returnImageName:image.fixOrientation];
    
}

-(void)returnImageName:(UIImage *)image
{
    
        NSLog(@"--------------------------%@",image);
        //封装文件参数
        NSMutableArray *formDataArray = [NSMutableArray array];

        [formDataArray addObject:image];
    
        NSArray *avatarArray = [NSArray array];
        avatarArray = formDataArray;
    
        SGMeHttp *meHttp = [[SGMeHttp alloc]init];
        meHttp.completion = ^(NSDictionary *result, BOOL succ){
    
        if (succ) {
            
            if([result[@"object"][@"avatar"] isKindOfClass:[NSNull class]]){
                
                self.userIcon.image = [UIImage imageNamed:@"img(2).png"];
                
            }else{
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:result[@"object"][@"avatar"] forKey:@"avatar"];
                [userDefaults synchronize];
                
                NSURL *url = [NSURL URLWithString:[TransformTool urlTranslation:[userDefaults objectForKey:@"avatar"]]];
                
                [self.userIcon sd_setImageWithURL:url];
                [MBProgressHUD showSuccess:@"头像上传成功"];
            }
            
        } else {
            
            [MBProgressHUD showError:@"头像上传失败"];
        }
    
        };
    
       [meHttp uploadHeadimageWithAvatar:avatarArray];
    
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
