//
//  ImageCell.m
//
//  Created by MC on 7/7/15.
//

#import "ImageCell.h"

@implementation ImageCell
@synthesize img, mainLabel, descriptionLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 60, 40)];
        [[[self img] layer]setCornerRadius:5];
        [[self img] setClipsToBounds:YES];
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, [self viewForBaselineLayout].frame.size.width-70, 25)];
        self.mainLabel.textColor = [UIColor blackColor];
        self.mainLabel.font = [UIFont systemFontOfSize:16.0f];
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, [self viewForBaselineLayout].frame.size.width-70, 20)];
        self.descriptionLabel.textColor = [UIColor grayColor];
        self.descriptionLabel.font = [UIFont systemFontOfSize:12.0f];
        
        [self addSubview:self.img];
        [self addSubview:self.mainLabel];
        [self addSubview:self.descriptionLabel];
        
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
