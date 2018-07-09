//
//  ChangePassword.m
//  MPay
//
//  Created by Admin on 7/27/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ChangePassword.h"
#import "Login.h"

@implementation ChangePassword
{
    NSString *PKey, *PVal, *PExpo;
    UILabel *oldpasslabel, *newpasslabel, *conflabel;
    UITextField *oldpass, *newpass, *conf;
    UIButton *toggleoldpassword, *togglenewpassword, *toggleconf, *btn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"changePassword"];
    [self UI];
}

- (void)UI {
    UIView *bgview = [self UIView:self withFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-70)];
    [[bgview layer] setCornerRadius:10];
    
    oldpasslabel = [self UILabel:self withFrame:CGRectMake(20, [self view].frame.size.height/20, bgview.frame.size.width-40, 10) withText:@"oldPassword" withTextSize:13 withAlignment:0 withLines:0];
    [oldpasslabel setHidden:YES];
    [bgview addSubview:oldpasslabel];
    oldpass = [self PasswordTextField:CGRectMake(20, oldpasslabel.frame.origin.y, bgview.frame.size.width - 60, 40) withStrPlcHolder:@"oldPassword" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:16 withTag:0 withDelegate:self];
    [bgview addSubview:oldpass];
    toggleoldpassword = [self btnPasswordImage:CGRectMake(oldpass.frame.origin.x + oldpass.frame.size.width, oldpass.frame.origin.y+5, 20, 20) withTag:0];
    [bgview addSubview:toggleoldpassword];
    UIView *garisold = [self UIView:self withFrame:CGRectMake(toggleoldpassword.frame.origin.x, toggleoldpassword.frame.origin.y+25, toggleoldpassword.frame.size.width, 1)];
    [garisold setBackgroundColor:[self colorFromHexString:@"#9B9B9B" withAlpha:0.2]];
    [bgview addSubview:garisold];
    
    newpasslabel = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*3, bgview.frame.size.width-40, 10) withText:@"newPassword" withTextSize:13 withAlignment:0 withLines:0];
    [newpasslabel setHidden:YES];
    [bgview addSubview:newpasslabel];
    newpass = [self PasswordTextField:CGRectMake(20, newpasslabel.frame.origin.y, bgview.frame.size.width - 60, 40) withStrPlcHolder:@"newPassword" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:16 withTag:1 withDelegate:self];
    [bgview addSubview:newpass];
    togglenewpassword = [self btnPasswordImage:CGRectMake(newpass.frame.origin.x + newpass.frame.size.width, newpass.frame.origin.y+5, 20, 20) withTag:1];
    [bgview addSubview:togglenewpassword];
    UIView *garispass = [self UIView:self withFrame:CGRectMake(togglenewpassword.frame.origin.x, togglenewpassword.frame.origin.y+25, togglenewpassword.frame.size.width, 1)];
    [garispass setBackgroundColor:[self colorFromHexString:@"#9B9B9B" withAlpha:0.2]];
    [bgview addSubview:garispass];
    
    conflabel = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*5, bgview.frame.size.width-40, 10) withText:@"confirmNewPassword" withTextSize:13 withAlignment:0 withLines:0];
    [conflabel setHidden:YES];
    [bgview addSubview:conflabel];
    conf = [self PasswordTextField:CGRectMake(20, conflabel.frame.origin.y, bgview.frame.size.width - 60, 40) withStrPlcHolder:@"confirmNewPassword" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:16 withTag:2 withDelegate:self];
    [bgview addSubview:conf];
    toggleconf = [self btnPasswordImage:CGRectMake(conf.frame.origin.x + conf.frame.size.width, conf.frame.origin.y+5, 20, 20) withTag:2];
    [bgview addSubview:toggleconf];
    UIView *garisconf = [self UIView:self withFrame:CGRectMake(toggleconf.frame.origin.x, toggleconf.frame.origin.y+25, toggleconf.frame.size.width, 1)];
    [garisconf setBackgroundColor:[self colorFromHexString:@"#9B9B9B" withAlpha:0.2]];
    [bgview addSubview:garisconf];
    
    btn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, ([self view].frame.size.height/2)-50, bgview.frame.size.width-(btnmarginleft*2), btnheight) withTitle:[@"save" uppercaseString] withTag:3];
    [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    [btn setEnabled:NO];
    [bgview addSubview:btn];
    
    [[self view] addSubview:bgview];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        if ([oldpass isSecureTextEntry]) {
            oldpass.secureTextEntry = NO;
            oldpass.font = nil;
            oldpass.font = [UIFont systemFontOfSize:16];
            [toggleoldpassword setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passclosed.png"]] forState:UIControlStateNormal];
        }
        else
        {
            oldpass.secureTextEntry = YES;
            oldpass.font = nil;
            oldpass.font = [UIFont systemFontOfSize:16];
            [toggleoldpassword setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passopen.png"]] forState:UIControlStateNormal];
        }
    }
    else if([sender tag] == 1)
    {
        if ([newpass isSecureTextEntry]) {
            newpass.secureTextEntry = NO;
            newpass.font = nil;
            newpass.font = [UIFont systemFontOfSize:16];
            [togglenewpassword setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passclosed.png"]] forState:UIControlStateNormal];
        }
        else
        {
            newpass.secureTextEntry = YES;
            newpass.font = nil;
            newpass.font = [UIFont systemFontOfSize:16];
            [togglenewpassword setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passopen.png"]] forState:UIControlStateNormal];
        }
    }
    else if([sender tag] == 2)
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
    else if([sender tag] == 3)
    {
        if ([[oldpass text] length] > 0 && [[newpass text] length] > 0 && [[conf text] length] > 0) {
            if (![[oldpass text] isEqualToString:[newpass text]]) {
                if ([[newpass text] isEqualToString:[conf text]]) {
//                    [self RequestAPIValidatePassword];
                    [[self navigationController] popViewControllerAnimated:YES];
                } else {
                    [self showAlert:@"newPassAndConfEqual" title:@"warning" btn:@"ok" tag:0 delegate:self];
                }
            } else {
                [self showAlert:@"oldPassAndNewPassDiff" title:@"warning" btn:@"ok" tag:0 delegate:self];
            }
        } else {
            if([[oldpass text] length] == 0){
                [self requiredPassword:oldpass withMsg:nil];
            }
            
            if([[newpass text] length] == 0){
                [self requiredPassword:newpass withMsg:nil];
            }
            
            if([[conf text] length] == 0){
                [self requiredPassword:conf withMsg:nil];
            }
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
    
    NSCharacterSet* numberCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    for (int i = 0; i < [string length]; ++i)
    {
        unichar c = [string characterAtIndex:i];
        if ([numberCharSet characterIsMember:c])
        {
            return NO;
        }
    }
    
    if([textField tag] == 0){
        if (newLength < [[oldpass text] length] && [textField isSecureTextEntry]) {
            [oldpass setText:@""];
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        } else
        if (newLength > 0 && [[newpass text] length] > 0 && [[conf text] length] > 0) {
            [btn setEnabled:YES];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        
        if(newLength > 0){
            [self removeValidationIconPassword:oldpass withColor:nil];
            [oldpasslabel setHidden:NO];
        } else {
            [oldpasslabel setHidden:YES];
        }
    }else if([textField tag] == 1){
        if (newLength < [[newpass text] length] && [textField isSecureTextEntry]) {
            [newpass setText:@""];
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        } else
        if ([[oldpass text] length] > 0 && newLength > 0 && [[conf text] length] > 0) {
            [btn setEnabled:YES];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        
        if(newLength > 0){
            [self removeValidationIconPassword:newpass withColor:nil];
            [newpasslabel setHidden:NO];
        } else {
            [newpasslabel setHidden:YES];
        }
    }else if([textField tag] == 2){
        if (newLength < [[conf text] length] && [textField isSecureTextEntry]) {
            [conf setText:@""];
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        } else
        if ([[oldpass text] length] > 0 && [[newpass text] length] > 0 && newLength > 0) {
            [btn setEnabled:YES];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        
        if(newLength > 0){
            [self removeValidationIconPassword:conf withColor:nil];
            [conflabel setHidden:NO];
        } else {
            [conflabel setHidden:YES];
        }
    }
    
    return YES;
}

//-(void)RequestAPIValidatePassword {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"ValidatePassword" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[newpass text], @"password", nil]];
////        NSLog(@"Validate Password = %@", response);
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
//                [self RequestAPIChangePassword];
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

//-(void)RequestAPIChangePassword {
//    [[self view] endEditing:YES];
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"ChangePassword" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[self encryptHSM:[oldpass text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"oldPassword", [self encryptHSM:[newpass text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"newPassword", [self encryptHSM:[conf text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"confirmNewPassword", nil]];
////        NSLog(@"ChangePass = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [[self navigationController] popViewControllerAnimated:YES];
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

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
}

@end
