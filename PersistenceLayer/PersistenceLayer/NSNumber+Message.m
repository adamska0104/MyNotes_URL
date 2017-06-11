//
//  NSNumber+Message.m
//  PersistenceLayer
//
//  Created by adam on 2017/6/10.
//  Copyright © 2017年 ark. All rights reserved.
//

#import "NSNumber+Message.h"

@implementation NSNumber (Message)

- (NSString *)errorMessage {
    
    NSString *errorStr = @"";
    
    switch ([self integerValue]) {
        case -7:
            errorStr = @"没有数据。";
            break;
        
        case -6:
            errorStr = @"日期没有输入。";
            break;
            
        case -5:
            errorStr = @"内容没有输入。";
            break;
            
        case -4:
            errorStr = @"ID没有输入。";
            break;
        
        case -3:
            errorStr = @"据访问失败。";
            break;
        
        case -2:
            errorStr = @"您的账号最多能插入10条数据。";
            break;
        
        case -1:
            errorStr = @"用户不存在，请到51work6.com注册。";
    }
    
    return errorStr;
}

@end
