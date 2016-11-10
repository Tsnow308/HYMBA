//
//  SGLoginHttp.h
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/4.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGBaseNetWork.h"

@interface SGLoginHttp : SGBaseNetWork

/**
 *  会员手机号登录请求
 *  @param mobile  手机号
 *  @param password 密码
 */
-(void) loginWithMobile:(NSString *)mobile
               password:(NSString *)password;

/**
 *  会员微信登录请求
 *  @param openid  微信openID
 *  @param nickname 昵称
 *  @param avatar  头像url
 *  @param gender 性别
 */
-(void) weixinLoginWith:(NSString *)openid
               nickname:(NSString *)nickname
                 avatar:(NSString *)avatar
                 gender:(NSString *)gender;

/**
 *  会员微信绑定手机号请求
 *  @param mobile  手机号
 *  @param openid  微信openID
 *  @param code 手机短信验证码
 *  @param avatar  头像url
 *  @param nickname 昵称
 *  @param gender 性别
 */
-(void) weixinBoundMobile:(NSString *)mobile
                   openid:(NSString *)openid
                     code:(NSString *)code avatar:(NSString *)avatar nickname:(NSString *)nickname gender:(NSString *)gender;


/**
 *  短信验证请求
 *  @param mobile  手机号
 *  @param type 验证类型
 */

-(void) authCodeWithMobile:(NSString *)mobile
                      type:(NSString *)type;


/**
 *  @param mobile  手机号
 *  @param newpass  新密码
 *  @param code  验证码
 */
-(void) forgetPasswordWithMobile:(NSString *)mobile
                         newpass:(NSString *)newpass
                            code:(NSString *)code;

@end
