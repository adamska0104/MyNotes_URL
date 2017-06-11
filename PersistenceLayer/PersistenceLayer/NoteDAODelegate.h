//
//  NoteDAODelegate.h
//  PersistenceLayer
//
//  Created by adam on 2017/6/11.
//  Copyright © 2017年 ark. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Note;

@protocol NoteDAODelegate

@optional

- (void)findAllFinished:(NSMutableArray *)list;

- (void)findAllFailed:(NSError *)error;

- (void)findByIDFinished:(Note *)model;

- (void)findByIDFailed:(NSError *)error;

- (void)createFinished;

- (void)createFailed:(NSError *)error;

- (void)removeFinished;

- (void)removeFailed:(NSError *)error;

- (void)modifyFinished;

- (void)modifyFailed:(NSError *)error;

@end
