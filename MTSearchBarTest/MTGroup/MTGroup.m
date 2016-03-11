//
//  MTGroup.m
//  MTSearchBarTest
//
//  Created by Mark Tezza on 10/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import "MTGroup.h"

#import "MTStudent.h"

@interface MTGroup ()
@property (nonatomic, strong)   NSArray     *studentsArray;
@property (nonatomic, assign)   NSUInteger  indexSegment;

@end

@implementation MTGroup

#pragma mark -
#pragma mark Public

- (NSArray *)generateSectionsFromArray:(NSArray *)array
                      atSegmentControl:(NSUInteger)index
                                filter:(NSString *)filter
{
    NSArray *sectionArray = [NSMutableArray array];
    self.indexSegment = index;
    
    NSSortDescriptor *monthDescriptor = [[NSSortDescriptor alloc] initWithKey:@"month" ascending:YES];
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSSortDescriptor *surnameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"surname" ascending:YES];

    switch (index) {
        case 0:
            array = [array sortedArrayUsingDescriptors:@[monthDescriptor, nameDescriptor, surnameDescriptor]];
            sectionArray = [self sectionOfDateFromArray:array filter:filter];
            break;
        case 1:
            array = [array sortedArrayUsingDescriptors:@[nameDescriptor, surnameDescriptor, monthDescriptor]];
            sectionArray = [self sectionOfNameFromArray:array filter:filter];
            break;
        case 2:
            array = [array sortedArrayUsingDescriptors:@[surnameDescriptor, nameDescriptor, monthDescriptor]];
            sectionArray = [self sectionOfNameFromArray:array filter:filter];
            break;

        default:
            break;
    }

    return sectionArray;
}

#pragma mark -
#pragma mark NSOperation


- (NSArray *)sectionOfDateFromArray:(NSArray *)array filter:(NSString *)filterString {
    NSMutableArray *sectionsArray = [NSMutableArray array];
    NSUInteger currentMonth = NSNotFound;
    
    for (MTStudent *student in array) {
        
        if ([student.name rangeOfString:filterString].location == NSNotFound
            && [student.surname rangeOfString:filterString].location == NSNotFound
            && filterString.length > 0) {
            continue;
        }
        
        NSUInteger firstMonth = student.month;
        
        MTGroup *section = nil;
        
        if (firstMonth != currentMonth) {
            section = [[MTGroup alloc] init];
            section.name = [NSString stringWithFormat:@"%@", student.monthSrtring];
            section.mutableStudents = [NSMutableArray array];
            currentMonth = firstMonth;
            
            [sectionsArray addObject:section];
        } else {
            section = [sectionsArray lastObject];
        }
        
        [section.mutableStudents addObject:student];
    }
    
    return sectionsArray;
}

- (NSArray *)sectionOfNameFromArray:(NSArray *)array filter:(NSString *)filterString {
    NSMutableArray *sectionsArray = [NSMutableArray array];
    NSString *currentLatter = nil;
    
    for (MTStudent *student in array) {
        if ([student.name rangeOfString:filterString].location == NSNotFound
            && [student.surname rangeOfString:filterString].location == NSNotFound
            && filterString.length > 0)
        {
            continue;
        }
        
        NSString *firstLatter;
        
        if (self.indexSegment > 1) {
            firstLatter = [student.surname substringToIndex:1];
        } else {
            firstLatter = [student.name substringToIndex:1];
        }
        
        MTGroup *section = nil;
        
        if (![firstLatter isEqualToString:currentLatter]) {
            section = [[MTGroup alloc] init];
            section.name = firstLatter;
            section.mutableStudents = [NSMutableArray array];
            currentLatter = firstLatter;
            
            [sectionsArray addObject:section];
        } else {
            section = [sectionsArray lastObject];
        }
        
        [section.mutableStudents addObject:student];
    }
    
    return sectionsArray;
}

@end
