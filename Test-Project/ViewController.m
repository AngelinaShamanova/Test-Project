//
//  ViewController.m
//  Test-Project
//
//  Created by Angelina on 01.01.2021.
//

#import "ViewController.h"
#import "CreditApplicationCell.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<CreditApplicationCell *> *creditApplication;

@end

@implementation ViewController

NSString *cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchData];
    self.navigationItem.title = @"Заявки на кредит";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellId];
}

- (void)fetchData {
    NSLog(@"Fetching Data");

    NSString *urlString = @"https://raw.githubusercontent.com/AngelinaShamanova/JSONForTest/main/db.json";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"Finished fetching data....");
        
        NSError *err;
        NSArray *jsonFile = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err){
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }
        
        NSMutableArray<CreditApplicationCell *> *creditApplications = NSMutableArray.new;
        for (NSDictionary *dict in jsonFile) {
            NSString *fullName = dict[@"fullName"];
            NSNumber *creditAmount = dict[@"creditAmount"];
            NSString *date = dict[@"date"];
            NSString *applicationStatus = dict[@"applicationStatus"];
            NSString *comment = dict[@"comment"];
            CreditApplicationCell *creditApplicationCell = CreditApplicationCell.new;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.creditApplication.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    
    CreditApplicationCell *creditApplication = self.creditApplication[indexPath.row];
    
    cell.textLabel.text = creditApplication.fullName;

    return cell;
}

@end

