//
//  TransformTool.m
//  huxijia
//
//  Created by xue on 16/3/17.
//  Copyright © 2016年 xue. All rights reserved.
//

#import "TransformTool.h"

@implementation TransformTool

+(NSString *)treamentTime:(NSString *)standardTime
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* inputDate = [inputFormatter dateFromString:standardTime];
    
    [inputFormatter setDateFormat:@"HH:mm"];
    NSString *time =[inputFormatter stringFromDate:inputDate];
   
    return time;

}


+(NSString *)urlTranslation:(NSString *)urlString
{
    NSString *string =@"http";
    NSArray *array = [urlString componentsSeparatedByString:string];
    if(array.count){
        
        return urlString;
        
    }
    return [NSString stringWithFormat:@"%@%@",kWebImageUrl,urlString];
}
@end
