//
//  Verification.m
//  MPay
//
//  Created by Admin on 7/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "Verification.h"
#import "Account.h"

@implementation Verification
{
    UIView *bgview, *garis1, *garis2, *garis3, *garis4, *garis5, *garis6;
    UITextField *res;
    UITextField *textFields;
    UILabel *expTime;
    UIButton *sendBtn;
    UIView *newView;
}
@synthesize data, FlagECash, ECash;

- (void)viewDidLoad {
    [super viewDidLoad];
    secondsLeft = 180;
    [self UI];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GetTimer" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ToDo:) name:@"GetTimer" object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"verification"];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runTime:) userInfo:nil repeats:YES];
    [res becomeFirstResponder];
}

-(void)viewDidDisappear:(BOOL)animated {
    [timer invalidate];
}

-(void)ToDo:(id)sender {
//    NSLog(@"%i", [[defaults objectForKey:@"TimeEnterBackground"] intValue]);
    secondsLeft = secondsLeft - [[defaults objectForKey:@"TimeEnterBackground"] intValue];
}

- (void)UI {
    [bgview removeFromSuperview];
    bgview = [self UIView:self withFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-60)];
    [[bgview layer] setCornerRadius:10];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, [self view].frame.size.height/20, self.view.frame.size.width - 40, 60)];
    [label setText:@"verificationDesc"];
    [label setTextColor:[self colorFromHexString:@"#6E6E6E" withAlpha:1.0]];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setNumberOfLines:3];
    [label setTag:100000000];
    
    res = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, self.view.frame.size.width, 40)];
    [res setKeyboardType:UIKeyboardTypeNumberPad];
    [res setHidden:TRUE];
    [res setDelegate:self];
    [res setTag:2000000000];
    [[self view] addSubview:res];
    
    [bgview addSubview:label];
    [bgview addSubview:res];
    
    for (int i=0; i<6; i++) {
        textFields = [self dot:CGRectMake(((([self view].frame.size.width) - (([self view].frame.size.width/6.5) * 5))/2) + (([self view].frame.size.width/7.5) * i), label.frame.origin.y + label.frame.size.height + [self view].frame.size.height/20, 35, [self view].frame.size.height/20) withTag:i];
        [bgview addSubview:textFields];
        if (i == 0) {
            garis1 = [self UIView:self withFrame:CGRectMake(textFields.frame.origin.x, textFields.frame.origin.y+[self view].frame.size.height/20, textFields.frame.size.width, 1)];
            [garis1 setBackgroundColor:[self colorFromHexString:@"#81DCEC" withAlpha:1.0]];
            [bgview addSubview:garis1];
        } else if (i == 1) {
            garis2 = [self UIView:self withFrame:CGRectMake(textFields.frame.origin.x, textFields.frame.origin.y+[self view].frame.size.height/20, textFields.frame.size.width, 1)];
            [garis2 setBackgroundColor:[self colorFromHexString:@"#E6E6E6" withAlpha:1.0]];
            [bgview addSubview:garis2];
        } else if (i == 2) {
            garis3 = [self UIView:self withFrame:CGRectMake(textFields.frame.origin.x, textFields.frame.origin.y+[self view].frame.size.height/20, textFields.frame.size.width, 1)];
            [garis3 setBackgroundColor:[self colorFromHexString:@"#E6E6E6" withAlpha:1.0]];
            [bgview addSubview:garis3];
        } else if (i == 3) {
            garis4 = [self UIView:self withFrame:CGRectMake(textFields.frame.origin.x, textFields.frame.origin.y+[self view].frame.size.height/20, textFields.frame.size.width, 1)];
            [garis4 setBackgroundColor:[self colorFromHexString:@"#E6E6E6" withAlpha:1.0]];
            [bgview addSubview:garis4];
        } else if (i == 4) {
            garis5 = [self UIView:self withFrame:CGRectMake(textFields.frame.origin.x, textFields.frame.origin.y+[self view].frame.size.height/20, textFields.frame.size.width, 1)];
            [garis5 setBackgroundColor:[self colorFromHexString:@"#E6E6E6" withAlpha:1.0]];
            [bgview addSubview:garis5];
        } else if (i == 5) {
            garis6 = [self UIView:self withFrame:CGRectMake(textFields.frame.origin.x, textFields.frame.origin.y+[self view].frame.size.height/20, textFields.frame.size.width, 1)];
            [garis6 setBackgroundColor:[self colorFromHexString:@"#E6E6E6" withAlpha:1.0]];
            [bgview addSubview:garis6];
        }
    }
    
    UIButton *showKeyboard = [[UIButton alloc] initWithFrame:CGRectMake(0, label.frame.origin.y + label.frame.size.height + 10, self.view.frame.size.width, 50)];
    [showKeyboard setBackgroundColor:[UIColor clearColor]];
    [showKeyboard setTag:0];
    [showKeyboard addTarget:self action:@selector(openKeyboard:) forControlEvents:UIControlEventTouchUpInside];\
    [bgview addSubview:showKeyboard];
    
    expTime = [[UILabel alloc] initWithFrame:CGRectMake(20, textFields.frame.origin.y + textFields.frame.size.height + 10, self.view.frame.size.width - 40, 15)];
    [expTime setTextAlignment:NSTextAlignmentCenter];
    [expTime setText:[NSString stringWithFormat:@"%@ --:--", @"codeExpiresIn"]];
    [expTime setFont:[UIFont systemFontOfSize:12]];
    [expTime setTextColor:[self colorFromHexString:Color8 withAlpha:1.0]];
    [bgview addSubview:expTime];
    
    sendBtn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, ([self view].frame.size.height/2)-50, self.view.frame.size.width-(btnmarginleft*2), btnheight) withTitle:@"send" withTag:0];
    [sendBtn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    [sendBtn setEnabled:NO];
    [bgview addSubview:sendBtn];
    
    UIButton *resendBtn = [self UIButton:self withFrame:CGRectMake(20, sendBtn.frame.size.height + sendBtn.frame.origin.y, self.view.frame.size.width - 40, 50) withTitle:@"resendVerificationCode" withTag:1];
    [resendBtn setTitleColor:[self colorFromHexString:Color3 withAlpha:1.0] forState:UIControlStateNormal];
    [[resendBtn titleLabel] setFont:[UIFont systemFontOfSize:14]];
    [bgview addSubview:resendBtn];
    
    [[self view] addSubview:bgview];
}

- (void) openKeyboard:(id)sender{
    [res becomeFirstResponder];
}

- (UITextField *)dot:(CGRect)frame withTag:(int)tag{
    UITextField *newField = [[UITextField alloc] initWithFrame:frame];
    [newField setBackgroundColor:[UIColor clearColor]];
    [newField setTag:tag];
    [newField setTextAlignment:NSTextAlignmentCenter];
    [newField setKeyboardType:UIKeyboardTypeNumberPad];
    [newField setFont:[UIFont systemFontOfSize:24]];
    [newField setTintColor:[UIColor clearColor]];
    [newField setTextColor:[self colorFromHexString:@"#6E6E6E" withAlpha:1.0]];
    [newField setDelegate:self];
    [newField setEnabled:FALSE];
    
    CGFloat flHeight = newField.frame.size.height;
    CGFloat flWidth = newField.frame.size.width;
    
    newView = [[UIView alloc] initWithFrame:CGRectMake(0, flHeight, flWidth, 1.5)];
    [newView setBackgroundColor:[self colorFromHexString:@"#E6E6E6" withAlpha:1.0]];
    [newView setTag:tag];
    
    return newField;
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        if ([[res text] length] == 6) {
            if (secondsLeft <= 0) {
                [self showAlert:@"codeExpired" title:@"expiredVerificationCode" btn:@"ok" tag:0 delegate:self];
            } else {
//                [self RequestAPIValidateOTP];
                [self performSegueWithIdentifier:@"Account" sender:self];
            }
        } else {
            [self showAlert:@"pleasePINDigit" title:@"resendVerificationCode" btn:@"ok" tag:0 delegate:self];
        }
    }
    else
    if([sender tag] == 1)
    {
//        [self RequestAPIRequestOTP];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Account"]) {
        Account *NVC = [segue destinationViewController];
        NVC.data = data;
    }
}

#pragma mark - Alertview Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) {
        if(buttonIndex == 0)
        {
            
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.view addGestureRecognizer:tapRecognizer];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.view removeGestureRecognizer:tapRecognizer];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    if(newLength > 0){
        if (range.length==1 && string.length==0){
            for (id aSubview in bgview.subviews){
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == (newLength))) {
                    [[aSubview viewWithTag:[aSubview tag]] setText:string];
                }
                
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == (newLength + 1))) {
                    [[aSubview viewWithTag:[aSubview tag]] setText:string];
                }
                
            }
        }else{
            for (id aSubview in bgview.subviews){
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == (newLength - 1))) {
                    [[aSubview viewWithTag:[aSubview tag]] setText:string];
                }
                
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == newLength)) {
                }
            }
        }
    }else{
        if (range.length==1 && string.length==0){
            for (id aSubview in bgview.subviews){
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == (newLength))) {
                    [[aSubview viewWithTag:[aSubview tag]] setText:string];
//                    [self CustomLine:aSubview withColor:@"#81DCEC"];
                }
                
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == (newLength + 1))) {
                    [[aSubview viewWithTag:[aSubview tag]] setText:string];
//                    [self CustomLine:aSubview withColor:@"#E6E6E6"];
                }
            }
        }
    }
    
    if(newLength == 0){
        [garis1 setBackgroundColor:[self colorFromHexString:@"#81DCEC" withAlpha:1.0]];
    } else {
        [garis1 setBackgroundColor:[self colorFromHexString:@"#E6E6E6" withAlpha:1.0]];
    }
    if(newLength == 1){
        [garis2 setBackgroundColor:[self colorFromHexString:@"#81DCEC" withAlpha:1.0]];
    } else {
        [garis2 setBackgroundColor:[self colorFromHexString:@"#E6E6E6" withAlpha:1.0]];
    }
    if(newLength == 2){
        [garis3 setBackgroundColor:[self colorFromHexString:@"#81DCEC" withAlpha:1.0]];
    } else {
        [garis3 setBackgroundColor:[self colorFromHexString:@"#E6E6E6" withAlpha:1.0]];
    }
    if(newLength == 3){
        [garis4 setBackgroundColor:[self colorFromHexString:@"#81DCEC" withAlpha:1.0]];
    } else {
        [garis4 setBackgroundColor:[self colorFromHexString:@"#E6E6E6" withAlpha:1.0]];
    }
    if(newLength == 4){
        [garis5 setBackgroundColor:[self colorFromHexString:@"#81DCEC" withAlpha:1.0]];
    } else {
        [garis5 setBackgroundColor:[self colorFromHexString:@"#E6E6E6" withAlpha:1.0]];
    }
    if(newLength == 5){
        [garis6 setBackgroundColor:[self colorFromHexString:@"#81DCEC" withAlpha:1.0]];
    } else {
        [garis6 setBackgroundColor:[self colorFromHexString:@"#E6E6E6" withAlpha:1.0]];
    }
    
    if (newLength >= 6) {
        [sendBtn setEnabled:YES];
        [sendBtn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
    } else {
        [sendBtn setEnabled:NO];
        [sendBtn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    }
    
    return newLength <= 6;
}

-(void)runTime:(NSTimer *)runningTimer {
    int minutes, seconds;
    secondsLeft--;
    //    hours = secondsLeft / 3600;
    minutes = (secondsLeft % 3600) / 60;
    seconds = (secondsLeft %3600) % 60;
    expTime.text =[NSString stringWithFormat:@"%@ %02d:%02d", @"codeExpiresIn", minutes, seconds];
    if (secondsLeft <= 0) {
        [timer invalidate];
        expTime.text =[NSString stringWithFormat:@"%@ 00:00", @"codeExpiresIn"];
//        [self showAlert:L(@"codeExpired") title:L(@"expiredVerificationCode") btn:L(@"ok") tag:0 delegate:self];
    }
}

- (void) CustomLine:(id)sender withColor:(NSString *)color{
    if([[[sender subviews] objectAtIndex:0] tag] == [sender tag]){
        UIColor *attrColor = [self colorFromHexString:color withAlpha:1.0];
        
        
        CGFloat flHeight = [sender frame].size.height;
        CGFloat flWidth = [sender frame].size.width;
        
        newView = [[UIView alloc] initWithFrame:CGRectMake(0, flHeight, flWidth, 1.5)];
        [newView setBackgroundColor:attrColor];
        [newView setTag:[sender tag]];
        
        [[[[sender subviews] objectAtIndex:0] viewWithTag:[sender tag]]removeFromSuperview];
        [sender addSubview:newView];
    }
}

//-(void)RequestAPIRequestOTP {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"RequestOTP" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICETOKEN, @"deviceToken", [PCFingerPrint checkTouchIdSupport] ? @"Y": @"N", @"isTouchID", FlagECash, @"haveECash", @"Y", @"resendFlag", @"register", @"view", ECash, @"pinEcash", nil]];
////        NSLog(@"Request OTP = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self UI];
//                [res becomeFirstResponder];
//                [timer invalidate];
//                secondsLeft = 180;
//                timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runTime:) userInfo:nil repeats:YES];
//                [self showAlert:[NSString stringWithFormat:@"%@ %@", L(@"otpCode"), L(@"hasBeenSent")] title:L(@"otpCode") btn:L(@"ok") tag:0 delegate:self];
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

//-(void)RequestAPIValidateOTP {
//    [[self view] endEditing:YES];
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"ValidateOTP" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICETOKEN, @"deviceToken", [PCFingerPrint checkTouchIdSupport] ? @"Y": @"N", @"isTouchID", [res text], @"otp", @"register", @"view", FlagECash, @"haveECash", ECash, @"pin", nil]];
////        NSLog(@"Validate OTP = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [timer invalidate];
//                [self performSegueWithIdentifier:@"Account" sender:self];
//            }
//            else
//            {
//                [maskView removeFromSuperview];
//                [self UI];
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
