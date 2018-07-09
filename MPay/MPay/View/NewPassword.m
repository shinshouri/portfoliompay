//
//  NewPassword.m
//  MPay
//
//  Copyright © 2016 Admin. All rights reserved.
//

#import "NewPassword.h"
#import "Login.h"

@interface NewPassword ()

@end

@implementation NewPassword
{
    NSString *PKey, *PVal, *PExpo;
    UILabel *emailLabel, *passLabel, *confLabel;
    UITextField *pass, *conf;
    UIButton *togglepass, *toggleconf, *btn;
    NSDictionary *data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [defaults removeObjectForKey:@"Background"];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(NewBack)];
    [newBackButton setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"Close.png"]]];
    self.navigationItem.leftBarButtonItem=newBackButton;
    
    NSString *OJS = [NSString stringWithFormat:@"%@", [[defaults dictionaryForKey:@"UserInfo"] objectForKey:@"params"]];
    NSData *ODT = [OJS dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *usr = [NSJSONSerialization JSONObjectWithData:ODT options:NSJSONReadingMutableLeaves error:nil];
    data = [usr mutableCopy];
    [self UI];
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"newPassword"];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)UI {
    UIView *bgview = [self UIView:self withFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-60)];
    [bgview setBackgroundColor:[UIColor clearColor]];
    [[bgview layer] setCornerRadius:10];
    
    [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, 20, bgview.bounds.size.width-40, 40) withText:@"newPasswordDesc" withTextSize:textsize16 withAlignment:0 withLines:0]];
    
    passLabel = [self UILabel:self withFrame:CGRectMake(20, 65, bgview.bounds.size.width-40, 10) withText:@"newPassword" withTextSize:13 withAlignment:0 withLines:0];
    [passLabel setHidden:YES];
    [bgview addSubview:passLabel];
    
    pass = [self PasswordTextField:CGRectMake(20, passLabel.frame.origin.y + 5, bgview.frame.size.width - 60, 40) withStrPlcHolder:@"newPassword" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:16 withTag:1 withDelegate:self];
    togglepass = [self btnPasswordImage:CGRectMake(pass.frame.origin.x + pass.frame.size.width, pass.frame.origin.y+5, 20, 20) withTag:0];
    [bgview addSubview:pass];
    [bgview addSubview:togglepass];
    UIView *garis = [self UIView:self withFrame:CGRectMake(togglepass.frame.origin.x, togglepass.frame.origin.y+25, togglepass.frame.size.width, 1)];
    [garis setBackgroundColor:[self colorFromHexString:@"#9B9B9B" withAlpha:0.2]];
    [bgview addSubview:garis];
    
    confLabel = [self UILabel:self withFrame:CGRectMake(20, 125, bgview.bounds.size.width-40, 10) withText:@"confirmNewPassword" withTextSize:13 withAlignment:0 withLines:0];
    [confLabel setHidden:YES];
    [bgview addSubview:confLabel];
    
    conf = [self PasswordTextField:CGRectMake(20, confLabel.frame.origin.y + 5, bgview.frame.size.width - 60, 40) withStrPlcHolder:@"confirmNewPassword" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:16 withTag:2 withDelegate:self];
    [bgview addSubview:conf];
    toggleconf = [self btnPasswordImage:CGRectMake(conf.frame.origin.x + conf.frame.size.width, conf.frame.origin.y+5, 20, 20) withTag:1];
    [bgview addSubview:toggleconf];
    UIView *garisconf = [self UIView:self withFrame:CGRectMake(toggleconf.frame.origin.x, toggleconf.frame.origin.y+25, toggleconf.frame.size.width, 1)];
    [garisconf setBackgroundColor:[self colorFromHexString:@"#9B9B9B" withAlpha:0.2]];
    [bgview addSubview:garisconf];
    
    btn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, ([self view].frame.size.height/2)-50, bgview.bounds.size.width-(btnmarginleft*2), btnheight) withTitle:[@"changePassword" uppercaseString] withTag:2];
    [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    [btn setEnabled:NO];
    [bgview addSubview:btn];
    
    [[self view] addSubview:bgview];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        if ([pass isSecureTextEntry]) {
            pass.secureTextEntry = NO;
            pass.font = nil;
            pass.font = [UIFont systemFontOfSize:16];
            [togglepass setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passclosed.png"]] forState:UIControlStateNormal];
        }
        else
        {
            pass.secureTextEntry = YES;
            pass.font = nil;
            pass.font = [UIFont systemFontOfSize:16];
            [togglepass setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passopen.png"]] forState:UIControlStateNormal];
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
        if([[pass text] length] > 0 && [[conf text] length] > 0){
            if ([[pass text] isEqualToString:[conf text]]) {
//                [self RequestAPIValidatePassword];
                [defaults setObject:@"YES" forKey:@"FirstIn"];
                [self performSegueWithIdentifier:@"ResetPassword" sender:self];
            }
            else {
                [self showAlert:@"passwordNotEqual" title:@"warning" btn:@"ok" tag:0 delegate:self];
            }
        }else{
            if([[pass text] length] == 0){
                [self requiredPassword:pass withMsg:nil];
            }
            
            if([[conf text] length] == 0){
                [self requiredPassword:conf withMsg:nil];
            }
        }
        
    }
}

-(void)NewBack {
    [self performSegueWithIdentifier:@"ResetPassword" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ResetPassword"]) {
        
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    NSCharacterSet* numberCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    for (int i = 0; i < [string length]; ++i)
    {
        unichar c = [string characterAtIndex:i];
        if ([numberCharSet characterIsMember:c])
        {
            return NO;
        }
    }
    
    if ([textField tag] == 1) {
        if (newLength < [[pass text] length] && [textField isSecureTextEntry]) {
            [pass setText:@""];
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        } else
        if (newLength > 0 && [[conf text] length] > 0) {
            [btn setEnabled:YES];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        if (newLength > 0) {
            [passLabel setHidden:NO];
            [self removeValidationIconPassword:pass withColor:nil];
        } else {
            [passLabel setHidden:YES];
        }
        return YES;
    } else if ([textField tag] == 2) {
        if (newLength < [[conf text] length] && [textField isSecureTextEntry]) {
            [conf setText:@""];
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        } else
        if (newLength > 0 && [[pass text] length] > 0) {
            [btn setEnabled:YES];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        if (newLength > 0) {
            [confLabel setHidden:NO];
            [self removeValidationIconPassword:conf withColor:nil];
        } else {
            [confLabel setHidden:YES];
        }
        return YES;
    }
    
    return YES;
}

//-(void)RequestAPILogout {
//    [[self navigationController].view addSubview:[self showmask]];
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

//-(void)RequestAPIValidatePassword {
//    [[self view] endEditing:YES];
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"ValidatePassword" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[pass text], @"password", nil]];
////        NSLog(@"Validate Password = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self RequestAPIGetPublicKey];
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

//-(void)RequestAPIGetPublicKey {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetPublicKey" withParams:[NSDictionary dictionaryWithObjectsAndKeys:@"safenet", @"typePublicKey", [data objectForKey:@"paramInput"], @"userId", nil]];
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
//                [self RequestAPIResetPassword];
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

//-(void)RequestAPIResetPassword {
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"ResetPassword" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICETOKEN, @"deviceToken", [self encryptHSM:[pass text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"newPassword", [data objectForKey:@"paramInput"], @"paramInput", nil]];
////        NSLog(@"Reset Password = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults setObject:@"YES" forKey:@"FirstIn"];
//                [self performSegueWithIdentifier:@"ResetPassword" sender:self];
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
