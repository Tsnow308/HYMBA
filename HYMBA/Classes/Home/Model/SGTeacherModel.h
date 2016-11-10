//
//  SGTeacherModel.h
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/10.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGTeacherModel : NSObject

//导师ID号
@property (nonatomic,copy) NSString *teacher_id;
//导师姓名
@property (nonatomic,copy) NSString *tname;
//导师标签
@property (nonatomic,copy) NSString *tags;
//导师简介
@property (nonatomic,copy) NSString *introduce;
//导师缩略图
@property (nonatomic,copy) NSString *thumb;
//中等大小的图片
@property (nonatomic,copy) NSString *orginImage;
//大图
@property (nonatomic,copy) NSString *poster;
//排序
@property (nonatomic,assign) NSInteger sort;


@end
