//
//  DetailTransaction.h
//  MPay
//
//  Created by Admin on 7/13/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ParentViewController.h"

@interface DetailTransaction : ParentViewController

@property (nonatomic, retain) NSMutableDictionary *Response;
@property (nonatomic, retain) NSDictionary *CardSelect;
@property (nonatomic, retain) NSString *RefNo, *CardNumberTrx, *AmtTrx;

@end
