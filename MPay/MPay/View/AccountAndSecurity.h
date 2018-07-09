//
//  AccountAndSecurity.h
//  MPay
//
//  Created by Admin on 7/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ParentViewController.h"

@interface AccountAndSecurity : ParentViewController

@property(nonatomic, retain) NSMutableDictionary *data;

-(IBAction)prepareForUnwindToAccAndSec:(UIStoryboardSegue *)segue;

@end
