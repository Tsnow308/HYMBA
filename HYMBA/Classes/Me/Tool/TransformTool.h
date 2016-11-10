//
//  TransformTool.h
//  huxijia
//
//  Created by xue on 16/3/17.
//  Copyright © 2016年 xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransformTool : NSObject
//时间格式转化
+(NSString *)treamentTime:(NSString *)standardTime;

//头像判断
+(NSString *)urlTranslation:(NSString *)urlString;

@end
