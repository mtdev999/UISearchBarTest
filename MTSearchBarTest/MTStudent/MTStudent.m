//
//  MTStudent.m
//  MTSearchBarTest
//
//  Created by Mark Tezza on 09/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import "MTStudent.h"

static NSString * const firstName[] = {
    @"Emily", @"James", @"Chloe", @"Jack", @"Megan", @"Alex", @"Charlotte", @"Ben", @"Emma", @"Daniel",
    @"Lauren", @"Tom", @"Ellie", @"Matthew", @"Hannah", @"Adam", @"Sophie", @"Sam", @"Katie", @"Ryan",
    @"Amy", @"Callum", @"Lucy", @"Thomas", @"Olivia", @"David", @"Holly", @"Joe", @"Jessica", @"Lewis",
    @"Georgia", @"Josh", @"Rebecca", @"Jake", @"Sarah", @"Harry", @"Caitlin", @"Liam", @"Beth", @"William",
    @"Bethany", @"Kieran", @"Molly", @"Luke", @"Grace", @"Connor", @"Rachel", @"Joshua", @"Laura", @"Charlie"
};

static NSString * const lastName[] = {
    @"Smith", @"Johnson", @"Williams", @"Jones", @"Brown", @"Davis", @"Miller", @"Wilson", @"Moore", @"Taylor",
    @"Anderson", @"Thomas", @"Jackson", @"White", @"Harris", @"Martin", @"Thompson", @"Garcia", @"Martinez", @"Robinson",
    @"Clark", @"Rodriguez", @"Lewis", @"Lee", @"Walker", @"Hall", @"Allen", @"Young", @"Hernandez", @"King",
    @"Wright", @"Lopez", @"Hill", @"Scott", @"Green", @"Adams", @"Baker", @"Gonzalez", @"Nelson", @"Carter",
    @"Mitchell", @"Perez", @"Roberts", @"Turner", @"Phillips", @"Campbell", @"Parker", @"Evans", @"Edwards", @"Collins"
};

static int countName = 50;

@implementation MTStudent

+ (MTStudent *)randomStudent {
    MTStudent *student = [[MTStudent alloc] init];
    student.name = firstName[arc4random_uniform(countName)];
    student.surname = lastName[arc4random_uniform(countName)];
    student.birthdayDate = [student stringBirthdayDate];
    
    return student;
}

- (NSString *)stringBirthdayDate {
    NSUInteger year = arc4random_uniform(15) + 1985;
    NSUInteger month = arc4random_uniform(120)/10 + 1;
    NSUInteger day = arc4random_uniform(31);
    
    NSString *monthString;
    switch (month) {
        case 1:
            monthString = @"Jan";
            break;
        case 2:
            monthString = @"Feb";
            break;
        case 3:
            monthString = @"Mar";
            break;
        case 4:
            monthString = @"Apr";
            break;
        case 5:
            monthString = @"May";
            break;
        case 6:
            monthString = @"Jun";
            break;
        case 7:
            monthString = @"Jul";
            break;
        case 8:
            monthString = @"Aug";
            break;
        case 9:
            monthString = @"Sep";
            break;
        case 10:
            monthString = @"Oct";
            break;
        case 11:
            monthString = @"Nov";
            break;
        case 12:
            monthString = @"Dec";
            break;
            
        default:
            break;
    }
    
    self.year = year;
    self.month = month;
    self.monthSrtring = monthString;
    
    NSString *dayOffset;
    if (day < 10) {
        dayOffset = [NSString stringWithFormat:@"0%lu",day];
    } else {
        dayOffset = [NSString stringWithFormat:@"%lu",day];
    }
    
    NSString *birthdayDate = [NSString stringWithFormat:@"%@ %@, %lu", monthString, dayOffset, year];
    
    return birthdayDate;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ %lu", self.name, self.surname, self.month];
}

@end
