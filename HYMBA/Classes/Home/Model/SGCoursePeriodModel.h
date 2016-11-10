//
//  SGCoursePeriodModel.h
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/10.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGCoursePeriodModel : NSObject

//课程详情模型

//某个课程下的期数id
@property (nonatomic,assign) NSInteger period_id;
//标题
@property (nonatomic,copy) NSString *title;
//关键字
@property (nonatomic,copy) NSString *keywords;
//简介
@property (nonatomic,copy) NSString *introduce;
//课程的视频地址
@property (nonatomic,copy) NSString *content;
//课程banner图
@property (nonatomic,copy) NSString *banner;
//缩略图
@property (nonatomic,copy) NSString *thumb;
//是否可免费试读
@property (nonatomic,assign) NSInteger limit_free;
//试读的开始时间
@property (nonatomic,assign) NSInteger start_free;
//试读的结束时间
@property (nonatomic,assign) NSInteger end_free;
//导师的id号（作者）
@property (nonatomic,assign) NSInteger teacher_id;
//点击量
@property (nonatomic,assign) NSInteger click_count;
//所属的课程id
@property (nonatomic,assign) NSInteger course_id;

@end
