//
//  Note.h
//  PersistenceLayer
//
//  Created by adam on 2017/6/9.
//  Copyright © 2017年 ark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (strong, nonatomic) NSString *ID;

@property (strong, nonatomic) NSString *date;

@property (strong, nonatomic) NSString *content;

- (instancetype)initWithID:(NSString *)ID date:(NSString *)date content:(NSString *)content;

- (instancetype)init;

@end
