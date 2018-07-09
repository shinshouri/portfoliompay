//
//  PersonalInformation.h
//  MPay
//
//  Created by Admin on 7/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ParentViewController.h"

@interface PersonalInformation : ParentViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableDictionary *data;
@property (nonatomic, retain) NSString *Name, *MobileNo, *BDay;

@end
