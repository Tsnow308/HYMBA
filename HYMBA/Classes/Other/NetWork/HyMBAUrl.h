//
//  HyMBAUrl.h
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/2.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#ifndef HyMBAUrl_h
#define HyMBAUrl_h


#warning 测试正式打包前记得修改
//正式访问api接口前缀
//#define kWebBaseUrl @"http://www.huxijia.cn/hxj/api2/" //api请求接口目录
//#define kWebImageUrl  @"http://www.huxijia.cn/shx/v2/"   //图片接口目录


//测试访问api接口前缀
#define kWebBaseUrl @"http://192.168.11.29"
#define kWebImageUrl @"http://192.168.11.29/"


#pragma mark ----Me----

//注册
#define authCodeUrl @"?r=users/smscode"
#define userRegisterUrl @"?r=users/register"

//登录
#define loginUrl @"?r=users/login"
#define weixinLoginUrl @"?r=users/thirdlogin"
#define weixinBoundMobileUrl @"?r=users/bindmobile"
#define forgetPasswordUrl @"?r=Users/forgetPwd"

//我
#define uploadImageUrl @"?r=users/headimage"

//首页
#define refreshAdsUrl @"?r=ads/adsindex"
#define refreshAllInfo @"?r=site/indexinfo"

#endif /* HyMBAUrl_h */
