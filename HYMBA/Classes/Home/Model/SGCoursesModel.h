//
//  SGCoursesModel.h
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/10.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGCoursesModel : NSObject


//专栏和课程的id号
@property (nonatomic,assign) NSInteger course_id;
//标题
@property (nonatomic,copy) NSString *title;
//副标题
@property (nonatomic,copy) NSString *sub_title;
//价格
@property (nonatomic,assign) NSInteger *course_fee;
//所属的分类id（标签）
@property (nonatomic,copy) NSString *cat_id;
//所属的分类name（标签）
@property (nonatomic,copy) NSString *cat_name;
//1:表示课程，2：表示专栏
@property (nonatomic,assign) NSInteger type;
//课程简介
@property (nonatomic,copy) NSString *introduce;
//缩略图
@property (nonatomic,copy) NSString *thumb;
//Banner图
@property (nonatomic,copy) NSString *banner;
//是否为显示免费
@property (nonatomic,assign) NSInteger limit_free;
//免费开始时间
@property (nonatomic,assign) NSInteger start_free;
//免费结束时间
@property (nonatomic,assign) NSInteger end_free;


@end
