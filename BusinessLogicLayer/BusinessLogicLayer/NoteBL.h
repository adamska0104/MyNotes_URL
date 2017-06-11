//
//  NoteBL.h
//  BusinessLogicLayer
//
//  Created by adam on 2017/6/11.
//  Copyright © 2017年 ark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PersistenceLayer/Note.h>
#import <PersistenceLayer/NoteDAO.h>
#import <PersistenceLayer/NoteDAODelegate.h>
#import "NoteBLDelegate.h"

@interface NoteBL : NSObject <NoteDAODelegate>

@private (weak, nonatomic) id <NoteBLDelegate> delegate;

- (void)createNote:(Note *)model;

- (void)removeNote:(Note *)model;

- (void)findAllNotes;

- (void)modifyNote:(Note *)model;

@end
