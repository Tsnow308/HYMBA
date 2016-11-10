//
//  SGRecommendCell.h
//  HYMBA
//
//  Created by 尹雪松 on 2016/10/24.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGTeacherCell : UITableViewCell

//第一个大导师头像
@property (weak, nonatomic) IBOutlet UIImageView *tOneImageView;
//导师tags
@property (weak, nonatomic) IBOutlet UILabel *teacherTagsLabel;
//第一大导师名字
@property (weak, nonatomic) IBOutlet UILabel *tOneNameLabel;
//第一个大导师介绍
@property (weak, nonatomic) IBOutlet UILabel *tOneIntroduceLabel;

//第二个导师头像
@property (weak, nonatomic) IBOutlet UIImageView *tTwoImageView;
//第二个导师名字
@property (weak, nonatomic) IBOutlet UILabel *tTwoNameLabel;

//第三个导师头像
@property (weak, nonatomic) IBOutlet UIImageView *tThreeImageView;
//第三个导师名字
@property (weak, nonatomic) IBOutlet UILabel *tThreeNameLabel;

//第四个导师头像
@property (weak, nonatomic) IBOutlet UIImageView *tFourImageView;
//第四个导师名字
@property (weak, nonatomic) IBOutlet UILabel *tFourNameLabel;

//第五个导师头像
@property (weak, nonatomic) IBOutlet UIImageView *tFiveImageView;
//第五个导师名字
@property (weak, nonatomic) IBOutlet UILabel *tFiveNameLabel;

@end
