//
//  SGMeHttp.m
//  HYMBA
//
//  Created by 尹雪松 on 2016/11/9.
//  Copyright © 2016年 尹雪松. All rights reserved.
//

#import "SGMeHttp.h"

@implementation SGMeHttp

- (void)uploadHeadimageWithAvatar:(NSArray *)avatar
{
    _path = uploadImageUrl;
    
//    NSString *imageString = [[NSString alloc]init];
//    for (UIImage *image in avatar) {
//        imageString = [self imageWithDataURL:image];
//        
//    }
    _params = @{@"user_id":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]};
//    _params = @{@"user_id":@"11",@"avatar":imageString};
    _uploadDataArray = avatar;
    _flag = NWFlagNoMemberId;
    
    [self startPostWithUploadData];
//    [self startPost];
    
}

- (NSString *)imageWithDataURL:(UIImage *)image
{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    //图片要压缩的比例，此处100根据需求，自行设置
    CGFloat x =100/image.size.height;
    if (x>1)
    {
        x = 1.0;
    }
    imageData = UIImageJPEGRepresentation(image, x);
    mimeType = @"image/jpeg";
    return [NSString stringWithFormat:@"%@",[imageData base64EncodedDataWithOptions:0]];
    
}

@end
