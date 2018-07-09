//
//  CustomPIN.h
//  MPay
//
//  Created by Andi Wijaya on 10/14/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ParentViewController.h"

@interface CustomPIN : ParentViewController

@property (nonatomic, retain) NSMutableDictionary *data;
@property (nonatomic, retain) NSDictionary *CardSelect;
@property (nonatomic, retain) NSString *CardNumberTrx;
@property (nonatomic, retain) NSString *AmtVal;

-(IBAction)prepareForUnwindToPIN:(UIStoryboardSegue *)segue;

@end
