//
//  CustomCell.m
//  Test-Project
//
//  Created by Angelina on 02.01.2021.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize fullNameLabel, dateLabel, applicationStatuslabel,
creditAmountLabel, commentLabel, comment, statusImageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        fullNameLabel = [[UILabel alloc]init];
        fullNameLabel.textAlignment = NSTextAlignmentLeft;
        fullNameLabel.font = [UIFont systemFontOfSize:18];
        
        applicationStatuslabel = [[UILabel alloc]init];
        applicationStatuslabel.textAlignment = NSTextAlignmentLeft;
        applicationStatuslabel.font = [UIFont systemFontOfSize:14];
        
        dateLabel = [[UILabel alloc]init];
        dateLabel.textAlignment = NSTextAlignmentLeft;
        dateLabel.font = [UIFont systemFontOfSize:12];
        
        creditAmountLabel = [[UILabel alloc]init];
        creditAmountLabel.textAlignment = NSTextAlignmentLeft;
        creditAmountLabel.font = [UIFont systemFontOfSize:16];
        
        comment = [[UILabel alloc]init];
        comment.textAlignment = NSTextAlignmentLeft;
        comment.font = [UIFont systemFontOfSize:12];

        commentLabel = [[UILabel alloc]init];
        commentLabel.textAlignment = NSTextAlignmentLeft;
        commentLabel.font = [UIFont systemFontOfSize:12];
        
        statusImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:fullNameLabel];
        [self.contentView addSubview:dateLabel];
        [self.contentView addSubview:applicationStatuslabel];
        [self.contentView addSubview:creditAmountLabel];
        [self.contentView addSubview:comment];
        [self.contentView addSubview:commentLabel];
        [self.contentView addSubview:statusImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    CGRect frame;
    frame= CGRectMake(boundsX + 20, 55, 30, 30);
    statusImageView.frame = frame;
    
    frame= CGRectMake(boundsX + 70, 20, 300, 25);
    fullNameLabel.frame = frame;
    
    frame= CGRectMake(boundsX + 70, 40, 300, 20);
    dateLabel.frame = frame;
    dateLabel.textColor = UIColor.lightGrayColor;
    
    frame= CGRectMake(boundsX + 70, 60, 300, 25);
    applicationStatuslabel.frame = frame;
    
    frame= CGRectMake(boundsX + 70, 80, 300, 25);
    creditAmountLabel.frame = frame;
    creditAmountLabel.textColor = UIColor.darkGrayColor;
    
    frame= CGRectMake(boundsX + 70, 100, 300, 25);
    commentLabel.frame = frame;
    
    frame= CGRectMake(boundsX + 70, 110, 300, 25);
    comment.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
[super setSelected:selected animated:animated];
}


@end


