//
//  SGAccount.m
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/7.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGAccount.h"

@implementation SGAccount
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

/**
 *  从文件中解析对象的时候调
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.userId = [decoder decodeObjectForKey:@"userId"];
        self.userName = [decoder decodeObjectForKey:@"userName"];
        self.userType = [decoder decodeInt64ForKey:@"userType"];
        self.mobile = [decoder decodeObjectForKey:@"mobile"];
        self.avatar = [decoder decodeObjectForKey:@"avatar"];
        self.gender = [decoder decodeObjectForKey:@"gender"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.userId forKey:@"userId"];
    [encoder encodeObject:self.userName forKey:@"userName"];
    [encoder encodeInt64:self.userType forKey:@"userType"];
    [encoder encodeObject:self.mobile forKey:@"mobile"];
    [encoder encodeObject:self.avatar forKey:@"avatar"];
    [encoder encodeObject:self.gender forKey:@"gender"];
    [encoder encodeObject:self.nickname forKey:@"nickname"];
}


@end
