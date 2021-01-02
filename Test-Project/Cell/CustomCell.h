//
//  CustomCell.h
//  Test-Project
//
//  Created by Angelina on 02.01.2021.
//

#import <UIKit/UIKit.h>

@interface CustomCell: UITableViewCell {
    UILabel *fullNameLabel;
    UILabel *dateLabel;
    UILabel *applicationStatuslabel;
    UILabel *creditAmountLabel;
    UILabel *commentLabel;
    UILabel *comment;
    UIImageView *statusImageView;
}

@property(nonatomic,retain)UILabel *fullNameLabel;
@property(nonatomic,retain)UILabel *dateLabel;
@property(nonatomic,retain)UILabel *applicationStatuslabel;
@property(nonatomic,retain)UILabel *creditAmountLabel;
@property(nonatomic,retain)UILabel *commentLabel;
@property(nonatomic,retain)UILabel *comment;
@property(nonatomic,retain)UIImageView *statusImageView;

@end
