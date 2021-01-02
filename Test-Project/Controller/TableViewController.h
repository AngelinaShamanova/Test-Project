//
//  TableViewController.h
//  Test-Project
//
//  Created by Angelina on 01.01.2021.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <UISearchBarDelegate>

@property (strong, nonatomic) NSArray<NSDictionary*> *filteredContentList;
@property (weak, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchController *searchBarController;

@end

