//
//  BaseNetWork.m
//  huxijia
//
//  Created by aaron on 16/2/29.
//  Copyright © 2016年 xue. All rights reserved.
//

#import "SGBaseNetWork.h"
#import "SGHttpTool.h"

@implementation SGBaseNetWork

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark GET Method

- (void)startGet
{
    if (_flag != NWFlagNoMemberId && [[NSUserDefaults standardUserDefaults] objectForKey:@"id"]) {
        
        if (_params) {
            NSMutableDictionary *tmpDic = [NSMutableDictionary dictionaryWithDictionary:_params];
            [tmpDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] forKey:@"memberId"];
            _params = tmpDic;
        } else {
            if ([_path rangeOfString:@"?"].location == NSNotFound) {
                _path = [NSString stringWithFormat:@"%@?memberId=%@", _path, [[NSUserDefaults standardUserDefaults] objectForKey:@"id"]];
            } else {
                _path = [NSString stringWithFormat:@"%@&memberId=%@", _path, [[NSUserDefaults standardUserDefaults] objectForKey:@"id"]];
            }
        }
    }
    
    [SGHttpTool getWithURL:[NSString stringWithFormat:@"%@%@",kWebBaseUrl,_path] params:_params success:^(id result) {
        self.completion(result, YES);
    } failure:^(NSError *error) {
        
    }];
    
}
//登录
- (void)startPost
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_params];
    if (_flag != NWFlagNoMemberId && [[NSUserDefaults standardUserDefaults] objectForKey:@"id"]) {
        [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] forKey:@"memberId"];
    }
    _params = [dic copy];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kWebBaseUrl,_path];
    
    NSLog(@"\\\\\\\\\\\\\\\\\%@",_params);
    [SGHttpTool postWithURL:url params:_params success:^(id result) {
        
        self.completion(result, YES);
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"请检查网络"];
        NSLog(@"-------------%@",error);
        
    }];
    
}

- (void)startPostWithUploadData
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:_params];
    if (_flag != NWFlagNoMemberId && [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]) {
        [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"userId"];
    }
    _params = dic;
    
    [SGHttpTool postWithURL:[NSString stringWithFormat:@"%@%@",kWebBaseUrl,_path] params:_params formDataArray:_uploadDataArray success:^(id result) {
        self.completion(result, YES);
    } failure:^(NSError *error) {
        
    }];
}


@end
