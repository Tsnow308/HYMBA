//
//  SGAdHeaderView.h
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/8.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRCarouselView.h"
#import "SGAdModel.h"

@interface SGAdHeaderView : UIView <XRCarouselViewDelegate>

/** 顶部AD数组 */
@property (nonatomic,strong) NSArray *headerModels;
/** 点击图片的block */
@property (nonatomic,copy) void (^imageClickBlock)(SGAdModel *adModel);

@end
