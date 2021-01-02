//
//  TableViewController.m
//  Test-Project
//
//  Created by Angelina on 01.01.2021.
//

#import "TableViewController.h"
#import "CreditApplication.h"
#import "CustomCell.h"
#import "NSMutableAttributedString+Color.h"

@interface TableViewController () <UISearchResultsUpdating> {
    BOOL isSearching;
}

@property (strong, nonatomic) NSMutableArray<CreditApplication *> *creditApplication;

@end

@implementation TableViewController
@synthesize searchBar;
@synthesize searchBarController;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.searchBar resignFirstResponder];
    self.searchBar.delegate = self;
    searchBar.enablesReturnKeyAutomatically = NO;
    [self fetchData];
    self.tableView.dataSource = self;
    self.navigationItem.title = @"Заявки на кредит";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.tableView.allowsSelection = NO;
    searchBarController = [self searchControllerUseCustomSetting];
    searchBarController.searchBar.placeholder = @"Поиск по комментарию";
}

- (void)searchTableList {
    NSString *searchString = searchBar.text;
    NSMutableArray<CreditApplication *> *creditApplicationArray = NSMutableArray.new;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains[cd] %@", searchString];
    creditApplicationArray = [NSMutableArray arrayWithArray:[self.creditApplication filteredArrayUsingPredicate:predicate]];
    
    for (NSDictionary *comment in creditApplicationArray) {
        [_filteredContentList arrayByAddingObjectsFromArray: comment];
    }
    
    NSLog(@"%@", self.creditApplication);
}

- (void)fetchData {
    NSString *urlString = @"https://raw.githubusercontent.com/AngelinaShamanova/JSONForTest/main/db.json";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSArray *jsonFile = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err){
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }
        
        NSMutableArray<CreditApplication *> *creditApplications = NSMutableArray.new;
        for (NSDictionary *dict in jsonFile) {
            NSString *fullName = dict[@"fullName"];
            NSString *creditAmount = dict[@"creditAmount"];
            NSString *date = dict[@"date"];
            NSString *applicationStatus = dict[@"applicationStatus"];
            NSString *comment = dict[@"comment"];
            CreditApplication *creditApplicationCell = CreditApplication.new;
            creditApplicationCell.fullName = fullName;
            creditApplicationCell.applicationStatus = applicationStatus;
            creditApplicationCell.date = date;
            creditApplicationCell.creditAmount = creditAmount;
            creditApplicationCell.comment = comment;
            [creditApplications addObject:creditApplicationCell];
        }
        
        self.creditApplication = creditApplications;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        
    }] resume];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearching) {
        return [_filteredContentList count];
    }
    else {
        return [self.creditApplication count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithFrame:CGRectZero];
    }
    
    CreditApplication *creditApplication = self.creditApplication[indexPath.row];
    
    cell.fullNameLabel.text = creditApplication.fullName;
    cell.applicationStatuslabel.text = creditApplication.applicationStatus;
    cell.dateLabel.text = creditApplication.date;
    cell.creditAmountLabel.text = creditApplication.creditAmount;
    cell.commentLabel.text = @"Комментарий:";
    cell.comment.text = creditApplication.comment;
    
    if ([creditApplication.comment isEqual: @""]) {
        cell.commentLabel.hidden = TRUE;
    }
    
    if ([cell.applicationStatuslabel.text  isEqual: @"Одобрена"]) {
        cell.statusImageView.image = [UIImage imageNamed:@"green.png"];
    } else if ([cell.applicationStatuslabel.text  isEqual: @"На рассмотрении"]) {
        cell.statusImageView.image = [UIImage imageNamed:@"yellow.png"];
    } else {
        cell.statusImageView.image = [UIImage imageNamed:@"red.png"];
    }
//
//    if (isSearching) {
//        NSString *strColor=[filteredContentList objectAtIndex:indexPath.row];
//        NSString *strName=searchBar.text;
//
//        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:strColor];
//        [string setColorForText:strName withColor:[UIColor redColor]];
//        cell.comment.attributedText = string;
//    } else {
//        NSString *strColor=self.creditApplication[indexPath.row].comment;
//        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:strColor];
//        cell.comment.attributedText = string;
//    }
    
    return cell;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;

}

- (UISearchController*)searchControllerUseCustomSetting {
    UISearchController *searchBarController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.definesPresentationContext = true;
    searchBarController.searchResultsUpdater = self;
    searchBarController.obscuresBackgroundDuringPresentation = false;
    searchBarController.hidesNavigationBarDuringPresentation = true;
    
    self.tableView.tableHeaderView = searchBarController.searchBar;
    
    return searchBarController;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSDictionary *,id> * _Nullable bindings) {
        NSDictionary *dic = evaluatedObject;
        
        NSString *searchText = searchController.searchBar.text;
        
        if (searchText.length == 0) {
            return false;
        }else{
            NSString *sourceText = dic[@"comment"];
            return [sourceText.lowercaseString containsString:searchText.lowercaseString];
        }
    }];
    
    _filteredContentList = [self.creditApplication filteredArrayUsingPredicate: predicate];
    [self.tableView reloadData];
}

@end

