//
//  SetPINConf.h
//  MPay
//
//  Created by Andi Wijaya on 10/17/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ParentViewController.h"

@interface SetPINConf : ParentViewController

@property (nonatomic, retain) NSMutableDictionary *pin;
@property (nonatomic, retain) NSMutableDictionary *data;
@property (nonatomic, retain) NSString *ActFile, *ActKey, *CustId, *CustMobileNo, *Bday;
@property (nonatomic, retain) NSMutableDictionary *PInfo;

@end
