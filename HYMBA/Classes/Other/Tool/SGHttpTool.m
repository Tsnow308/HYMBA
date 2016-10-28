//
//  SGHttpTool.m
//  哮喘卫士
//
//  Created by xue on 15/12/14.
//  Copyright © 2015年 xue. All rights reserved.
//

#import "SGHttpTool.h"
#import "AFNetworking.h"

@implementation SGHttpTool
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSLog(@"1111");
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"1111");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
                          success(responseObject);
                      }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
                          failure(error);
        }
    }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSLog(@"1111");

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"1111");

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
                        success(responseObject);
                    }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
                        failure(error);
                    }

    }];
    
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{

    // 1.创建请求管理对象
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
         NSLog(@"1111");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
                         success(responseObject);
                     }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
                         failure(error);
                     }
    }];
    
}

@end

/**
 *  用来封装文件数据的模型
 */
@implementation SGFormData

@end
