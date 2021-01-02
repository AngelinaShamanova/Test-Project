//
//  CreditApplicationCell.h
//  Test-Project
//
//  Created by Angelina on 01.01.2021.
//

#import <Foundation/Foundation.h>

@interface CreditApplicationCell : NSObject

@property (strong, nonatomic) NSString *fullName;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *applicationStatus;
@property (strong, nonatomic) NSNumber *creditAmount;
@property (strong, nonatomic) NSString *comment;

@end