//
//  SGLoginHttp.m
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/4.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGLoginHttp.h"

@implementation SGLoginHttp

- (void)loginWithMobile:(NSString *)mobile password:(NSString *)password
{
    _path = loginUrl;
    
    _params = @{@"mobile":mobile,
                @"password":password};
    _flag = NWFlagNoMemberId;
    
    [self startPost];

}

- (void)weixinLoginWith:(NSString *)openid nickname:(NSString *)nickname avatar:(NSString *)avatar gender:(NSString *)gender
{
    _path = weixinLoginUrl;
    
    _params = @{@"openid":openid,
                @"nickname":nickname,
                @"avatar":avatar,
                @"gender":gender};
   _flag = NWFlagNoMemberId;
    
    [self startPost];

}

- (void) weixinBoundMobile:(NSString *)mobile openid:(NSString *)openid code:(NSString *)code avatar:(NSString *)avatar nickname:(NSString *)nickname gender:(NSString *)gender
{
    _path = weixinBoundMobileUrl;
    
    _params = @{@"mobile":mobile,
                @"openid":openid,
                @"code":code,
                @"avatar":avatar,
                @"nickname":nickname,
                @"gender":gender};
    _flag = NWFlagNoMemberId;
    
    [self startPost];
    
}

-(void)authCodeWithMobile:(NSString *)mobile type:(NSString *)type
{
    _path = authCodeUrl;
    
    _params = @{@"mobile":mobile,
                @"type":type};
    _flag = NWFlagNoMemberId;
    [self startPost];
    
}

-(void)forgetPasswordWithMobile:(NSString *)mobile newpass:(NSString *)newpass code:(NSString *)code
{
    _path = forgetPasswordUrl;
    
    _params = @{@"mobile":mobile,
                @"newpass":newpass,
                @"code":code};
    _flag = NWFlagNoMemberId;
    [self startPost];
    
}

@end
