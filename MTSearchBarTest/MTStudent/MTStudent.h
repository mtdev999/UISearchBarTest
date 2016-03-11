//
//  MTStudent.h
//  MTSearchBarTest
//
//  Created by Mark Tezza on 09/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTStudent : NSObject
@property (nonatomic, strong)   NSString    *name;
@property (nonatomic, strong)   NSString    *surname;
@property (nonatomic, strong)   NSString    *birthdayDate;
@property (nonatomic, strong)   NSString    *monthSrtring;
@property (nonatomic, assign)   NSUInteger  month;
@property (nonatomic, assign)   NSUInteger  year;

+ (MTStudent *)randomStudent;

@end
