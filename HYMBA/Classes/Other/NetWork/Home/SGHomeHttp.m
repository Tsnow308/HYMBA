//
//  SGHomeHttp.m
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/8.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGHomeHttp.h"

@implementation SGHomeHttp

-(void)refreshAdsData
{
    _path = refreshAdsUrl;
    
    [self startPost];

}

-(void)refresHomeAllInfo
{
    _path = refreshAllInfo;
    
    [self startPost];

}

@end
