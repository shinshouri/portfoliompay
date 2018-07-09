//
//  DetailCell.m
//  MPay
//
//  Created by Admin on 7/14/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell
@synthesize mainLabel, descriptionLabel, voidLabel, rightLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, [self viewForBaselineLayout].frame.size.width-40, 25)];
        self.mainLabel.textColor = [UIColor blackColor];
        self.mainLabel.font = [UIFont systemFontOfSize:16.0f];
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, [self viewForBaselineLayout].frame.size.width-40, 20)];
        self.descriptionLabel.textColor = [UIColor grayColor];
        self.descriptionLabel.font = [UIFont systemFontOfSize:10.0f];
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, [self viewForBaselineLayout].frame.size.width-40, 40)];
        self.rightLabel.textColor = [UIColor blackColor];
        self.rightLabel.font = [UIFont systemFontOfSize:18.0f];
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        self.voidLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [self viewForBaselineLayout].frame.size.width-40, 20)];
        self.voidLabel.textColor = [UIColor blackColor];
        self.voidLabel.textAlignment = NSTextAlignmentRight;
        self.voidLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        
        [self addSubview:self.mainLabel];
        [self addSubview:self.descriptionLabel];
        [self addSubview:self.rightLabel];
        [self addSubview:self.voidLabel];
        
    }
    return self;
}

//- (void)awakeFromNib {
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

