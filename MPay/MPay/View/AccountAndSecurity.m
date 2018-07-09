//
//  AccountAndSecurity.m
//  MPay
//
//  Created by Admin on 7/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AccountAndSecurity.h"
#import "ChangeEmail.h"
#import "Login.h"
#import "LinkFingerprint.h"
#import "CustomPIN.h"

@implementation AccountAndSecurity
{
    UISwitch *switcher;
    UILabel *email;
    NSString *em;
}
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
}

-(void)viewWillAppear:(BOOL)animated {
//    [[self navigationItem] setTitle:L(@"accountAndSecurity")];
    if ([[defaults objectForKey:@"Fingerprint"] isEqualToString:@"N"]) {
        [switcher setOn:NO];
    } else {
        [switcher setOn:YES];
    }
//    [self RequestAPIEmail];
}

- (void)UI {
    UILabel *lbl = [self UILabel:self withFrame:CGRectMake(10, 70, [self view].frame.size.width-20, 30) withText:@"setPaymentApproval" withTextSize:textsize16 withAlignment:0 withLines:0];
    [lbl setFont:[UIFont boldSystemFontOfSize:textsize24]];
    [[self view] addSubview:lbl];
    
    UIView *view = [self UIView:self withFrame:CGRectMake(0, 110, [self view].frame.size.width, [self view].frame.size.height-110)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    UIView *line = [self UIView:self withFrame:CGRectMake(0, 10, [self view].frame.size.width, 1)];
    [line setBackgroundColor:[self colorFromHexString:@"#E7E7E7" withAlpha:1.0]];
    [view addSubview:line];
    
    int f = [self view].frame.size.height/25;
    [view addSubview:[self UILabel:self withFrame:CGRectMake(10, f, view.frame.size.width-20, 20) withText:@"email" withTextSize:textsize16 withAlignment:0 withLines:0]];
    email = [self UILabelwithBlackText:self withFrame:CGRectMake(10, f*2, view.frame.size.width-60, 20) withText:[data objectForKey:@"customerEmailAddress"] withTextSize:textsize16 withAlignment:0 withLines:0];
    email.textColor = [self colorFromHexString:@"#555555" withAlpha:1.0];
    [view addSubview:email];
    [view addSubview:[self UIButton:self withFrame:CGRectMake(10, f, view.frame.size.width-65, 40) withTitle:@"" withTag:1]];
    UIButton *btn = [self UIButton:self withFrame:CGRectMake(view.frame.size.width-60, f*2, 60, 20) withTitle:@"resend" withTag:0];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [[btn titleLabel] setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:btn];
    UIView *LN1 = [self UIView:self withFrame:CGRectMake(10, f*3.5, view.frame.size.width-20, 1)];
    [LN1 setBackgroundColor:[self colorFromHexString:@"#E7E7E7" withAlpha:1.0]];
    [view addSubview:LN1];
    
    [view addSubview:[self UILabel:self withFrame:CGRectMake(10, f*4, view.frame.size.width-20, 20) withText:@"changePassword" withTextSize:textsize16 withAlignment:0 withLines:0]];
    NSString *bulletpas = [NSString stringWithUTF8String:"\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022"];
    UILabel *Pas = [self UILabelwithBlackText:self withFrame:CGRectMake(10, f*5, view.frame.size.width-20, 20) withText:bulletpas withTextSize:36 withAlignment:0 withLines:0];
    [view addSubview:Pas];
    [view addSubview:[self UIButton:self withFrame:CGRectMake(10, f*4, view.frame.size.width-20, 40) withTitle:@"" withTag:2]];
    UIView *LN2 = [self UIView:self withFrame:CGRectMake(10, f*6.5, view.frame.size.width-20, 1)];
    [LN2 setBackgroundColor:[self colorFromHexString:@"#E7E7E7" withAlpha:1.0]];
    [view addSubview:LN2];
    
    [view addSubview:[self UILabel:self withFrame:CGRectMake(10, f*7, view.frame.size.width-20, 20) withText:@"changePin" withTextSize:textsize16 withAlignment:0 withLines:0]];
    NSString *bulletpin = [NSString stringWithUTF8String:"\u2022\u2022\u2022\u2022\u2022\u2022"];
    UILabel *Pin = [self UILabelwithBlackText:self withFrame:CGRectMake(10, f*8, view.frame.size.width-20, 20) withText:bulletpin withTextSize:36 withAlignment:0 withLines:0];
    [view addSubview:Pin];
    [view addSubview:[self UIButton:self withFrame:CGRectMake(10, f*7, view.frame.size.width-20, 40) withTitle:@"" withTag:3]];
    UIView *LN3 = [self UIView:self withFrame:CGRectMake(10, f*9.5, view.frame.size.width-20, 1)];
    [LN3 setBackgroundColor:[self colorFromHexString:@"#E7E7E7" withAlpha:1.0]];
    [view addSubview:LN3];
    
//    if ([PCFingerPrint checkTouchIdSupport]) {
        [view addSubview:[self UILabel:self withFrame:CGRectMake(10, f*10, view.frame.size.width-20, 20) withText:@"approvalPayment" withTextSize:textsize16 withAlignment:0 withLines:0]];
        UILabel *FPrint = [self UILabelwithBlackText:self withFrame:CGRectMake(10, f*11, view.frame.size.width-60, 20) withText:@"fingerprint" withTextSize:textsize16 withAlignment:0 withLines:0];
        [FPrint setTextColor:[self colorFromHexString:@"#555555" withAlpha:1.0]];
        [view addSubview:FPrint];
        [view addSubview:[self UIButton:self withFrame:CGRectMake(10, f*10, view.frame.size.width-20, 40) withTitle:@"" withTag:88]];
        switcher = [self UISwitch:self withFrame:CGRectMake(view.frame.size.width-60, f*10, 40, 20)];
        if ([[defaults objectForKey:@"Fingerprint"] isEqualToString:@"Y"]) {
            [switcher setOn:YES];
        }
        else
        {
            [switcher setOn:NO];
        }
        [view addSubview:switcher];
//    }
    [[self view] addSubview:view];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        //Resend Code
        [self showAlert2:@"popUpResendEmailDesc" title:@"message" btn1:@"cancel" btn2:@"send" tag:2 delegate:self];
    }
    else
    if([sender tag] == 1)
    {
        //Change Email
        [defaults setObject:@"ChangeEmail" forKey:@"ViewController"];
        [self performSegueWithIdentifier:@"ChangeEmail" sender:self];
    }
    else
    if([sender tag] == 2)
    {
        //Change Password
        [self performSegueWithIdentifier:@"ChangePass" sender:self];
    }
    else
    if([sender tag] == 3)
    {
        //Change PIN
//        [self RequestAPIValidatePIN];
        [self performSegueWithIdentifier:@"ChangePIN" sender:self];
    }
    else
    if([sender tag] == 88)
    {
        if ([switcher isOn]) {
//            [self RequestAPIUnlinkFingerprint];
        }
        else {
//            if ([PCFingerPrint checkTouchIdSupport]) {
                GlobalVariable *GV = [GlobalVariable sharedInstance];
                GV.Email = [data objectForKey:@"customerEmailAddress"];
                [defaults setObject:@"AccAndSec" forKey:@"ViewController"];
                [self performSegueWithIdentifier:@"LinkFingerprint" sender:self];
//            }
        }
    }
    else
    if([sender tag] == 99)
    {
        if ([switcher isOn]) {
//            if ([PCFingerPrint checkTouchIdSupport]) {
                GlobalVariable *GV = [GlobalVariable sharedInstance];
                GV.Email = [data objectForKey:@"customerEmailAddress"];
                [defaults setObject:@"AccAndSec" forKey:@"ViewController"];
                [self performSegueWithIdentifier:@"LinkFingerprint" sender:self];
//            }
        }
        else {
//            [self RequestAPIUnlinkFingerprint];
        }
    }
}

#pragma mark - Segue Delegate
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ChangeEmail"]) {
        CustomPIN *NVC = [segue destinationViewController];
        NVC.data = data;
    } else if ([[segue identifier] isEqualToString:@"LinkFingerprint"]) {
        LinkFingerprint *NVC = [segue destinationViewController];
        NVC.data = data;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 2) {
        if(buttonIndex == 1)
        {
//            [self RequestAPIGetEmail];
        }
    }
}

//-(void)RequestAPIUnlinkFingerprint {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"UnlinkFingerprint" withParams:nil];
////        NSLog(@"Unlink Fingerprint = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [switcher setOn:YES];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [switcher setOn:NO];
//                [defaults setObject:@"N" forKey:@"Fingerprint"];
//                [defaults setObject:@"ChangeFingerprint" forKey:@"Change"];
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
//                [switcher setOn:YES];
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

//-(void)RequestAPIValidatePIN {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"ValidatePIN" withParams:nil];
////        NSLog(@"Validate PIN = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                if ([[[response objectForKey:@"params"] objectForKey:@"status"] isEqualToString:@"active"]) {
//                    [self performSegueWithIdentifier:@"ChangePIN" sender:self];
//                } else if ([[[response objectForKey:@"params"] objectForKey:@"status"] isEqualToString:@"locked"]) {
//                    [self showAlert:L(@"pinIsLockedDesc") title:L(@"pinIsLockedTitle") btn:L(@"ok") tag:0 delegate:self];
//                } else if ([[[response objectForKey:@"params"] objectForKey:@"status"] isEqualToString:@"reset"]) {
//                    [defaults setObject:@"Reset" forKey:@"ValidatePIN"];
//                    [self performSegueWithIdentifier:@"ChangePIN" sender:self];
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
//                    [self showAlert2:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn1:L(@"tryAgain") btn2:L(@"forgotPIN") tag:1 delegate:self];
//                } else {
//                    [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                }
//            }
//        });
//    });
//}

//-(void)RequestAPIEmail {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetEmail" withParams:nil];
////        NSLog(@"GetEmail = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [email setText:[[response objectForKey:@"params"] objectForKey:@"email"]];
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

//-(void)RequestAPIGetEmail {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetEmail" withParams:nil];
////        NSLog(@"GetEmail = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                em = [[response objectForKey:@"params"] objectForKey:@"email"];
//                [self RequestAPIChangeEmail];
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

//-(void)RequestAPIChangeEmail {
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"ChangeEmail" withParams:[NSDictionary dictionaryWithObjectsAndKeys: em , @"newEmailAddress", nil]];
////        NSLog(@"ChangeEmail = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults setObject:@"ChangeEmail" forKey:@"Change"];
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

-(IBAction)prepareForUnwindToAccAndSec:(UIStoryboardSegue *)segue {
}

@end
