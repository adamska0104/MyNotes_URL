//
//  NoteBLDelegate.h
//  BusinessLogicLayer
//
//  Created by adam on 2017/6/11.
//  Copyright © 2017年 ark. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NoteBLDelegate

@optional

- (void)findAllNotesFinished:(NSmutablesArray *)list;

- (void)findAllNotesFailed:(NSError *)error;

- (void)findByIDFinished:(Note *)note;

- (void)findByIDFailed:(Note *)note;

- (void)createNoteFinished;

- (void)createNoteFailed:(NSerror *)error;

- (void)removeNoteFinished;

- (void)removeNoteFailed:(NSError *)error;

- (void)modifyNoteFinished;

- (void)modifyNoteFailed:(NSError *)error;


@end
