//
//  UIBarButtonItem+SG.m
//  HYMBA
//
//  Created by Tsnow on 2016/10/21.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import "UIBarButtonItem+SG.h"

@implementation UIBarButtonItem (SG)
+(instancetype)barButtonItemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage targer:(id)target action:(SEL)action
{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.image = image;
    btn.highlightedImage = highlightImage;
    
    [btn addTarget:target action:action];

    return [[self alloc] initWithCustomView:btn];
}
@end
