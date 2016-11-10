//
//  SGAdModel.h
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/8.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGAdModel : NSObject

/** banner图片地址 */
@property (nonatomic,copy) NSString *Banner_addr;
/** banner图片编号*/
@property (nonatomic,copy) NSString *banner_id;

@property (nonatomic,copy) NSString *banner_deadline;

@property (nonatomic,copy) NSString *create_date;

@property (nonatomic,copy) NSString *link_url;

@property (nonatomic,copy) NSString *area;

///** 链接*/
//@property (nonatomic,copy) NSString *link;
///** AD名*/
//@property (nonatomic,copy) NSString *title;
///** 倒计时*/
//@property (nonatomic,assign) NSUInteger cutTime;

@end
