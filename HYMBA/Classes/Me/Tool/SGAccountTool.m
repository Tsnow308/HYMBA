//
//  SGAccountTool.m
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/7.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGAccountTool.h"
#import "SGAccount.h"
#define SGAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation SGAccountTool
+ (void)saveAccount:(SGAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:SGAccountFile];
}

+ (SGAccount *)account
{
    // 取出账号
    SGAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:SGAccountFile];
    return account;
}

@end
