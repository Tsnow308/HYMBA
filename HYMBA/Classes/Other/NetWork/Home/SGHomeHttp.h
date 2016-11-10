//
//  SGHomeHttp.h
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/8.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGBaseNetWork.h"

@interface SGHomeHttp : SGBaseNetWork

/**
 *  首页广告轮播刷新请求
 */
-(void) refreshAdsData;

/**
 *  首页所有信息展示请求
 */
-(void) refresHomeAllInfo;


@end
