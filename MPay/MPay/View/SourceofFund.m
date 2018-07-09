//
//  SourceofFund.m
//  MPay
//
//  Created by Admin on 7/14/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "SourceofFund.h"
#import "ImageCell.h"
#import "Login.h"

@implementation SourceofFund
{
    NSInteger index;
    UIView *pop, *view;
    UILabel *lbl;
}
@synthesize table, CardList;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
}

-(void)viewWillAppear:(BOOL)animated {
//    [[self navigationItem] setTitle:L(@"sourceOfFund")];
}

- (void)UI {
    lbl =[self UILabel:self withFrame:CGRectMake(10, 65, self.view.frame.size.width-20, 30) withText:@"setAsDefault" withTextSize:textsize16 withAlignment:0 withLines:0];
    [lbl setFont:[UIFont boldSystemFontOfSize:textsize24]];
    [[self view] addSubview:lbl];
    
//    [[self view] addSubview:[self UIView:self withFrame:CGRectMake(0, 120, self.view.frame.size.width, [self view].frame.size.height-120)]];
    
    UIView *line = [self UIView:self withFrame:CGRectMake(0, 110, [self view].frame.size.width, 1)];
    [line setBackgroundColor:[self colorFromHexString:@"#E7E7E7" withAlpha:1.0]];
    [[self view] addSubview:line];
    
    table = [self UITableView:self withFrame:CGRectMake(0, 111, self.view.frame.size.width, [self view].frame.size.height-111) withStyle:0];
    [table setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    [[self view] addSubview:table];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        [view removeFromSuperview];
    }
    else if([sender tag] == 1)
    {
        if ([[[CardList objectAtIndex:index] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
            [self showAlert:@"cannotDeleteECashCard" title:@"warning" btn:@"ok" tag:0 delegate:self];
        }
        else {
            [view removeFromSuperview];
//            [self RequestAPIDeleteRegisterCard];
        }
    }
}

-(void)PopUpDelete {
    view = [self UIView:self withFrame:CGRectMake(0, 0, [self view].frame.size.width, [self view].frame.size.height)];
    [view setBackgroundColor:[self transparentBlack]];
    pop = [self UIView:self withFrame:CGRectMake(0, 0, [self view].frame.size.width-100, 180)];
    [pop setBackgroundColor:[UIColor whiteColor]];
    [pop setCenter:[[self view] center]];
    [pop setClipsToBounds:NO];
    [[pop layer] setCornerRadius:15];
    [[pop layer] setBorderWidth:0.1];
    [[pop layer] setBorderColor:[UIColor blackColor].CGColor];
    
    [pop addSubview:[self UIImageServer:self withFrame:CGRectMake((pop.frame.size.width/2)-40, 20, 80, 50) withImageName:[NSString stringWithFormat:@"%@.png",[[CardList objectAtIndex:index] objectForKey:@"cardType"]]]];
    
    [pop addSubview:[self UILabel:self withFrame:CGRectMake(0, 65, pop.frame.size.width, 50) withText:[NSString stringWithFormat:@"confirmDeleteCard%@", [[CardList objectAtIndex:index] objectForKey:@"last4digitCardNo"]] withTextSize:14 withAlignment:1 withLines:0]];
    
    [pop addSubview:[self UIView:self withFrame:CGRectMake(0, 115, pop.frame.size.width, 1)]];
    
    UIButton *Cancel = [self UIButton:self withFrame:CGRectMake(0, pop.frame.size.height-50, pop.frame.size.width/2, 50) withTitle:@"cancel" withTag:0];
    [Cancel setTitleColor:[self colorFromHexString:@"#0076FF" withAlpha:1.0] forState:UIControlStateNormal];
    [[Cancel layer] setCornerRadius:0];
    [[Cancel layer] setBorderWidth:0.5];
    [[Cancel layer] setBorderColor:[UIColor grayColor].CGColor];
    [pop addSubview:Cancel];
    
    UIButton *Del = [self UIButton:self withFrame:CGRectMake(pop.frame.size.width/2, pop.frame.size.height-50, pop.frame.size.width/2, 50) withTitle:@"delete" withTag:1];
    [Del setTitleColor:[self colorFromHexString:@"#DA0000" withAlpha:1.0] forState:UIControlStateNormal];
    [[Del layer] setCornerRadius:0];
    [[Del layer] setBorderWidth:0.5];
    [[Del layer] setBorderColor:[UIColor grayColor].CGColor];
    [pop addSubview:Del];
    
    [view addSubview:pop];
    [[self view] addSubview:view];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [CardList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[ImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.img.image = [UIImage imageNamed:[[CardList objectAtIndex:[indexPath row]] objectForKey:@"cardType"]];
    cell.mainLabel.text = [[CardList objectAtIndex:[indexPath row]] objectForKey:@"cardName"];
    cell.mainLabel.textColor = [self colorFromHexString:@"#6E6E6E" withAlpha:1.0];
    cell.descriptionLabel.text = [NSString stringWithFormat:@"(%@)", [[CardList objectAtIndex:[indexPath row]] objectForKey:@"last4digitCardNo"]];
    cell.descriptionLabel.textColor = [self colorFromHexString:@"#6E6E6E" withAlpha:1.0];
    if([[[CardList objectAtIndex:[indexPath row]] objectForKey:@"isDefaultCard"] isEqualToString:@"Y"])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Tableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([[[CardList objectAtIndex:[indexPath row]] objectForKey:@"isDefaultCard"] isEqualToString:@"N"]) {
        index = [indexPath row];
//        [self RequestAPISetDefaultCard];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
//    NSLog(@"%lu %li", (unsigned long)[CardList count], (long)[indexPath row]);
//    if ([defaults objectForKey:@"isDeleted"]) {
//        if ([[[CardList objectAtIndex:[indexPath row]-1] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
//            return NO;
//        }
//    } else {
//        if ([[[CardList objectAtIndex:[indexPath row]] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
//            return NO;
//        }
//    }
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        index = [indexPath row];
        [self PopUpDelete];
//        [self showAlert2:@"Are you sure want to unlink this Visa card(4567)" title:@"" btn1:L(@"cancel") btn2:L(@"delete") tag:0 delegate:self];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"delete";
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 0) {
        if(buttonIndex == 1)
        {
            if ([[[CardList objectAtIndex:index] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
                [self showAlert:@"cannotDeleteECashCard" title:@"warning" btn:@"ok" tag:0 delegate:self];
            }
            else {
//                [self RequestAPIDeleteRegisterCard];
            }
        }
    }
}

//-(void)RequestAPIGetSourceOfFundList {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"GetSourceOfFundList" withParams:nil];
////        NSLog(@"Source Fund = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                CardList = [[[response objectForKey:@"params"] objectForKey:@"sourceOfFundList"] mutableCopy];
//                [lbl removeFromSuperview];
//                [table removeFromSuperview];
//                [self UI];
//                [defaults removeObjectForKey:@"isDeleted"];
//            }
//            else if([[response objectForKey:@"logout"] intValue] == 1)
//            {
//                [self showAlert:L(@"systemRestart") title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                [defaults setObject:@"N" forKey:@"StatusLogin"];
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
//                [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                [[self topViewController] presentViewController:myVC animated:NO completion:nil];
//            }
//            else
//            {
//                [maskView removeFromSuperview];
//                if ([[response objectForKey:@"message"] containsString:@"||||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                } else if ([[response objectForKey:@"message"] containsString:@"||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                } else {
//                    [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                }
//            }
//        });
//    });
//}

//-(void)RequestAPIDeleteRegisterCard {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"DeleteRegisterCard" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[[CardList objectAtIndex:index] objectForKey:@"cardId"], @"cardId", [[CardList objectAtIndex:index] objectForKey:@"cardType"], @"cardType", [[CardList objectAtIndex:index] objectForKey:@"cardFinancial"], @"cardFinancial", nil]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                if([[[CardList objectAtIndex:index] objectForKey:@"isDefaultCard"] isEqualToString:@"Y"]) {
//                    [CardList removeObjectAtIndex:index];
//                    for (int i = 0; i < [CardList count]; i++) {
//                        if ([[[CardList objectAtIndex:i] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
//                            index = i;
//                        }
//                    }
//                    [self RequestAPISetDefaultCard];
//                } else {
//                    [CardList removeObjectAtIndex:index];
//                    [defaults setObject:@"delete" forKey:@"Deleted"];
//                    [defaults setObject:@"delete" forKey:@"isDelete"];
//                    [table reloadData];
//                }
//            }
//            else if([[response objectForKey:@"logout"] intValue] == 1)
//            {
//                [self showAlert:L(@"systemRestart") title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                [defaults setObject:@"N" forKey:@"StatusLogin"];
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
//                [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                [[self topViewController] presentViewController:myVC animated:NO completion:nil];
//            }
//            else
//            {
//                [maskView removeFromSuperview];
//                if ([[response objectForKey:@"message"] containsString:@"||||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                } else if ([[response objectForKey:@"message"] containsString:@"||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                } else {
//                    [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                }
//            }
//        });
//    });
//}

//-(void)RequestAPISetDefaultCard {
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"SetDefaultCard" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[[CardList objectAtIndex:index] objectForKey:@"cardId"],@"cardId", [[CardList objectAtIndex:index] objectForKey:@"cardFinancial"], @"cardFinancial", [[CardList objectAtIndex:index] objectForKey:@"cardType"], @"cardType", nil]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults setObject:@"delete" forKey:@"Deleted"];
//                [view removeFromSuperview];
//                [self RequestAPIGetSourceOfFundList];
//            }
//            else if([[response objectForKey:@"logout"] intValue] == 1)
//            {
//                [self showAlert:L(@"systemRestart") title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                [defaults setObject:@"N" forKey:@"StatusLogin"];
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
//                [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                [[self topViewController] presentViewController:myVC animated:NO completion:nil];
//            }
//            else
//            {
//                [maskView removeFromSuperview];
//                if ([[response objectForKey:@"message"] containsString:@"||||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                } else if ([[response objectForKey:@"message"] containsString:@"||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                } else {
//                    [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                }
//            }
//        });
//    });
//}

@end
