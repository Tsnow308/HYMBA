//
//  UIBarButtonItem+SG.h
//  HYMBA
//
//  Created by Tsnow on 2016/10/21.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SG)

+ (instancetype)barButtonItemWithImage:(NSString *)image
                        highlightImage:(NSString *)highlightImage targer:(id)target action:(SEL)action;
@end
