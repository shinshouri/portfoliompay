//
//  ForgotPassword.m
//  MPay
//
//  Created by Admin on 7/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ForgotPassword.h"
#import "Login.h"
#import "OTPForgotPassword.h"

@implementation ForgotPassword
{
    NSString *IsValidateOTP;
    UITextField *UserID;
    UILabel *UserIDLabel;
    UIButton *btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"forgotPassword"];
}

- (void)UI {
    UIView *bgview = [self UIView:self withFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-60)];
    [bgview setBackgroundColor:[UIColor clearColor]];
    [[bgview layer] setCornerRadius:10];
    
    [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, 20, self.view.bounds.size.width-40, 50) withText:[NSString stringWithFormat:@"%@", @"forgotPasswordDesc"] withTextSize:textsize16 withAlignment:0 withLines:0]];
    UserIDLabel = [self UILabel:self withFrame:CGRectMake(20, 100, self.view.bounds.size.width-40, 15) withText:@"emailOrMobileNumber" withTextSize:13 withAlignment:0 withLines:0];
    [UserIDLabel setHidden:YES];
    [bgview addSubview:UserIDLabel];
    UserID = [self CustomTextField:CGRectMake(20, UserIDLabel.frame.origin.y + 10, self.view.frame.size.width - 40, 40) withStrPlcHolder:@"emailOrMobileNumber" withAttrColor:nil keyboardType:UIKeyboardTypeEmailAddress withTextColor:nil withFontSize:16 withTag:0 withDelegate:self];
    [bgview addSubview:UserID];
    
    btn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, (bgview.frame.size.height/2)-40, [self view].bounds.size.width-(btnmarginleft*2), btnheight) withTitle:[@"next" uppercaseString] withTag:0];
    [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    [btn setEnabled:NO];
    [bgview addSubview:btn];
    
    [[self view] addSubview:bgview];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        if([[UserID text] length] > 0){
            if ([[UserID text] length] > 0 && ([self IsValidEmail:[UserID text]] || [[UserID text] rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound))
            {
//                [self RequestAPIValidateForgotPassword];
                [self performSegueWithIdentifier:@"OTPForgotPassword" sender:self];
            }
            else
            {
                [self required:UserID withMsg:@"invalidEmailOrNumber"];
            }
        }else{
            [self required:UserID withMsg:nil];
        }
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    if ([textField tag] == 0) {
        if (newLength > 0) {
            [UserIDLabel setHidden:NO];
            [self removeValidationIcon:UserID withColor:nil];
            [btn setEnabled:YES];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [UserIDLabel setHidden:YES];
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
    }
    
    return newLength <= 40;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) {
        if(buttonIndex == 0)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
            [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [[self navigationController] presentViewController:myVC animated:NO completion:nil];
        }
    }
}

#pragma mark - Segue Delegate
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"OTPForgotPassword"]) {
        OTPForgotPassword *NVC = [segue destinationViewController];
        NVC.ParamInput = [UserID text];
        NVC.FlagValidateOTP = IsValidateOTP;
    }
}

//-(void)RequestAPIValidateForgotPassword {
//    [[self view] endEditing:YES];
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"ValidateForgotPassword" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[UserID text],@"paramInput", nil]];
////        NSLog(@"Validate Customer = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [UserID becomeFirstResponder];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults setObject:@"N" forKey:@"StatusLogin"];
//                IsValidateOTP = [[response objectForKey:@"params"] objectForKey:@"isValidateOTP"];
//                if ([[[response objectForKey:@"params"] objectForKey:@"isValidateOTP"] isEqualToString:@"Y"]) {
//                    [self RequestAPIRequestOTP];
//                } else {
//                    [self showAlert:[NSString stringWithFormat:L(@"checkYourEmailDesc"), [[response objectForKey:@"params"] objectForKey:@"emailAddress"]] title:L(@"checkYourEmail") btn:L(@"ok") tag:1 delegate:self];
//                }
//            }
//            else
//            {
//                [maskView removeFromSuperview];
//                [UserID becomeFirstResponder];
//                if ([[response objectForKey:@"message"] containsString:@"||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                } else {
//                    [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                }
//            }
//        });
//    });
//}

//-(void)RequestAPIRequestOTP {
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"RequestOTP" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICETOKEN, @"deviceToken", @"N", @"haveECash", @"N", @"resendFlag", @"forgotPassword", @"view", nil]];
////        NSLog(@"Request OTP = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self performSegueWithIdentifier:@"OTPForgotPassword" sender:self];
//            }
//            else
//            {
//                [maskView removeFromSuperview];
//                if ([[response objectForKey:@"message"] containsString:@"||"]) {
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
