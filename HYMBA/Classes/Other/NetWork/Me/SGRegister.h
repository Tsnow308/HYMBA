//
//  Register.h
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/2.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGBaseNetWork.h"

@interface SGRegister : SGBaseNetWork

/**
 *  短信验证请求
 *  @param mobile  手机号
 *  @param type 验证类型
 */
 
-(void) authCodeWithMobile:(NSString *)mobile
                      type:(NSString *)type;

/**
 *  会员注册请求
 *  @param mobile  手机号
 *  @param password 密码
 * @param  code  验证码
 */
-(void) registerWithMobile:(NSString *)mobile
                  password:(NSString *)password
                      code:(NSString *)code;

@end
