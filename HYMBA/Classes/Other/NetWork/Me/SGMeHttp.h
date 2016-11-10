//
//  SGMeHttp.h
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/9.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGBaseNetWork.h"

@interface SGMeHttp : SGBaseNetWork

/**
 * 会员修改头像请求
 * @param avatar 图片文件流
 */
- (void)uploadHeadimageWithAvatar:(NSArray *)avatar;

/**
 *将image转成NSData返回NSString
 */
//+ (NSString *)imageWithDataURL:(UIImage *)image;

@end
