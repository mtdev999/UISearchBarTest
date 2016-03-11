//
//  MTGroup.h
//  MTSearchBarTest
//
//  Created by Mark Tezza on 10/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTGroup : NSObject
@property (nonatomic, strong)   NSString            *name;
@property (nonatomic, strong)   NSMutableArray      *mutableStudents;

- (NSArray *)generateSectionsFromArray:(NSArray *)array
                   atSegmentControl:(NSUInteger)index
                                filter:(NSString *)filter;

@end
