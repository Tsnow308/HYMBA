//
//  BaseNetWork.h
//  huxijia
//
//  Created by aaron on 16/2/29.
//  Copyright © 2016年 xue. All rights reserved.
//  网络封装父类

#import <Foundation/Foundation.h>

typedef enum {
    NWFlagNoMemberId = 101,
} NWFlag;

@interface SGBaseNetWork : NSObject
{
    NWFlag _flag;           ///< 是否需要用户memberId，默认需要，如不需要，flag设置为NWFlagNoMemberId
    NSString *_path;        ///< 请求路径
    NSDictionary *_params;  ///< 参数
    NSArray *_uploadDataArray; ///< 上传数据数组
}
@property (nonatomic, copy) void (^completion)(id result,BOOL succ); ///< 网络请求结果回掉

- (void)startGet; ///< 普通get请求
- (void)startPost; ///< 不带上传数据的post请求
- (void)startPostWithUploadData; ///< 带上传数据的post请求

@end
