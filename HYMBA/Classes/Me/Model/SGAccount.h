//
//  SGAccount.h
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/7.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGAccount : NSObject

//用户ID
@property (nonatomic,assign) NSNumber *userId;
//用户名称
@property (nonatomic,copy) NSString *userName;
//用户类型
@property (nonatomic,assign) BOOL userType;
//用户手机
@property (nonatomic,copy) NSString *mobile;
//用户头像
@property (nonatomic,copy) NSString *avatar;
//用户性别
@property (nonatomic,copy) NSString *gender;
//用户昵称
@property (nonatomic,copy) NSString *nickname;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
