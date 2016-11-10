//
//  SGAdHeaderView.m
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/8.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGAdHeaderView.h"


@interface SGAdHeaderView ()

@property (nonatomic,weak) UIView *myView;
@property (nonatomic,strong) NSMutableArray *lastModels;

@end

@implementation SGAdHeaderView

- (void)setHeaderModels:(NSArray *)headerModels
{
    _headerModels = headerModels;
    
    NSMutableArray *imageUrls = [NSMutableArray array];
    for (SGAdModel *adModel in headerModels) {
        
        [imageUrls addObject:adModel.Banner_addr];
    }
    
    NSLog(@"\\\\\\\\\\\\\7%@",imageUrls);

    //如果返回数据和上次一样直接返回
//    if ([self.lastModels containsObject:headerModels]) return;
    
//    if (self.lastModels) return;
    
    self.myView = nil;
    [self.myView removeFromSuperview];
    
    XRCarouselView *view = [XRCarouselView carouselViewWithImageArray:
                            imageUrls describeArray:nil];
    
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        view.time = 2.0;
        view.delegate = weakSelf;
        view.frame = weakSelf.bounds;
        //    移除之前的view
        
        [weakSelf addSubview:view];
        
        weakSelf.lastModels = [NSMutableArray arrayWithArray:headerModels];
        weakSelf.myView = view;
    });
    
}

#pragma mark -XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index
{
    if (self.imageClickBlock) {
        
        self.imageClickBlock(self.headerModels[index]);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
