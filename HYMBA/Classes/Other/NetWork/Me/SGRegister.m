//
//  Register.m
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/2.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGRegister.h"

@implementation SGRegister

-(void)authCodeWithMobile:(NSString *)mobile type:(NSString *)type
{
    _path = authCodeUrl;
    
    _params = @{@"mobile":mobile,
                    @"type":type};
    _flag = NWFlagNoMemberId;
    [self startPost];

}

-(void)registerWithMobile:(NSString *)mobile password:(NSString *)password code:(NSString *)code
{
    _path = userRegisterUrl;
    
    _params = @{@"mobile":mobile,
                @"password":password,
                  @"code":code};
    NSLog(@"........%@",_params);
    _flag = NWFlagNoMemberId;
    [self startPost];
}

@end
