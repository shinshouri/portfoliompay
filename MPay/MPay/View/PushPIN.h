//
//  PushPIN.h
//  MPay
//
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ParentViewController.h"

@interface PushPIN : ParentViewController

@property (nonatomic, retain) NSMutableDictionary *data;
@property (nonatomic, retain) NSDictionary *CardSelect;

-(IBAction)prepareForUnwindToPIN:(UIStoryboardSegue *)segue;

@end
