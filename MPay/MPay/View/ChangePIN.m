//
//  ChangePIN.m
//  MPay
//
//  Created by Admin on 7/27/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ChangePIN.h"
#import "Login.h"

@implementation ChangePIN
{
    NSString *PKey, *PVal, *PExpo;
    UILabel *oldpinlabel, *newpinlabel, *conflabel;
    UITextField *oldpin, *newpin, *conf;
    UIButton *toggleoldpin, *togglenewpin, *toggleconf, *btn;
    UIScrollView *bgview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"changePin"];
    [self UI];
}

-(void)viewDidDisappear:(BOOL)animated {
    [defaults removeObjectForKey:@"ValidatePIN"];
}

- (void)UI {
    bgview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-70)];
    [bgview setBackgroundColor:[UIColor clearColor]];
    bgview.contentSize = CGSizeMake(0, 500);
    bgview.showsVerticalScrollIndicator = NO;
    bgview.delegate = self;
    [[bgview layer] setCornerRadius:10];
    
    if (![defaults objectForKey:@"ValidatePIN"]) {
        oldpinlabel = [self UILabel:self withFrame:CGRectMake(20, [self view].frame.size.height/20, bgview.frame.size.width-40, 10) withText:@"oldPin" withTextSize:13 withAlignment:0 withLines:0];
        [oldpinlabel setHidden:YES];
        [bgview addSubview:oldpinlabel];
        oldpin = [self PasswordTextField:CGRectMake(20, oldpinlabel.frame.origin.y + 5, bgview.frame.size.width - 60, 40) withStrPlcHolder:@"oldPin" withAttrColor:nil keyboardType:UIKeyboardTypeNumberPad withTextColor:nil withFontSize:16 withTag:0 withDelegate:self];
        [bgview addSubview:oldpin];
        toggleoldpin = [self btnPasswordImage:CGRectMake(oldpin.frame.origin.x + oldpin.frame.size.width, oldpin.frame.origin.y+5, 20, 20) withTag:0];
        [bgview addSubview:toggleoldpin];
        UIView *garisold = [self UIView:self withFrame:CGRectMake(toggleoldpin.frame.origin.x, toggleoldpin.frame.origin.y+25, toggleoldpin.frame.size.width, 1)];
        [garisold setBackgroundColor:[self colorFromHexString:@"#9B9B9B" withAlpha:0.2]];
        [bgview addSubview:garisold];
    }
    
    newpinlabel = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*3, bgview.frame.size.width-40, 10) withText:@"newPin" withTextSize:13 withAlignment:0 withLines:0];
    [newpinlabel setHidden:YES];
    [bgview addSubview:newpinlabel];
    newpin = [self PasswordTextField:CGRectMake(20, newpinlabel.frame.origin.y, bgview.frame.size.width - 60, 40) withStrPlcHolder:@"newPin" withAttrColor:nil keyboardType:UIKeyboardTypeNumberPad withTextColor:nil withFontSize:16 withTag:1 withDelegate:self];
    [bgview addSubview:newpin];
    togglenewpin = [self btnPasswordImage:CGRectMake(newpin.frame.origin.x + newpin.frame.size.width, newpin.frame.origin.y+5, 20, 20) withTag:1];
    [bgview addSubview:togglenewpin];
    UIView *garispin = [self UIView:self withFrame:CGRectMake(togglenewpin.frame.origin.x, togglenewpin.frame.origin.y+25, togglenewpin.frame.size.width, 1)];
    [garispin setBackgroundColor:[self colorFromHexString:@"#9B9B9B" withAlpha:0.2]];
    [bgview addSubview:garispin];
    
    conflabel = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*5, bgview.frame.size.width-40, 10) withText:@"confirmNewPin" withTextSize:13 withAlignment:0 withLines:0];
    [conflabel setHidden:YES];
    [bgview addSubview:conflabel];
    conf = [self PasswordTextField:CGRectMake(20, conflabel.frame.origin.y, bgview.frame.size.width - 60, 40) withStrPlcHolder:@"confirmNewPin" withAttrColor:nil keyboardType:UIKeyboardTypeNumberPad withTextColor:nil withFontSize:16 withTag:2 withDelegate:self];
    [bgview addSubview:conf];
    toggleconf = [self btnPasswordImage:CGRectMake(conf.frame.origin.x + conf.frame.size.width, conf.frame.origin.y+5, 20, 20) withTag:2];
    [bgview addSubview:toggleconf];
    UIView *garisconf = [self UIView:self withFrame:CGRectMake(toggleconf.frame.origin.x, toggleconf.frame.origin.y+25, toggleconf.frame.size.width, 1)];
    [garisconf setBackgroundColor:[self colorFromHexString:@"#9B9B9B" withAlpha:0.2]];
    [bgview addSubview:garisconf];
    
    btn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, ([self view].frame.size.height/2)-50, bgview.bounds.size.width-(btnmarginleft*2), btnheight) withTitle:[@"save" uppercaseString] withTag:3];
    [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    [btn setEnabled:NO];
    [bgview addSubview:btn];
    
    [[self view] addSubview:bgview];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        if ([oldpin isSecureTextEntry]) {
            oldpin.secureTextEntry = NO;
            oldpin.font = nil;
            oldpin.font = [UIFont systemFontOfSize:16];
            [toggleoldpin setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passclosed.png"]] forState:UIControlStateNormal];
        }
        else
        {
            oldpin.secureTextEntry = YES;
            oldpin.font = nil;
            oldpin.font = [UIFont systemFontOfSize:16];
            [toggleoldpin setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passopen.png"]] forState:UIControlStateNormal];
        }
    }
    else if([sender tag] == 1)
    {
        if ([newpin isSecureTextEntry]) {
            newpin.secureTextEntry = NO;
            newpin.font = nil;
            newpin.font = [UIFont systemFontOfSize:16];
            [togglenewpin setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passclosed.png"]] forState:UIControlStateNormal];
        }
        else
        {
            newpin.secureTextEntry = YES;
            newpin.font = nil;
            newpin.font = [UIFont systemFontOfSize:16];
            [togglenewpin setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passopen.png"]] forState:UIControlStateNormal];
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
        if (![defaults objectForKey:@"ValidatePIN"]) {
            if ([[oldpin text] length] == 6) {
                if (![[oldpin text] isEqualToString:[newpin text]]) {
                    if ([[newpin text] isEqualToString:[conf text]]) {
//                        [self RequestAPIValidatePINBackOffice];
                        [defaults removeObjectForKey:@"ValidatePIN"];
                        [[self navigationController] popViewControllerAnimated:YES];
                    } else {
                        [self showAlert:@"newPINAndConfPINEqual" title:@"warning" btn:@"ok" tag:0 delegate:self];
                    }
                } else {
                    [self showAlert:@"oldPINAndNewPINDiff" title:@"warning" btn:@"ok" tag:0 delegate:self];
                }
            }
        } else
        if ([[newpin text] length] == 6 && [[conf text] length] == 6) {
            if ([[newpin text] isEqualToString:[conf text]]) {
//                [self RequestAPIValidatePINBackOffice];
                [defaults removeObjectForKey:@"ValidatePIN"];
                [[self navigationController] popViewControllerAnimated:YES];
            } else {
                [self showAlert:@"newPINAndConfPINEqual" title:@"warning" btn:@"ok" tag:0 delegate:self];
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
    
    NSCharacterSet* numberCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    for (int i = 0; i < [string length]; ++i)
    {
        unichar c = [string characterAtIndex:i];
        if (![numberCharSet characterIsMember:c])
        {
            return NO;
        }
    }
    
    if([textField tag] == 0){
        if (![defaults objectForKey:@"ValidatePIN"]) {
            if (newLength >= 6 && [[newpin text] length] >= 6 && [[conf text] length] >= 6) {
                [btn setEnabled:YES];
                [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
            } else {
                [btn setEnabled:NO];
                [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
            }
        }
        
        if(newLength > 0){
            [self removeValidationIconPassword:oldpin withColor:nil];
            [oldpinlabel setHidden:NO];
        } else {
            [oldpinlabel setHidden:YES];
        }
    }else if([textField tag] == 1){
        if (![defaults objectForKey:@"ValidatePIN"] ? [[oldpin text] length] >= 6 && newLength >= 6 && [[conf text] length] >= 6 : newLength >= 6 && [[conf text] length] >= 6) {
            [btn setEnabled:YES];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        
        if(newLength > 0){
            [self removeValidationIconPassword:newpin withColor:nil];
            [newpinlabel setHidden:NO];
        } else {
            [newpinlabel setHidden:YES];
        }
    }else if([textField tag] == 2){
        if (![defaults objectForKey:@"ValidatePIN"] ? [[oldpin text] length] >= 6 && newLength >= 6 && [[newpin text] length] >= 6 : newLength >= 6 && [[newpin text] length] >= 6) {
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
    
    return newLength <= 6;
}

//-(void)RequestAPIValidatePINBackOffice {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"ValidatePINBackOffice" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[newpin text], @"pin", nil]];
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
//                [self RequestAPIChangePIN];
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

//-(void)RequestAPIChangePIN {
//    [[self view] endEditing:YES];
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        if (![defaults objectForKey:@"ValidatePIN"]) {
//            [self RequestData:self withAction:@"ChangePIN" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[self encryptHSM:[oldpin text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"oldPIN", [self encryptHSM:[newpin text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"newPIN", [self encryptHSM:[conf text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"confirmNewPIN", nil]];
//        }
//        else {
//            [self RequestData:self withAction:@"ChangePIN" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[self encryptHSM:[newpin text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"newPIN", [self encryptHSM:[conf text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"confirmNewPIN", nil]];
//        }
////        NSLog(@"ChangePIN = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults removeObjectForKey:@"ValidatePIN"];
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
