//
//  ViewController.h
//  MTSearchBarTest
//
//  Created by Mark Tezza on 09/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController <UISearchBarDelegate>
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;

- (IBAction)actionSegmentControl:(UISegmentedControl *)sender;

@end

