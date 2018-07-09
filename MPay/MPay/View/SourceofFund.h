//
//  SourceofFund.h
//  MPay
//
//  Created by Admin on 7/14/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ParentViewController.h"

@interface SourceofFund : ParentViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableArray *CardList;

@end
