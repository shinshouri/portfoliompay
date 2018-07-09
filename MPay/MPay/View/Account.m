//
//  Account.m
//  MPay
//
//  Created by Admin on 7/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "Account.h"
#import "UBirthday.h"

@implementation Account
{
    NSString *PVal, *PExpo, *PKey;
    UILabel *emailLabel, *passLabel, *confLabel;
    UITextField *email, *pass, *conf;
    UIButton *togglepass, *toggleconf, *btn;
    UIScrollView *bgview;
    UIImageView *backimg;
}
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
    [backimg removeFromSuperview];
    backimg = [self UIImage:self withFrame:[self view].frame.size.height > 568 ? backposition : backposition1 withImageName:@"back.png"];
    [[self view] addSubview:backimg];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithImage:[UIImage new] style:UIBarButtonItemStylePlain target:self action:@selector(BackBtn)];
    self.navigationItem.leftBarButtonItem=newBackButton;
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"accountInformation"];
}

-(void)BackBtn {
    [self performSegueWithIdentifier:@"UnwindToRegister" sender:self];
}

- (void)UI {
    bgview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-60)];
    [bgview setBackgroundColor:[UIColor clearColor]];
    bgview.contentSize = CGSizeMake(self.view.frame.size.width, 400);
    bgview.showsVerticalScrollIndicator = NO;
    [[bgview layer] setCornerRadius:10];
    
    [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, [self view].frame.size.height/20, bgview.bounds.size.width-40, 40) withText:@"accountInformationDesc" withTextSize:textsize16 withAlignment:0 withLines:0]];
    
    emailLabel = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*3.5, bgview.bounds.size.width-40, 10) withText:@"email" withTextSize:textsize12 withAlignment:0 withLines:0];
    [emailLabel setTextColor:[self colorFromHexString:@"#9B9B9B" withAlpha:1.0]];
    [emailLabel setHidden:YES];
    [bgview addSubview:emailLabel];
    email = [self CustomTextField:CGRectMake(20, emailLabel.frame.origin.y + 5, bgview.frame.size.width - 40, 40) withStrPlcHolder:@"email" withAttrColor:nil keyboardType:UIKeyboardTypeEmailAddress withTextColor:nil withFontSize:18 withTag:0 withDelegate:self];
    [bgview addSubview:email];
    
    passLabel = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*5.5, bgview.bounds.size.width-40, 10) withText:@"password" withTextSize:textsize12 withAlignment:0 withLines:0];
    [passLabel setTextColor:[self colorFromHexString:@"#9B9B9B" withAlpha:1.0]];
    [passLabel setHidden:YES];
    [bgview addSubview:passLabel];
    pass = [self PasswordTextField:CGRectMake(20, passLabel.frame.origin.y + 5, bgview.frame.size.width - 60, 40) withStrPlcHolder:@"password" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:18 withTag:1 withDelegate:self];
    togglepass = [self btnPasswordImage:CGRectMake(pass.frame.origin.x + pass.frame.size.width, pass.frame.origin.y+5, 20, 20) withTag:0];
    [bgview addSubview:pass];
    [bgview addSubview:togglepass];
    UIView *garis = [self UIView:self withFrame:CGRectMake(togglepass.frame.origin.x, togglepass.frame.origin.y+25, togglepass.frame.size.width, 1)];
    [garis setBackgroundColor:[self colorFromHexString:@"#9B9B9B" withAlpha:0.2]];
    [bgview addSubview:garis];
    
    confLabel = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*7.5, bgview.bounds.size.width-40, 10) withText:@"confirmPassword" withTextSize:13 withAlignment:0 withLines:0];
    [confLabel setTextColor:[self colorFromHexString:@"#9B9B9B" withAlpha:1.0]];
    [confLabel setHidden:YES];
    [bgview addSubview:confLabel];
    conf = [self PasswordTextField:CGRectMake(20, confLabel.frame.origin.y + 5, bgview.frame.size.width - 60, 40) withStrPlcHolder:@"confirmPassword" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:18 withTag:2 withDelegate:self];
    [bgview addSubview:conf];
    toggleconf = [self btnPasswordImage:CGRectMake(conf.frame.origin.x + conf.frame.size.width, conf.frame.origin.y+5, 20, 20) withTag:1];
    [bgview addSubview:toggleconf];
    UIView *garisconf = [self UIView:self withFrame:CGRectMake(toggleconf.frame.origin.x, toggleconf.frame.origin.y+25, toggleconf.frame.size.width, 1)];
    [garisconf setBackgroundColor:[self colorFromHexString:@"#9B9B9B" withAlpha:0.2]];
    [bgview addSubview:garisconf];
    
    btn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, ([self view].frame.size.height/20)*10, bgview.bounds.size.width-(btnmarginleft*2), btnheight) withTitle:[@"next" uppercaseString] withTag:2];
    [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    [btn setEnabled:NO];
    [bgview addSubview:btn];
    
    [[self view] addSubview:bgview];
    
    [email becomeFirstResponder];
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
        if ([[email text] length] > 0 && ([self IsValidEmail:[email text]]) && [[pass text] length] > 0 && [[conf text] length] > 0) {
            if ([[pass text] isEqualToString:[conf text]]) {
//                [self RequestAPIValidateEmailCustomer];
                [self performSegueWithIdentifier:@"UBirthday" sender:self];
            }
            else {
                [self showAlert:@"errorInvalidConfirmPassword" title:@"errorInvalidConfirmPasswordTitle" btn:@"ok" tag:0 delegate:self];
            }
        }
        else if([[email text] length] > 0 && ![self IsValidEmail:[email text]]){
            [self removeValidationIcon:email withColor:nil];
            [self required:email withMsg:@"errorInvalidEmail"];
        } else
        {
            if([[email text] length] == 0){
                [self required:email withMsg:nil];
            }
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"UBirthday"]) {
        UBirthday *NVC = [segue destinationViewController];
        NVC.data = data;
        NVC.PInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:[email text], @"Email", [self encryptHSM:[pass text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"Password", nil];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.view addGestureRecognizer:tapRecognizer];
    [bgview setFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-230)];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.view removeGestureRecognizer:tapRecognizer];
    [bgview setFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    
    if ([textField tag] == 0) {
        if(![self IsValidEmail:[email text]]){
            [self required:email withMsg:@"errorInvalidEmail"];
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
        if (newLength > 0 && [[pass text] length] > 0 && [[conf text] length] > 0) {
            [btn setEnabled:YES];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        
        if (newLength > 0) {
            [self removeValidationIcon:email withColor:nil];
            [emailLabel setHidden:NO];
        } else {
            [emailLabel setHidden:YES];
        }
    } else if ([textField tag] == 1) {
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
        
        if (newLength < [[pass text] length] && [textField isSecureTextEntry]) {
            [pass setText:@""];
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        } else
        if (newLength > 0 && [[email text] length] > 0 && [[conf text] length] > 0) {
            [btn setEnabled:YES];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        
        if (newLength > 0) {
            [self removeValidationIconPassword:pass withColor:nil];
            [passLabel setHidden:NO];
        } else {
            [passLabel setHidden:YES];
        }
        return YES;
    } else if ([textField tag] == 2) {
        NSCharacterSet* numberCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
        for (int i = 0; i < [string length]; ++i)
        {
            unichar c = [string characterAtIndex:i];
            if ([string isEqualToString:@" "]) {
                
            } else if ([numberCharSet characterIsMember:c])
            {
                return NO;
            }
        }
        
        if (newLength < [[conf text] length] && [textField isSecureTextEntry]) {
            [conf setText:@""];
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        } else
        if (newLength > 0 && [[pass text] length] > 0 && [[email text] length] > 0) {
            [btn setEnabled:YES];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [btn setEnabled:NO];
            [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        
        if (newLength > 0) {
            [self removeValidationIconPassword:conf withColor:nil];
            [confLabel setHidden:NO];
        } else {
            [confLabel setHidden:YES];
        }
        return YES;
    }
    
    
    return YES;
}

//-(void)RequestAPIValidateEmailCustomer {
//    [[self view] endEditing:YES];
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"ValidateEmailCustomer" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[email text], @"emailAddress", nil]];
////        NSLog(@"Validate Email = %@", response);
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
//        [self RequestData:self withAction:@"GetPublicKey" withParams:[NSDictionary dictionaryWithObjectsAndKeys:@"safenet", @"typePublicKey", nil]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                PKey = [defaults objectForKey:@"MobileNumber"];
//                PVal = [[response objectForKey:@"params"] objectForKey:@"modulusVal"];
//                PExpo = [[response objectForKey:@"params"] objectForKey:@"exponentVal"];
//                [self RequestAPIValidatePassword];
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
//        [self RequestData:self withAction:@"ValidatePassword" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[pass text], @"password", [PCFingerPrint checkTouchIdSupport] ? @"Y": @"N", @"isTouchID", nil]];
////        NSLog(@"Validate Password = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self performSegueWithIdentifier:@"UBirthday" sender:self];
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
