//
//  SetPIN.h
//  MPay
//
//  Created by Admin on 7/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ParentViewController.h"

@interface SetPIN : ParentViewController

@property (nonatomic, retain) NSString *ActFile, *ActKey, *CustId, *CustMobileNo, *Bday;
@property (nonatomic, retain) NSMutableDictionary *data;
@property (nonatomic, retain) NSMutableDictionary *PInfo;

@end
