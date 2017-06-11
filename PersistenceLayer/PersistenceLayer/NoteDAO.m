//
//  NoteDAO.m
//  PersistenceLayer
//
//  Created by adam on 2017/6/9.
//  Copyright © 2017年 ark. All rights reserved.
//

#import "NoteDAO.h"
#import "AFNetworking.h"
#import "NSNumber+Message.h"

#define WEBSERVICE_URL @"http://www.51work6.com/service/mynotes/WebService.php"
#define USER_ID @"<adamska@163.com>"

@implementation NoteDAO

static NoteDAO *sharedSingleton = nil;

+ (NoteDAO *)sharedInstence {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedSingleton = [[self alloc] init];
    });
    
    return sharedSingleton;
}

- (void)requestWithURLString:(NSString *)aURLStr
                      params:(NSString *)params
                  httpMethod:(NSString *)method
           completionHandler:(void (^)(id responseObject, NSError *error))completionHandler {
    
    NSURL *url = [NSURL URLWithString:aURLStr];
    
    NSData *postData = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = method;
    request.HTTPBody = postData;
    
    NSURLSessionConfiguration *defaultConfig =  [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:defaultConfig];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * response, id responseObject, NSError *error) {
        NSLog(@"请求完成...");
        if (!error) {
            NSNumber *resultCodeNumber = [responseObject objectForKey:@"ResultCode"];
            NSInteger resultCode = [resultCodeNumber integerValue];
            
            if (resultCode >= 0) {
                if (completionHandler) {
                    completionHandler(responseObject, nil);
                }
            } else {
                NSString *message = [resultCodeNumber errorMessage];
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:message forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain:@"DAO" code:resultCode userInfo:userInfo];
                
                if (completionHandler) {
                    completionHandler(responseObject, error);
                }
            }
        } else {
            NSLog(@"error : %@", error.localizedDescription);
            if (completionHandler) {
                completionHandler(responseObject, error);
            }
        }
    }];
    
    [task resume];

}
- (void)create:(Note *)model {
    NSString *params = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&date=%@&content=%@", USER_ID, @"JSON", @"add", model.date, model.content];
    
    [self requestWithURLString:WEBSERVICE_URL
                        params:params
                    httpMethod:@"POST"
             completionHandler:^(id responseObject, NSError *error) {
                 if (!error) {
                     [self.delegate createFinished];
                 } else {
                     [self.delegate createFailed:error];
                 }
             }];
    
}

- (void)remove:(Note *)model {
    NSString *params = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&id=%@",
                        USER_ID, @"JSON", @"remove", model.ID];
    
    [self requestWithURLString:WEBSERVICE_URL
                        params:params
                    httpMethod:@"POST"
             completionHandler:^(id responseObject, NSError *error) {
        if (!error) {
            [self.delegate removeFinished];
        } else {
            [self.delegate removeFailed:error];
        }
    }];
}

- (void)modify:(Note *)model {
    NSString *params = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&date=%@&content=%@&id=%@",
                        USER_ID, @"JSON", @"modify", model.date, model.content, model.ID];
    
    [self requestWithURLString:WEBSERVICE_URL
                        params:params
                    httpMethod:@"POST"
             completionHandler:^(id responseObject, NSError *error) {
                 if (!error) {
                     [self.delegate modifyFinished];
                 } else {
                     [self.delegate modifyFailed:error];
                 }
             }];
}

- (void)findAll {
    NSString *params = [NSString stringWithFormat:@"email=%@&type=%@&action=%@",
                        WEBSERVICE_URL, @"JSON", @"query"];
    
    [self requestWithURLString:WEBSERVICE_URL params:params httpMethod:@"POST" completionHandler:^(id responseObject, NSError *error) {
        if (!error) {
            NSMutableArray *listDict = [responseObject objectForKey:@"Record"];
            NSMutableArray *listData = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in listDict) {
                Note *note = [[Note alloc] init];
                
                note.ID = dic[@"ID"];
                note.date = dic[@"CDate"];
                note.content = dic[@"Content"];
                
                [listData addObject:note];
            }
            [self.delegate findAllFinished:listData];
        } else {
            [self.delegate findAllFailed:error];
        }
    }];

}

- (void)findByID:(Note *)model {
    NSString *params = [NSString stringWithFormat:@"email=%@&type=%@&action=%@&id=%@",
                        WEBSERVICE_URL, @"JSON", @"query", model.ID];
    
    [self requestWithURLString:WEBSERVICE_URL params:params httpMethod:@"POST" completionHandler:^(id responseObject, NSError *error) {
        if (!error) {
            NSMutableArray *listDict = [responseObject objectForKey:@"Record"];
            NSDictionary *dic = listDict.lastObject;
            Note *note = [[Note alloc] init];
            
            note.ID = dic[@"ID"];
            note.date = dic[@"CDate"];
            note.content = dic[@"Content"];
            
            [self.delegate findByIDFinished:note];
        } else {
            [self.delegate findByIDFailed:error];
        }
    }];
}


@end
