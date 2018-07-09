//
//  SetNewPIN.m
//  MPay
//
//  Copyright © 2016 Admin. All rights reserved.
//

#import "SetNewPIN.h"
#import "Login.h"

@implementation SetNewPIN
{
    NSString *PKey, *PVal, *PExpo;
    UITextField *NewPIN, *conf;
    UILabel *NewPINLabel, *confLabel;
    UIButton *toggle, *toggleconf, *btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(BackBtn)];
    [newBackButton setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"back.png"]]];
    self.navigationItem.leftBarButtonItem=newBackButton;
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"setNewPIN"];
}

-(void)BackBtn {
    [self performSegueWithIdentifier:@"UnwindToSecurityInfo" sender:self];
}

- (void)UI {
    UIView *bgview = [self UIView:self withFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-60)];
    [[bgview layer] setCornerRadius:10];
    
    NewPINLabel = [self UILabel:self withFrame:CGRectMake(20, [self view].frame.size.height/20, bgview.bounds.size.width-40, 10) withText:@"pin" withTextSize:textsize12 withAlignment:0 withLines:0];
    [NewPINLabel setHidden:YES];
    [bgview addSubview:NewPINLabel];

    NewPIN = [self PasswordTextField:CGRectMake(20, NewPINLabel.frame.origin.y + 5, bgview.frame.size.width-60, 40) withStrPlcHolder:@"pin" withAttrColor:nil keyboardType:UIKeyboardTypeNumberPad withTextColor:nil withFontSize:16 withTag:0 withDelegate:self];
    [bgview addSubview:NewPIN];
    toggle = [self btnPasswordImage:CGRectMake(NewPIN.frame.origin.x + NewPIN.frame.size.width, NewPINLabel.frame.origin.y + 10, 20, 20) withTag:0];
    [bgview addSubview:toggle];
    UIView *garis = [self UIView:self withFrame:CGRectMake(toggle.frame.origin.x, toggle.frame.origin.y+25, toggle.frame.size.width, 1)];
    [garis setBackgroundColor:[self colorFromHexString:@"#9B9B9B" withAlpha:0.2]];
    [bgview addSubview:garis];
    
    confLabel = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*3, bgview.bounds.size.width-40, 10) withText:@"confirmPin" withTextSize:textsize12 withAlignment:0 withLines:0];
    [confLabel setHidden:YES];
    [bgview addSubview:confLabel];
    
    conf = [self PasswordTextField:CGRectMake(20, confLabel.frame.origin.y + 5, bgview.frame.size.width-60, 40) withStrPlcHolder:@"confirmPin" withAttrColor:nil keyboardType:UIKeyboardTypeNumberPad withTextColor:nil withFontSize:16 withTag:1 withDelegate:self];
    [bgview addSubview:conf];
    toggleconf = [self btnPasswordImage:CGRectMake(conf.frame.origin.x + conf.frame.size.width, confLabel.frame.origin.y + 10, 20, 20) withTag:1];
    [bgview addSubview:toggleconf];
    UIView *garisconf = [self UIView:self withFrame:CGRectMake(toggleconf.frame.origin.x, toggleconf.frame.origin.y+25, toggleconf.frame.size.width, 1)];
    [garisconf setBackgroundColor:[self colorFromHexString:@"#9B9B9B" withAlpha:0.2]];
    [bgview addSubview:garisconf];
    
    btn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, ([self view].frame.size.height/2)-50, bgview.bounds.size.width-(btnmarginleft*2), btnheight) withTitle:[@"save" uppercaseString] withTag:2];
    [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    [btn setEnabled:NO];
    [bgview addSubview:btn];
    
    [[self view] addSubview:bgview];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        if ([NewPIN isSecureTextEntry]) {
            NewPIN.secureTextEntry = NO;
            NewPIN.font = nil;
            NewPIN.font = [UIFont systemFontOfSize:16];
            [toggle setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passclosed.png"]] forState:UIControlStateNormal];
        }
        else
        {
            NewPIN.secureTextEntry = YES;
            NewPIN.font = nil;
            NewPIN.font = [UIFont systemFontOfSize:16];
            [toggle setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passopen.png"]] forState:UIControlStateNormal];
        }
    }
    else if([sender tag] == 1)
    {
        if ([conf isSecureTextEntry]) {
            conf.secureTextEntry = NO;
            conf.font = nil;
            conf.font = [UIFont systemFontOfSize:16];
            [toggleconf setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passclosed.png"]] forState:UIControlStateNormal];
        }
        else
        {
            conf.secureTextEntry = YES;
            conf.font = nil;
            conf.font = [UIFont systemFontOfSize:16];
            [toggleconf setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passopen.png"]] forState:UIControlStateNormal];
        }
    }
    else if([sender tag] == 2)
    {
        if ([[NewPIN text] length] > 0 && [[conf text] length] > 0) {
            if ([[NewPIN text] isEqualToString:[conf text]]) {
//                [self RequestAPIValidatePINBackOffice];
                [self performSegueWithIdentifier:@"UnwindToPIN" sender:self];
            } else {
                NSString *msg = @"errorInvalidConfirmPin";
                if ([msg containsString:@"||"]) {
                    NSArray* foo = [msg componentsSeparatedByString: @"||"];
                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:@"ok" tag:0 delegate:self];
                } else {
                    [self showAlert:@"errorInvalidConfirmPin" title:@"errorInvalidConfirmPinTitle" btn:@"ok" tag:0 delegate:self];
                }
            }
        } else {
            [self showAlert:@"pleaseInputPIN" title:@"pleaseInputPINTitle" btn:@"ok" tag:0 delegate:self];
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
    
    NSCharacterSet* numberCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    for (int i = 0; i < [string length]; ++i)
    {
        unichar c = [string characterAtIndex:i];
        if (![numberCharSet characterIsMember:c])
        {
            return NO;
        }
    }
    
    if ([textField tag] == 0) {
        if (newLength >= 6 && [[conf text] length] >= 6) {
            [btn setEnabled:YES];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        if (newLength > 0) {
            [NewPINLabel setHidden:NO];
        } else {
            [NewPINLabel setHidden:YES];
        }
    } else
    if ([textField tag] == 1) {
        if (newLength >= 6 && [[NewPIN text] length] >= 6) {
            [btn setEnabled:YES];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        if (newLength > 0) {
            [confLabel setHidden:NO];
        } else {
            [confLabel setHidden:YES];
        }
    }
    
    return newLength <= 6;
}

//-(void)RequestAPIValidatePINBackOffice {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"ValidatePINBackOffice" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[NewPIN text], @"pin", nil]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self RequestAPIGetPublicKeyUser];
//            }
//            else
//            {
//                [maskView removeFromSuperview];
//                if ([[response objectForKey:@"message"] containsString:@"err.validatepin.maxsequential"]) {
//                    [self showAlert:L(@"popUpValidatePinSequentialDesc") title:L(@"popUpValidatePinSequentialTitle") btn:L(@"ok") tag:0 delegate:self];
//                } else if ([[response objectForKey:@"message"] containsString:@"err.validatepin.maxrepetitive"]) {
//                    [self showAlert:L(@"popUpValidatePinRepetitiveDesc") title:L(@"popUpValidatePinRepetitiveTitle") btn:L(@"ok") tag:0 delegate:self];
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
//                [self RequestAPISaveNewPin];
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

//-(void)RequestAPISaveNewPin {
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"SaveNewPin" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[self encryptHSM:[NewPIN text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"pin", nil]];
////        NSLog(@"New PIN = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self performSegueWithIdentifier:@"UnwindToPIN" sender:self];
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

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
}

@end
