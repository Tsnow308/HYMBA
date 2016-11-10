//
//  SGHttpTool.m
//
//
//  Created by xue on 15/12/14.
//  Copyright © 2015年 xue. All rights reserved.
//

#import "SGHttpTool.h"
#import "AFNetworking.h"

@implementation SGHttpTool

// post请求
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer= [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",
                                                           @"text/json",
                                                           @"text/javascript",
                                                           @"text/html", nil]];
//    尝试字典转json
//    NSString *param = [params JSONString];
//    NSData *data = [param dataUsingEncoding:NSUTF8StringEncoding];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSLog(@"1---1");
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"1+++1");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"0000000");
        if (success) {
                          success(responseObject);
                      }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"11111111");
        if (failure) {
                          failure(error);
        }
    }];
}

//post请求带上传文件
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer= [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",
                                                           @"text/json",
                                                           @"text/javascript",
                                                           @"text/html", nil]];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSLog(@"1111");
        
        for (UIImage *image in formDataArray) {
        
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg",str];
            
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"1211");

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

//get请求
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{

    // 1.创建请求管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer= [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",
                                                           @"text/json",
                                                           @"text/javascript",
                                                           @"text/html", nil]];
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
         NSLog(@"1111");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");
        if (success) {
                         success(responseObject);
                     }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure");
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
