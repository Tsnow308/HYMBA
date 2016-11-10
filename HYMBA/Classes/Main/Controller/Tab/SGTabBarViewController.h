//
//  SGTabBarViewController.h
//  HYMBA
//
//  Created by Tsnow on 2016/10/21.
//  Copyright © 2016年 Tsnow. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int,SGTabBarStatus) {
    SGTabBarStatus_HOME = 0,
    SGTabBarStatus_STUDY,
    SGTabBarStatus_FOUND,
    SGTabBarStatus_ME,
};

@interface SGTabBarViewController : UITabBarController

@end
