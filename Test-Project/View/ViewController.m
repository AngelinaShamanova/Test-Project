//
//  ViewController.m
//  Test-Project
//
//  Created by Angelina on 01.01.2021.
//

#import "ViewController.h"
#import "CreditApplicationCell.h"
#import "CustomCell.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<CreditApplicationCell *> *creditApplication;

@end

@implementation ViewController

//NSString *cellIdentifier = @"cellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchData];
    self.navigationItem.title = @"Заявки на кредит";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
//    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellIdentifier];
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
            NSString *creditAmount = dict[@"creditAmount"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.creditApplication.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    
        CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[CustomCell alloc] initWithFrame:CGRectZero];
        }

    CreditApplicationCell *creditApplication = self.creditApplication[indexPath.row];
    
    cell.fullNameLabel.text = creditApplication.fullName;
    cell.applicationStatuslabel.text = creditApplication.applicationStatus;
    cell.dateLabel.text = creditApplication.date;
    cell.creditAmountLabel.text = creditApplication.creditAmount;
    cell.commentLabel.text = @"Комментарий:";
    cell.comment.text = creditApplication.comment;
    
    if ([cell.applicationStatuslabel.text  isEqual: @"Одобрена"]) {
        cell.statusImageView.image = [UIImage imageNamed:@"green.png"];
    } else if ([cell.applicationStatuslabel.text  isEqual: @"На рассмотрении"]) {
        cell.statusImageView.image = [UIImage imageNamed:@"yellow.png"];
    } else {
        cell.statusImageView.image = [UIImage imageNamed:@"red.png"];
    }
    
    return cell;
}

@end

