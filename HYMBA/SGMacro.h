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
//判断是否为ios7
#define ios7 ([[UIDevice currentDevice].systemVersion  doubleValue] >=7.0)
//获得RGB颜色
#define SGColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SPACE 10

/** 表格的边框宽度 */
#define SGAsthmaTableBorder 5
/** cell的边框宽度 */
#define SGAsthmaCellBorder 10

/** 昵称的字体 */
#define SGNameFont [UIFont systemFontOfSize:15]
/** 时间的字体 */
#define SGCreatedTimeFont [UIFont systemFontOfSize:12]

#define SGIconW 20
#define SGIconH 20
#define SGIconMargin 10
#define SGNameFont [UIFont systemFontOfSize:15]

// 6.帖子cell内部相册
#define SGPhotoW 70
#define SGPhotoH 70
#define SGPhotoMargin 10

////////////自定义检测Notification
#define kUserDidLoginNotification       @"kUserDidLoginNotification"
#define kUserDidLogoutNotification      @"kUserDidLogoutNotification"
#define kUserDidUpdateProfileNotification  @"kUserDidUpdateProfileNotification"
#define kPresentLoginViewNotification   @"kPresentLoginViewNotification"
#define kJumpToHomeViewNotification     @"kJumpToHomeViewNotification"
#define kJumpToRecordViewNotification     @"kJumpToRecordViewNotification"
#define kJumpToCenterViewNotification   @"kJumpToCenterViewNotification"

#define myAppID   @"1071028626"

//SG宏设置  结束

#endif /* SGMacro_h */
