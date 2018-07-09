//
//  AddExpDate.m
//  MPay
//
//  Created by Admin on 7/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AddExpDate.h"
#import "CardVerification.h"
#import "Login.h"

@implementation AddExpDate
{
    UIButton *ADD;
    UITextField *exp, *cvv;
    UILabel *txtlabel;
    UIImageView *imgcard;
}
@synthesize CardNumber, ExpCard;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"debitOrCreditCard"];
}

- (void)UI {
    UIView *bgview = [self UIView:self withFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-60)];
    [[bgview layer] setCornerRadius:10];
    //Card Image
    imgcard = [self UIImage:self withFrame:CGRectMake((bgview.frame.size.width/2)-40, 30, 80, 50) withImageName:@"FCard.png"];
    [[imgcard layer] setCornerRadius:5];
    [[imgcard layer] setBorderWidth:1.0];
    [[imgcard layer] setBorderColor:[UIColor grayColor].CGColor];
    [bgview addSubview:imgcard];
    //Text Label
    txtlabel = [self UILabel:self withFrame:CGRectMake(20, 110, bgview.frame.size.width-40, 50) withText:@"enterExpDateDesc" withTextSize:textsize12 withAlignment:1 withLines:0];
    [bgview addSubview:txtlabel];
    //Card No
    UILabel *CN = [self UILabel:self withFrame:CGRectMake(20, 160, (bgview.frame.size.width-40)/4, 40) withText:[CardNumber substringFromIndex:15] withTextSize:24 withAlignment:0 withLines:0];
    [CN setTextColor:[self colorFromHexString:@"#6E6E6E" withAlpha:1.0]];
    [bgview addSubview:CN];
    [bgview addSubview:[self UIButton:self withFrame:CGRectMake(20, 160, (bgview.frame.size.width-40)/4, 40) withTitle:@"" withTag:0]];
    //Exp Date
    exp = [self UITextField:self withFrame:CGRectMake(((bgview.frame.size.width-40)/4)+20, 160, (bgview.frame.size.width-40)/2, 40) withText:@"MM / YY" withSize:24 withInputType:UIKeyboardTypeNumberPad withSecure:0];
    exp.delegate = self;
    [exp setTag:0];
    [exp setTextAlignment:NSTextAlignmentCenter];
    [bgview addSubview:exp];
    //CVV
    cvv = [self UITextField:self withFrame:CGRectMake((bgview.frame.size.width-20)-((bgview.frame.size.width-40)/4), 160, (bgview.frame.size.width-40)/4, 40) withText:@"CVV" withSize:24 withInputType:UIKeyboardTypeNumberPad withSecure:1];
    cvv.delegate = self;
    [cvv setTag:1];
    [cvv setTextAlignment:NSTextAlignmentRight];
    [bgview addSubview:cvv];
    //Add Card
    ADD = [self UIButton:self withFrame:CGRectMake(btnmarginleft, ([self view].frame.size.height/2)-50, bgview.frame.size.width-(btnmarginleft*2), btnheight) withTitle:[@"addCard" uppercaseString] withTag:1];
    [ADD setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    [ADD setEnabled:NO];
    [bgview addSubview:ADD];
    
    [[self view] addSubview:bgview];
    [exp becomeFirstResponder];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
    if([sender tag] == 1)
    {
        if ([[exp text] length] > 0 && [[cvv text] length] > 0) {
            if ([[[[exp text] substringToIndex:2] stringByReplacingOccurrencesOfString:@"/" withString:@""] length] == 2 && [[[exp text] substringToIndex:2] intValue] <= 12 && [[[exp text] substringToIndex:2] intValue] > 0) {
//                [self RequestAPIRequestOTPCard];
                self.tabBarController.title = @"";
                [self performSegueWithIdentifier:@"CardVerify" sender:self];
            } else {
                [self showAlert:@"invalidExpiredCard" title:@"warning" btn:@"ok" tag:0 delegate:self];
            }
        }
        else {
            [self showAlert:@"inputAllField" title:@"warning" btn:@"ok" tag:0 delegate:self];
        }
    }
}

#pragma mark - Segue Delegate
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"CardVerify"]) {
        CardVerification *NVC = [segue destinationViewController];
        NVC.data = [NSDictionary dictionaryWithObjectsAndKeys:[CardNumber stringByReplacingOccurrencesOfString:@" " withString:@""] ,@"cardNumber", [exp text], @"expDate", [cvv text], @"cvv", nil];
        NVC.HP = [[response objectForKey:@"params"] objectForKey:@"mobileNumber"];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField tag] == 0) {
        [imgcard setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"FCard.png"]]];
        [txtlabel setText:@"enterExpDateDesc"];
    } else if ([textField tag] == 1) {
        [imgcard setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"BCard.png"]]];
        [txtlabel setText:@"enterCvvDesc"];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    if ([textField tag] == 0) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if (newLength >= 5 && [[cvv text] length] >= 3) {
            [ADD setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
            [ADD setEnabled:YES];
        }
        else
        {
            [ADD setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
            [ADD setEnabled:NO];
        }
        if ([exp.text length] == 2 && newLength == 3) {
            exp.text = [exp.text stringByAppendingString:@"/"];
        } else if (newLength == 3) {
            exp.text = [exp.text stringByReplacingOccurrencesOfString:@"/" withString:@""];
        }
        if (newLength >= 6) {
            [cvv becomeFirstResponder];
        }
        
        return newLength <= 5;
    }
    else
    if ([textField tag] == 1) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if (newLength >= 3 && [[exp text] length] >= 5) {
            [ADD setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
            [ADD setEnabled:YES];
        }
        else
        {
            [ADD setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
            [ADD setEnabled:NO];
        }
        
        return newLength <= 3;
    }
    return NO;
}

//-(void)RequestAPIRequestOTPCard {
//    [[self view] endEditing:YES];
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"RequestOTPCard" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[CardNumber stringByReplacingOccurrencesOfString:@" " withString:@""], @"cardNumber", [exp text], @"expDate", [cvv text], @"cvv", @"N", @"resendFlag", @"addCard", @"view", nil]];
////        NSLog(@"Request OTP = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                if ([[[response objectForKey:@"params"] objectForKey:@"isBlocked"] isEqualToString:@"Y"]) {
//                    [self showAlert:@"You cannot resend verification code in 30 minutes" title:@"Suspend Time" btn:L(@"ok") tag:0 delegate:self];
//                } else {
//                    self.tabBarController.title = @"";
//                    [self performSegueWithIdentifier:@"CardVerify" sender:self];
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

@end
