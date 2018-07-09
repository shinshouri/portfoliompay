//
//  PushPassword.m
//  MPay
//
//  Copyright © 2016 Admin. All rights reserved.
//

#import "PushPassword.h"
#import "Login.h"
#import "Wallet.h"
#import "PaymentDetail.h"
#import "DetailTransaction.h"

@implementation PushPassword
{
    NSString *PKey, *PVal, *PExpo;
    UILabel *passLabel;
    UITextField *Password;
    UIButton *togglepass;
}
@synthesize data, PInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[self QsCFtGbHyUJSdaWE] isEqualToString:@"X1UaSDpOwQe0nf4"]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UpdateModules" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateModules:) name:@"UpdateModules" object:nil];
        
        [bgimage setBackgroundColor:[self colorFromHexString:@"#FAFAFA" withAlpha:1.0]];
        if ([defaults objectForKey:@"PersonalInfo"]) {
            PInfo = [defaults objectForKey:@"PersonalInfo"];
            [self UI];
        } else {
//            [self RequestAPIGetPersonalInformation];
            [self UI];
        }
        [defaults setObject:@"Password" forKey:@"Background"];
    } else {
        [self showAlert:@"rootMsg" title:@"rootTitle" btn:@"ok" tag:0 delegate:self];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [Password becomeFirstResponder];
    [bgimage setImage:[UIImage imageNamed:@"bgwhite.png"]];
}

-(void)UpdateModules:(NSNotification*)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"%@", [notification object]);
        if ([[[notification object] objectForKey:@"totalSyncModules"] intValue] != [[[notification object] objectForKey:@"totalModules"] intValue] && [[[notification object] objectForKey:@"totalModules"] intValue] > 0) {
            [[self view] addSubview:[self showProgressbar]];
        }
        
        progressView.progress = (float)[[[notification object] objectForKey:@"totalSyncModules"] intValue]/[[[notification object] objectForKey:@"totalModules"] intValue];
        
        if ([[[notification object] objectForKey:@"totalSyncModules"] intValue] == [[[notification object] objectForKey:@"totalModules"] intValue]) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UpdateModules" object:nil];
            //            [maskProgressView removeFromSuperview];
        }
    });
}

- (void)UI {
    UIImageView *img = [self UIImage:self withFrame:CGRectMake(([self view].frame.size.width/2)-(([self view].frame.size.width/5)/2), [self view].frame.size.height/7, [self view].frame.size.width/5, [self view].frame.size.width/5) withImageName:@""];
    [[img layer] setCornerRadius:([self view].frame.size.width/5)/2];
    [img setClipsToBounds:YES];
    [img setContentMode:UIViewContentModeScaleAspectFill];
    [[img layer] setBorderWidth:2.0f];
    [[img layer] setBorderColor:[UIColor whiteColor].CGColor];
    NSURL *url = [NSURL URLWithString:[PInfo objectForKey:@"imageProfile"]];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    if (imageData) {
        [img setImage:[UIImage imageWithData:imageData]];
    } else {
        [img setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"default.png"]]];
    }
    [[self view] addSubview:img];
    [[self view] addSubview:[self UILabel:self withFrame:CGRectMake(20, img.frame.origin.y+([self view].frame.size.height/6.5), [self view].frame.size.width-40, 20) withText:[PInfo objectForKey:@"customerName"] withTextSize:14 withAlignment:1 withLines:0]];
    [[self view] addSubview:[self UILabel:self withFrame:CGRectMake(20, img.frame.origin.y+20+([self view].frame.size.height/6.5), [self view].frame.size.width-40, 20) withText:[PInfo objectForKey:@"customerEmailAddress"] withTextSize:14 withAlignment:1 withLines:0]];
    
    passLabel = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/2)-65, self.view.bounds.size.width-40, 10) withText:@"password" withTextSize:13 withAlignment:0 withLines:0];
    [passLabel setTextColor:[self colorFromHexString:@"9B9B9B" withAlpha:0.5]];
    [passLabel setHidden:YES];
    [[self view] addSubview:passLabel];
    Password = [self PasswordTextField:CGRectMake(20, ([self view].frame.size.height/2)-60, [self view].frame.size.width-60, 40) withStrPlcHolder:@"password" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:16 withTag:0 withDelegate:self];
    [[self view] addSubview:Password];
    togglepass = [self btnPasswordImage:CGRectMake(Password.frame.origin.x + Password.frame.size.width, Password.frame.origin.y+5, 20, 20) withTag:0];
    [[self view] addSubview:togglepass];
    UIView *garispass = [self UIView:self withFrame:CGRectMake(togglepass.frame.origin.x, togglepass.frame.origin.y+25, togglepass.frame.size.width, 1)];
    [garispass setBackgroundColor:[self colorFromHexString:Color5 withAlpha:0.2]];
    [[self view] addSubview:garispass];
    
    UIButton *forgotpassword = [self UIButton:self withFrame:CGRectMake(self.view.frame.size.width-150, ([self view].frame.size.height/2)-10, 150, 20) withTitle:[NSString stringWithFormat:@"%@", @"forgotPassword"] withTag:1];
    [forgotpassword setTitleColor:[self colorFromHexString:Color6 withAlpha:1.0] forState:UIControlStateNormal];
    [[forgotpassword titleLabel] setFont:[UIFont systemFontOfSize:14]];
    [[self view] addSubview:forgotpassword];

    UIButton *login = [self UIButton:self withFrame:CGRectMake(btnmarginleft, ([self view].frame.size.height/2)+50, [self view].frame.size.width-(btnmarginleft*2), btnheight) withTitle:[@"login" uppercaseString] withTag:2];
    [login setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
    [[self view] addSubview:login];
    
    [Password becomeFirstResponder];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        if ([Password isSecureTextEntry]) {
            Password.secureTextEntry = NO;
            Password.font = nil;
            Password.font = [UIFont systemFontOfSize:16];
            [togglepass setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passclosed.png"]] forState:UIControlStateNormal];
        }
        else
        {
            Password.secureTextEntry = YES;
            Password.font = nil;
            Password.font = [UIFont systemFontOfSize:16];
            [togglepass setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passopen.png"]] forState:UIControlStateNormal];
        }
    }
    else if([sender tag] == 1)
    {
        [self performSegueWithIdentifier:@"ForgotPassword" sender:self];
    }
    else if([sender tag] == 2)
    {
        if ([[Password text] length] > 0) {
//            [self RequestAPIGetPublicKeyUser];
        } else {
            [self requiredPassword:Password withMsg:nil];
        }
    }
}

#pragma mark - Segue Delegate
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Receipt"]) {
        DetailTransaction *NVC = [segue destinationViewController];
        NVC.Response = data;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField tag] == 0) {
        // Prevent crashing undo bug – see note below.
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet* numberCharSet = [NSCharacterSet alphanumericCharacterSet];
        
        for (int i = 0; i < [string length]; ++i)
        {
            unichar c = [string characterAtIndex:i];
            if ([string isEqualToString:@" "]) {
                
            } else if (![numberCharSet characterIsMember:c])
            {
                return NO;
            }
        }
        
        if ([textField tag] == 0) {
            if (newLength > 0) {
                [self removeValidationIconPassword:Password withColor:Color5];
                [passLabel setHidden:NO];
            } else {
                [passLabel setHidden:YES];
            }
        }
        return YES;
    }
    return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) {
        if(buttonIndex == 0)
        {
            if ([[defaults objectForKey:@"StatusLogin"] isEqualToString:@"Y"]) {
//                [self RequestAPIGetPersonalInformation];
            }
        }
    }
}

//-(void)RequestAPIGetPersonalInformation {
//    [[self view] addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetPersonalInformation" withParams:nil];
////        NSLog(@"Personal Info = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [maskProgressView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"tryAgain") tag:1 delegate:self];
//            }
//            else if([response objectForKey:@"DownloadModules"]) {
//                [maskView removeFromSuperview];
//                [maskProgressView removeFromSuperview];
//                [self RequestAPIGetPersonalInformation];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [maskProgressView removeFromSuperview];
//                [defaults setObject:[response objectForKey:@"params"] forKey:@"PersonalInfo"];
//                PInfo = [response objectForKey:@"params"];
//                [self UI];
//            }
//            else if([[response objectForKey:@"logout"] intValue] == 1)
//            {
//                [defaults removeObjectForKey:@"Background"];
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
//                [maskProgressView removeFromSuperview];
//                [self UI];
//                if ([[response objectForKey:@"message"] containsString:@"||||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:1 delegate:self];
//                } else if ([[response objectForKey:@"message"] containsString:@"||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:1 delegate:self];
//                } else {
//                    [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"tryAgain") tag:1 delegate:self];
//                }
//
//            }
//        });
//    });
//}

//-(void)RequestAPIGetPublicKeyUser {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetPublicKeyUser" withParams:[NSDictionary dictionaryWithObjectsAndKeys:@"safenet", @"typePublicKey", nil]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                PKey = [[response objectForKey:@"params"] objectForKey:@"randomNumber"];
//                PVal = [[response objectForKey:@"params"] objectForKey:@"modulusVal"];
//                PExpo = [[response objectForKey:@"params"] objectForKey:@"exponentVal"];
//                [self RequestAPIAuthenticationPassword];
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

//-(void)RequestAPIAuthenticationPassword {
//    [[self view] addSubview:[self showmask]];
//    [[self view] endEditing:YES];
//    NSString *lat = [NSString stringWithFormat:@"%@", [[[PCUtils execute:@"GetCurrentLocation" withParams:nil] objectForKey:@"params"] objectForKey:@"latitude"]];
//    NSString *lon = [NSString stringWithFormat:@"%@", [[[PCUtils execute:@"GetCurrentLocation" withParams:nil] objectForKey:@"params"] objectForKey:@"longitude"]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"AuthenticationPassword" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICETOKEN, @"deviceToken", [self encryptHSM:[Password text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"password", lat, @"latitude", lon, @"longitude", nil]];
////        NSLog(@"AuthPassword = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [Password becomeFirstResponder];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UpdateModules" object:nil];
//                [maskView removeFromSuperview];
//                if ([[[response objectForKey:@"params"] objectForKey:@"userStatus"] isEqualToString:@"3"]) {
//                    [defaults removeObjectForKey:@"Background"];
//                    [defaults setObject:@"3" forKey:@"UserStatus"];
//                    [self RequestAPILogout];
//                } else if ([[[response objectForKey:@"params"] objectForKey:@"userStatus"] isEqualToString:@"5"]) {
//                    [defaults removeObjectForKey:@"Background"];
//                    [defaults setObject:@"5" forKey:@"UserStatus"];
//                    [self RequestAPILogout];
//                } else {
//                    if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"PushNotif"]) {
//                        [defaults removeObjectForKey:@"Background"];
//                        [defaults removeObjectForKey:@"ViewController"];
//                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                        PaymentDetail *myVC = (PaymentDetail *)[storyboard instantiateViewControllerWithIdentifier:@"PaymentID"];
//                        [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                        [[self topViewController] presentViewController:myVC animated:NO completion:nil];
//                    }
//                    else if([[defaults objectForKey:@"ViewController"] isEqualToString:@"Terminated"]) {
//                        [defaults removeObjectForKey:@"Background"];
//                        [defaults removeObjectForKey:@"ViewController"];
//                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                        Wallet *myVC = (Wallet *)[storyboard instantiateViewControllerWithIdentifier:@"RootHome"];
//                        [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                        [[self topViewController] presentViewController:myVC animated:NO completion:nil];
//                    }
//                    else if([[defaults objectForKey:@"ViewController"] isEqualToString:@"PushNoLogin"]) {
//                        [defaults removeObjectForKey:@"Background"];
//                        [defaults removeObjectForKey:@"ViewController"];
//                        [[self view] endEditing:YES];
//                        [self dismissViewControllerAnimated:YES completion:nil];
//                    }
//                    else if ([[defaults objectForKey:@"FromPush"] isEqualToString:@"Cancel"]) {
//                        [defaults removeObjectForKey:@"Background"];
//                        [defaults removeObjectForKey:@"FromPush"];
//                        [defaults removeObjectForKey:@"ViewController"];
//                        [[self view] endEditing:YES];
//                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                        Wallet *myVC = (Wallet *)[storyboard instantiateViewControllerWithIdentifier:@"RootHome"];
//                        [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                        [[self topViewController] presentViewController:myVC animated:NO completion:nil];
//                    }
//                    else if ([[defaults objectForKey:@"Background"] isEqualToString:@"Password"]) {
//                        [defaults removeObjectForKey:@"Background"];
//                        [[self view] endEditing:YES];
//                        [self dismissViewControllerAnimated:YES completion:nil];
//                    }
//                }
//            }
//            else if([[response objectForKey:@"logout"] intValue] == 1)
//            {
//                [defaults removeObjectForKey:@"Background"];
//                [self showAlert:L(@"systemRestart") title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                [defaults setObject:@"N" forKey:@"StatusLogin"];
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
//                [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                [[self topViewController] presentViewController:myVC animated:NO completion:nil];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 0)
//            {
//                [maskView removeFromSuperview];
//                [Password becomeFirstResponder];
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
//
//        });
//    });
//}

//-(void)RequestAPILogout {
//    [[self view] addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"Logout" withParams:nil];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults setObject:@"N" forKey:@"StatusLogin"];
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
//                [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                [[self topViewController] presentViewController:myVC animated:NO completion:nil];
//            }
//            else if([[response objectForKey:@"logout"] intValue] == 1)
//            {
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
