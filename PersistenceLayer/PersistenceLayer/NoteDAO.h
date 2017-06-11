//
//  NoteDAO.h
//  PersistenceLayer
//
//  Created by adam on 2017/6/9.
//  Copyright © 2017年 ark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "NoteDAODelegate.h"

@interface NoteDAO : NSObject

@property (weak, nonatomic) id <NoteDAODelegate> delegate;

+ (NoteDAO *)sharedInstence;

- (void)create:(Note *)model;

- (void)remove:(Note *)model;

- (void)findAll;

- (void)findByID:(Note *)model;

- (void)modify:(Note *)model;

@end
