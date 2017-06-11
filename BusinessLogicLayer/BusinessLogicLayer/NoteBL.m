//
//  NoteBL.m
//  BusinessLogicLayer
//
//  Created by adam on 2017/6/11.
//  Copyright © 2017年 ark. All rights reserved.
//

#import "NoteBL.h"

@implementation NoteBL

- (void)createNote:(Note *)model {
    NoteDAO *dao = [NoteDAO sharedInstance];
    dao.delegate = self;
    [dao create:model];
}

- (void)removeNote:(Note *)model {
    NoteDAO *dao = [NoteDAO sharedInstance];
    dao.delegate = self;
    [dao remove:model];
}

- (void)findAllNotes {
    NoteDAO *dao = [NoteDAO sharedInstance];
    dao.delegate = self;
    [dao findAll];
}

- (void)modifyNote:(Note *)model {
    NoteDAO *dao = [NoteDAO sharedInstance];
    dao.delegate = self;
    [dao modify:model];
}


#pragma --mark NoteDAODelegate

- (void)findAllFinished:(NSMutableArray *)list {
    [self.delegate findAllNotesFinished:lsit];
}

- (void)findAllFailed:(NSError *)error {
    [self.delegate findAllNotesFailed:error];
}

- (void)findByIDFinished:(Note *)model {
    [self.delegate findByIDFinished:model];
}

- (void)findByIDFailed:(NSError *)error {
    [self.delegate findByIDFailed:error];
}

- (void)createFinished {
    [self.delegate createNoteFinished];
}

- (void)createFailed:(NSError *)error {
    [self.delegate createNoteFailed:error];
}

- (void)removeFinished {
    [self.delegate removeNoteFinished];
}

- (void)removeFailed:(NSError *)error {
    [self.delegate removeNoteFailed:error];
}

- (void)modifyFinished {
    [self.delegate modifyNoteFinished];
}

- (void)modifyFailed:(NSError *)error {
    [self.delegate modifyNoteFailed:error];
}

@end
