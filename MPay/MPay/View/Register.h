//
//  Register.h
//  MPay
//
//  Created by Admin on 7/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ParentViewController.h"
#import <MessageUI/MessageUI.h>

@interface Register : ParentViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, MFMessageComposeViewControllerDelegate>

@property (nonatomic, retain) NSDictionary *SQdata;

-(IBAction)prepareForUnwindToRegister:(UIStoryboardSegue *)segue;

@end
