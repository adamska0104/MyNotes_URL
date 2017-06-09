//
//  Note.m
//  PersistenceLayer
//
//  Created by adam on 2017/6/9.
//  Copyright © 2017年 ark. All rights reserved.
//

#import "Note.h"

@implementation Note

- (instancetype)initWithID:(NSString *)ID date:(NSString *)date content:(NSString *)content {
    self = [super init];
    if (self) {
        self.ID = ID;
        self.date = date;
        self.content = content;
    }
    
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.ID = @"";
        self.date = @"";
        self.content = @"";
    }
    
    return self;
}

@end
