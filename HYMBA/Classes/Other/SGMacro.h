//
//  SGMacro.h
//  哈中少商
//
//  Created by xue on 15/12/9.
//  Copyright © 2015年 xue. All rights reserved.
//

#ifndef SGMacro_h
#define SGMacro_h


//SG宏设置  开始
//屏幕宽高
#define MW [UIScreen mainScreen].bounds.size.width
#define MH [UIScreen mainScreen].bounds.size.height

//用户登录之后存储信息
#define SGmemberFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"member.data"]

#define SGHolderInfoFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"holderInfo.data"]


//常用的对象（监听）
#define SGNotificationCenter [NSNotificationCenter defaultCenter]
//获得RGB颜色
#define SGColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


// 4.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

////////////自定义检测Notification
#define kPresentLoginViewNotification   @"kPresentLoginViewNotification"
#define kUserDidLogoutNotification      @"kUserDidLogoutNotification"
#define kJumpToHomeViewNotification     @"kJumpToHomeViewNotification"

#define myAppID   @"1071028626"

//SG宏设置  结束

#endif /* SGMacro_h */
