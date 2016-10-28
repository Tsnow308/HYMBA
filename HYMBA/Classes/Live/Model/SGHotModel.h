//
//  SGHotModel.h
//  HYMBA
//
//  Created by Tsnow on 2016/10/22.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGHotModel : NSObject

/** 直播图*/
@property (nonatomic,copy) NSString *bigpic;
/** 主播头像*/
@property (nonatomic,copy) NSString *smallpic;
/** 直播流地址*/
@property (nonatomic,copy) NSString *flv;
/** 主播名*/
@property (nonatomic,copy) NSString *myname;

@end
