//
//  ViewController.m
//  MTSearchBarTest
//
//  Created by Mark Tezza on 09/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import "ViewController.h"

#import "MTStudent.h"
#import "MTGroup.h"

@interface ViewController ()
@property (nonatomic, strong)   NSArray             *sectionsArray;
@property (nonatomic, strong)   NSArray             *studentsArray;
@property (nonatomic, assign)   NSUInteger          currentMonth;
@property (nonatomic, assign)   NSUInteger          indexSegmentControl;

@property (nonatomic, strong)   NSOperation     *currentOperation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.indexSegmentControl = 0;
    [self generateRandomStudents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Actions

- (IBAction)actionSegmentControl:(UISegmentedControl *)sender {
    self.indexSegmentControl = sender.selectedSegmentIndex;
    
    [self generateSectionsInBackgroundFromArray:self.studentsArray filter:self.searchBar.text];
    /*
    MTGroup *group = [[MTGroup alloc] init];
    
    self.sectionsArray = [group generateSectionsFromArray:self.studentsArray
                                         atSegmentControl:self.indexSegmentControl
                                                   filter:self.searchBar.text];
    [self.tableView reloadData];
     */
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionsArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    MTGroup *group = [self.sectionsArray objectAtIndex:section];
    return group.name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MTGroup *group = [self.sectionsArray objectAtIndex:section];
    return group.mutableStudents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    MTGroup *group = [self.sectionsArray objectAtIndex:indexPath.section];
    MTStudent *student = [group.mutableStudents objectAtIndex:indexPath.row];
    
    if (self.indexSegmentControl > 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.surname, student.name];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.name, student.surname];
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", student.birthdayDate];
    
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *array = [NSMutableArray array];
    
    for (MTGroup *group in self.sectionsArray) {
        [array addObject:group.name];
    }
    
    return array;
}

#pragma mark -
#pragma mark UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self generateSectionsInBackgroundFromArray:self.studentsArray filter:self.searchBar.text];
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Private 

- (void)generateRandomStudents {
    self.studentsArray = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 100000; i++) {
        MTStudent *student = [MTStudent randomStudent];
        [array addObject:student];
    }

    self.studentsArray = array;
    
    if (self.indexSegmentControl == 0) {
        [self generateSectionsInBackgroundFromArray:self.studentsArray filter:self.searchBar.text];
    }
}

- (void)generateSectionsInBackgroundFromArray:(NSArray *)array filter:(NSString *)filterString {
    [self.currentOperation cancel];
    __weak ViewController *weakself = self;
    
    self.currentOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        MTGroup *group = [[MTGroup alloc] init];
        
        NSArray *sectionsArray = [group generateSectionsFromArray:self.studentsArray
                                                 atSegmentControl:self.indexSegmentControl
                                                           filter:self.searchBar.text];

        dispatch_async(dispatch_get_main_queue(), ^{
            weakself.sectionsArray = sectionsArray;
            [weakself.tableView reloadData];
            
            self.currentOperation = nil;
        });
    }];
    
    [self.currentOperation start];
}

@end
