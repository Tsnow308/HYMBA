//
//  SGAccountTool.h
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/7.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SGAccount;

@interface SGAccountTool : NSObject

/**
 *  存储账号信息
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(SGAccount *)account;

/**
 *  返回存储的账号信息
 */
+ (SGAccount *)account;

@end
