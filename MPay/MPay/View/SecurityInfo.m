//
//  SecurityInfo.m
//  MPay
//
//  Copyright © 2016 Admin. All rights reserved.
//

#import "SecurityInfo.h"
#import "Login.h"

@implementation SecurityInfo
{
    UIScrollView *bgview;
    UITextField *Answer;
    UIButton *btn;
    UILabel *SecurityQuestion, *SecurityQuestionLabel, *AnswerLabel;
}
@synthesize SQCode, SQuestion;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"securityInfo"];
}

- (void)UI {
    [bgview removeFromSuperview];
    bgview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-60)];
    [bgview setBackgroundColor:[UIColor clearColor]];
    bgview.contentSize = CGSizeMake(0, 500);
    bgview.showsVerticalScrollIndicator = NO;
    bgview.delegate = self;
    [[bgview layer] setCornerRadius:10];
    
    [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, [self view].frame.size.height/18, bgview.bounds.size.width-40, 60) withText:@"securityInfoDesc" withTextSize:textsize16 withAlignment:0 withLines:0]];
    SecurityQuestionLabel = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*3.5, bgview.bounds.size.width-40, 15) withText:@"securityQuestion" withTextSize:textsize12 withAlignment:0 withLines:0];
    [bgview addSubview:SecurityQuestionLabel];
    SecurityQuestion = [self UILabel:self withFrame:CGRectMake(20, SecurityQuestionLabel.frame.origin.y + 15, bgview.bounds.size.width-40, 40) withText:@"securityQuestion" withTextSize:textsize16 withAlignment:0 withLines:0];
    [SecurityQuestion setText:SQuestion];
    [SecurityQuestion setTag:0];
    [bgview addSubview:SecurityQuestion];
    
    AnswerLabel = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*6, bgview.bounds.size.width-40, 15) withText:@"answer" withTextSize:textsize12 withAlignment:0 withLines:0];
    [AnswerLabel setHidden:YES];
    [bgview addSubview:AnswerLabel];
    Answer = [self CustomTextField:CGRectMake(20, AnswerLabel.frame.origin.y + 10, bgview.frame.size.width - 40, 40)  withStrPlcHolder:@"answer" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:16 withTag:1 withDelegate:self];
    [bgview addSubview:Answer];
    
    btn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, ([self view].frame.size.height/2)-btnheight, bgview.bounds.size.width-(btnmarginleft*2), btnheight) withTitle:[@"next" uppercaseString] withTag:0];
    [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    [btn setEnabled:NO];
    [bgview addSubview:btn];
    
    [[self view] addSubview:bgview];
    
    [Answer becomeFirstResponder];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
//        [self RequestAPIValidateSecurityQuestion];
        [self performSegueWithIdentifier:@"OTPForgotPIN" sender:self];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [bgview setFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-150)];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [bgview setFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-70)];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    if ([textField tag] == 1) {
        if (newLength > 0) {
            [btn setEnabled:YES];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
            [AnswerLabel setHidden:NO];
        } else {
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
            [AnswerLabel setHidden:YES];
        }
    }
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) {
        if(buttonIndex == 1)
        {
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }
}

//-(void)RequestAPIValidateSecurityQuestion {
//    [[self view] endEditing:YES];
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"ValidateSecurityQuestion" withParams:[NSDictionary dictionaryWithObjectsAndKeys:SQCode, @"securityQuestCode", [Answer text], @"answer", nil]];
////        NSLog(@"Validate SQ = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                if ([[[response objectForKey:@"params"] objectForKey:@"isBlock"] isEqualToString:@"true"]) {
//                    [self showAlert:L(@"popUpPinBlockedDesc") title:L(@"popUpPinBlockedTitle") btn:L(@"ok") tag:0 delegate:self];
//                }
//                else {
//                    [self RequestAPIRequestOTPByCust];
//                }
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

//-(void)RequestAPIRequestOTPByCust {
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"RequestOTPByCust" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICETOKEN, @"deviceToken", @"N", @"resendFlag", @"forgotPin", @"view", nil]];
////        NSLog(@"Request OTP = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self performSegueWithIdentifier:@"OTPForgotPIN" sender:self];
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

-(IBAction)prepareForUnwindToSecurityInfo:(UIStoryboardSegue *)segue {
}

@end
