//
//  CustomPIN.m
//  MPay
//
//  Created by Andi Wijaya on 10/14/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "CustomPIN.h"
#import "Login.h"
#import "DetailTransaction.h"
#import "Wallet.h"
#import "ChangeEmail.h"
#import "SecurityInfo.h"

@interface CustomPIN (){
    NSString *PKey, *PVal, *PExpo;
    UITextField *textField;
    UIView *pinIdentifier;
    Boolean flag;
    NSString *fromview;
}

@end

@implementation CustomPIN

@synthesize data, CardSelect, CardNumberTrx, AmtVal;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    self.navigationItem.hidesBackButton = NO;
}

- (void) initUI{
    
    UILabel *label = [self UILabel:self withFrame:CGRectMake(20, 70, self.view.frame.size.width - 40, 40) withText:@"enterYourPin" withTextSize:[self view].frame.size.height > 568 ? 20 : 16 withAlignment:1 withLines:0];
    [label setTextColor:[self colorFromHexString:Color1 withAlpha:1.0]];
    [[self view] addSubview:label];
    if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"ChangeEmail"]) {
        [label setText:@"enterYourPinToChangeEmail"];
    } else if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"AccAndSec"]) {
        [label setText:@"enterYourPinToLinkFingerprint"];
    } else if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"Payment"]) {
        [label setText:@"enterYourPinToMakePayment"];
    }
    
    UIView *newView = [self CustomeNumberPad:CGRectMake(25, 110, self.view.frame.size.width - 50, self.view.frame.size.height - 150.0)];
    [[self view] addSubview:newView];
}

- (UIView *) CustomeNumberPad:(CGRect)frame{
    UIView *newView = [[UIView alloc] initWithFrame:frame];
    [newView setBackgroundColor:[UIColor clearColor]];
    [newView setTag:1000000];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 10, newView.frame.size.width, 40)];
    [textField setBackgroundColor:[UIColor clearColor]];
    [textField setPlaceholder:@"pin"];
    [textField setTextAlignment:NSTextAlignmentCenter];
    [textField setDelegate:self];
    [textField setHidden:TRUE];
    [textField setTag:3000000];
    
    for (int i=0; i<6; i++) {
        pinIdentifier = [self dot:CGRectMake(((newView.frame.size.width/9)*1.75) + ((newView.frame.size.width/9) * i), 20, newView.frame.size.height/40, newView.frame.size.height/40) withTag:i];
        [newView addSubview:pinIdentifier];
    }
    
    UIView *btnView = [self ButtonView:CGRectMake(0, newView.frame.size.height * 0.2, newView.frame.size.width, newView.frame.size.height - (newView.frame.size.height * 0.2))];
    
    [newView addSubview:textField];
    [newView addSubview:btnView];
    
    return newView;
}

- (UIView *)dot:(CGRect)frame withTag:(int)tag{
    UIView *newView = [[UIView alloc] initWithFrame:frame];
    [newView setBackgroundColor:[UIColor clearColor]];
    [newView setTag:tag];
    [[newView layer] setCornerRadius:newView.frame.size.height/2];
    [[newView layer] setBorderWidth:1];
    [[newView layer] setBorderColor:[self colorFromHexString:Color3 withAlpha:1.0].CGColor];
    [[newView layer] setMasksToBounds:TRUE];
    
    return newView;
}


- (UIView *)ButtonView:(CGRect)frame{
    UIView *newView = [[UIView alloc] initWithFrame:frame];
    [newView setBackgroundColor:[UIColor clearColor]];
    [newView setTag:2000000];
    
    int labelsize = [self view].frame.size.height > 568 ? 40 : 32;
    int diameter = [self view].frame.size.height > 568 ? newView.frame.size.width/4.5 : newView.frame.size.width/4;
    
    UIButton *btn = [self CircleButton:CGRectMake((newView.frame.size.width/2) - (diameter*1.75), ((newView.frame.size.height/4) - (diameter))/2, diameter, diameter) withTitle:@"1" withRadius:((diameter)/2.0) withBorder:1 withTag:0];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [[btn titleLabel] setFont:[UIFont systemFontOfSize:labelsize]];
    
    UIButton *btn2 = [self CircleButton:CGRectMake((((newView.frame.size.width/3) - (diameter))/2) + newView.frame.size.width/3, ((newView.frame.size.height/4) - (diameter))/2, diameter, diameter) withTitle:@"2" withRadius:((diameter)/2.0) withBorder:1 withTag:1];
    [btn2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [[btn2 titleLabel] setFont:[UIFont systemFontOfSize:labelsize]];
    
    UIButton *btn3 = [self CircleButton:CGRectMake((newView.frame.size.width/2) + (diameter*0.75), ((newView.frame.size.height/4) - (diameter))/2, diameter, diameter) withTitle:@"3" withRadius:((diameter)/2.0) withBorder:1 withTag:2];
    [btn3 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [[btn3 titleLabel] setFont:[UIFont systemFontOfSize:labelsize]];
    
    //    line1
    UIButton *btn4 = [self CircleButton:CGRectMake((newView.frame.size.width/2) - (diameter*1.75), (((newView.frame.size.height/4) - (diameter))/2) + (diameter*1.25), diameter, diameter) withTitle:@"4" withRadius:((diameter)/2.0) withBorder:1 withTag:3];
    [btn4 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [[btn4 titleLabel] setFont:[UIFont systemFontOfSize:labelsize]];
    
    UIButton *btn5 = [self CircleButton:CGRectMake((((newView.frame.size.width/3) - (diameter))/2) + newView.frame.size.width/3, (((newView.frame.size.height/4) - (diameter))/2) + (diameter*1.25), diameter, diameter) withTitle:@"5" withRadius:((diameter)/2.0) withBorder:1 withTag:4];
    [btn5 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [[btn5 titleLabel] setFont:[UIFont systemFontOfSize:labelsize]];
    
    UIButton *btn6 = [self CircleButton:CGRectMake((newView.frame.size.width/2) + (diameter*0.75), (((newView.frame.size.height/4) - (diameter))/2) + (diameter*1.25), diameter, diameter) withTitle:@"6" withRadius:((diameter)/2.0) withBorder:1 withTag:5];
    [btn6 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [[btn6 titleLabel] setFont:[UIFont systemFontOfSize:labelsize]];
    
    //    line2
    UIButton *btn7 = [self CircleButton:CGRectMake((newView.frame.size.width/2) - (diameter*1.75), (((newView.frame.size.height/4) - (diameter))/2) + (diameter*2.5), diameter, diameter) withTitle:@"7" withRadius:((diameter)/2.0) withBorder:1 withTag:6];
    [btn7 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [[btn7 titleLabel] setFont:[UIFont systemFontOfSize:labelsize]];
    
    UIButton *btn8 = [self CircleButton:CGRectMake((((newView.frame.size.width/3) - (diameter))/2) + newView.frame.size.width/3, (((newView.frame.size.height/4) - (diameter))/2) + (diameter*2.5), diameter, diameter) withTitle:@"8" withRadius:((diameter)/2.0) withBorder:1 withTag:7];
    [btn8 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [[btn8 titleLabel] setFont:[UIFont systemFontOfSize:labelsize]];
    
    UIButton *btn9 = [self CircleButton:CGRectMake((newView.frame.size.width/2) + (diameter*0.75), (((newView.frame.size.height/4) - (diameter))/2) + (diameter*2.5), diameter, diameter) withTitle:@"9" withRadius:((diameter)/2.0) withBorder:1 withTag:8];
    [btn9 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [[btn9 titleLabel] setFont:[UIFont systemFontOfSize:labelsize]];
    
    //    line3
    UIButton *cancel = [self CircleButton:CGRectMake((newView.frame.size.width/2) - (diameter*1.75), (((newView.frame.size.height/4) - (diameter))/2) + (diameter*3.75), diameter, diameter) withTitle:@"cancel" withRadius:((diameter)/2.0) withBorder:0 withTag:9];
    [cancel setBackgroundColor:[UIColor whiteColor]];
    [cancel setTitleColor:[self colorFromHexString:Color3 withAlpha:1.0] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn0 = [self CircleButton:CGRectMake((((newView.frame.size.width/3) - (diameter))/2) + newView.frame.size.width/3, (((newView.frame.size.height/4) - (diameter))/2) + (diameter*3.75), diameter, diameter) withTitle:@"0" withRadius:((diameter)/2.0) withBorder:1 withTag:10];
    [btn0 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [[btn0 titleLabel] setFont:[UIFont systemFontOfSize:labelsize]];
    
    UIButton *delete = [self CircleButton:CGRectMake((newView.frame.size.width/2) + (diameter*0.75), (((newView.frame.size.height/4) - (diameter))/2) + (diameter*3.75), diameter, diameter) withTitle:@"" withRadius:((diameter)/2.0) withBorder:0 withTag:11];
    [delete setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"backspace.png"]] forState:UIControlStateNormal];
    [delete setBackgroundColor:[UIColor whiteColor]];
    [delete addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    [newView addSubview:btn];
    [newView addSubview:btn2];
    [newView addSubview:btn3];
    
    [newView addSubview:btn4];
    [newView addSubview:btn5];
    [newView addSubview:btn6];
    
    [newView addSubview:btn7];
    [newView addSubview:btn8];
    [newView addSubview:btn9];
    
    [newView addSubview:cancel];
    [newView addSubview:btn0];
    [newView addSubview:delete];
    
    return newView;
}

- (UIButton *)CircleButton:(CGRect)frame withTitle:(NSString *)title withRadius:(CGFloat)radius withBorder:(CGFloat)border withTag:(int)tag{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[self colorFromHexString:Color0 withAlpha:1.0] forState:UIControlStateNormal];
    [btn setTag:tag];
    [[btn layer] setCornerRadius:radius];
//    [[btn layer] setBorderWidth:border];
//    [[btn layer] setBorderColor:[self colorFromHexString:Color3 withAlpha:1.0].CGColor];
    [[btn layer] setMasksToBounds:TRUE];
    
    return btn;
}

- (void)click:(id)sender{
    NSString *pin = @"";
    
    if([sender tag] != 11  && [sender tag] != 9){
        pin = [NSString stringWithFormat: @"%@%@",
               [textField text], [sender currentTitle]];
        if([[textField text] length] <= 5){
            [textField setText:pin];
            for (id aSubview in self.view.subviews){
                if ([aSubview isKindOfClass:[UIView class]] &&  ([(UIView *)aSubview tag] == 1000000)) {
                    for (id dSubview in [aSubview subviews]) {
                        if ([dSubview isKindOfClass:[UIView class]] &&  ([(UIView *)dSubview tag] == ([[textField text] length] -1))) {
                            [dSubview setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
                        }
                    }
                }
            }
        }
    }else{
        if([[textField text] length] != 0 && [sender tag] != 9){
            [textField setText:[[textField text] substringToIndex:[[textField text] length]-1]];
            
            for (id aSubview in self.view.subviews){
                if ([aSubview isKindOfClass:[UIView class]] &&  ([(UIView *)aSubview tag] == 1000000)) {
                    for (id dSubview in [aSubview subviews]) {
                        if ([dSubview isKindOfClass:[UIView class]] &&  ([(UIView *)dSubview tag] == ([[textField text] length]))) {
                            [dSubview setBackgroundColor:[UIColor clearColor]];
                        }
                    }
                }
            }
            
        } else if([sender tag] == 9) {
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }
    
    if([[textField text] length] == 6){
        if(flag){
            flag = false;
            if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"Payment"]) {
//                [self RequestAPIGetPublicKeyUser];
                if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"ChangeEmail"]) {
                    [defaults removeObjectForKey:@"ViewController"];
                    [self performSegueWithIdentifier:@"ChangeEmail" sender:self];
                } else if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"AccAndSec"]) {
                    [self performSegueWithIdentifier:@"LinkFingerprint" sender:self];
                }
            }else {
                if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"ChangeEmail"]) {
                    fromview = @"changeEmail";
                } else if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"AccAndSec"]) {
                    fromview = @"linkFingerprint";
                }
//                [self RequestAPIGetPublicKeyUser];
                if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"ChangeEmail"]) {
                    [defaults removeObjectForKey:@"ViewController"];
                    [self performSegueWithIdentifier:@"ChangeEmail" sender:self];
                } else if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"AccAndSec"]) {
                    [self performSegueWithIdentifier:@"LinkFingerprint" sender:self];
                }
            }
        }
        
    }else{
        flag = true;
    }
}

- (void) reset{
    int i = 0;
    for (id aSubview in self.view.subviews){
        if ([aSubview isKindOfClass:[UIView class]] &&  ([(UIView *)aSubview tag] == 1000000)) {
            for (id dSubview in [aSubview subviews]) {
                if ([dSubview isKindOfClass:[UIView class]] &&  ([(UIView *)dSubview tag] == i)) {
                    [dSubview setBackgroundColor:[UIColor clearColor]];
                }
                i++;
            }
        }
    }
    flag = true;
    [textField setText:@""];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) {
        if(buttonIndex == 1)
        {
//            [self RequestAPIGetSecurityQuestionCust];
            [self performSegueWithIdentifier:@"SecurityInfo" sender:self];
        }
    } else if ([alertView tag] == 2) {
        if(buttonIndex == 0)
        {
            [defaults setObject:@"Reset" forKey:@"ValidatePIN"];
            [self performSegueWithIdentifier:@"ChangePIN" sender:self];
        }
    } else if ([alertView tag] == 4) {
        if(buttonIndex == 0)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            Wallet *myVC = (Wallet *)[storyboard instantiateViewControllerWithIdentifier:@"RootHome"];
            [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [[self navigationController] presentViewController:myVC animated:NO completion:nil];
        }
    } else if ([alertView tag] == 5) {
        if(buttonIndex == 0)
        {
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Receipt"]) {
        DetailTransaction *NVC = [segue destinationViewController];
        NVC.Response = data;
        NVC.CardSelect = CardSelect;
        NVC.RefNo = [[response objectForKey:@"params"] objectForKey:@"retrievalReferenceNoTrx"];
        NVC.CardNumberTrx = [[response objectForKey:@"params"] objectForKey:@"cardNumberTrx"];
        NVC.AmtTrx = [[response objectForKey:@"params"] objectForKey:@"totalAmountTrx"];
    } else if ([[segue identifier] isEqualToString:@"ChangeEmail"]) {
        ChangeEmail *NVC = [segue destinationViewController];
        NVC.data = data;
    } else if ([[segue identifier] isEqualToString:@"SecurityInfo"]) {
        SecurityInfo *NVC = [segue destinationViewController];
        NVC.SQCode = [[response objectForKey:@"params"] objectForKey:@"securityQuestCode"];
        NVC.SQuestion = [[response objectForKey:@"params"] objectForKey:@"securityQuestion"];
    }
}

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
//                if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"Payment"]) {
//                    [self RequestAPIPaymentSubmit];
//                } else {
//                    [self RequestAPIAuthenticationPIN];
//                }
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

//-(void)RequestAPIAuthenticationPIN {
//    [[self navigationController].view addSubview:[self showmask]];
//    [[self view] endEditing:YES];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"AuthenticationPIN" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICETOKEN, @"deviceToken", [self encryptHSM:[textField text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"pin", fromview, @"view", nil]];
////        NSLog(@"AuthPIN = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self reset];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                if ([[[response objectForKey:@"params"] objectForKey:@"isBlock"] isEqualToString:@"true"]) {
//                    [maskView removeFromSuperview];
//                    [[self view] endEditing:YES];
//                    [defaults removeObjectForKey:@"Background"];
//                    [self showAlert:L(@"popUpPinBlockedDesc") title:L(@"popUpPinBlockedTitle") btn:L(@"ok") tag:5 delegate:self];
//                }
//                else {
//                    [maskView removeFromSuperview];
//                    if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"ChangeEmail"]) {
//                        [defaults removeObjectForKey:@"ViewController"];
//                        [self performSegueWithIdentifier:@"ChangeEmail" sender:self];
//                    } else if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"AccAndSec"]) {
//                        [self performSegueWithIdentifier:@"LinkFingerprint" sender:self];
//                    }
////                    else if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"Payment"]) {
////                        [self RequestAPIPaymentSubmit];
////                    }
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
//            else if([[response objectForKey:@"ok"] intValue] == 0)
//            {
//                [maskView removeFromSuperview];
//                [self reset];
//                if ([[response objectForKey:@"message"] containsString:@"security.error.user.pin.reset"]) {
//                    [self showAlert:L(@"security.error.user.pin.reset") title:L(@"pinIsReset") btn:L(@"changePin") tag:2 delegate:self];
//                } else if ([[response objectForKey:@"message"] containsString:@"||||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                } else if ([[response objectForKey:@"message"] containsString:@"|||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"|||"];
//                    [self showAlert2:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn1:L(@"tryAgain") btn2:L(@"forgotPIN") tag:1 delegate:self];
//                } else if ([[response objectForKey:@"message"] containsString:@"||"]) {
//                    NSArray* foo = [[[response objectForKey:@"params"] objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                } else {
//                    [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                }
//            }
//
//        });
//    });
//}

//-(void)RequestAPIGetSecurityQuestionCust {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetSecurityQuestionCust" withParams:nil];
////        NSLog(@"SQ Cust = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self performSegueWithIdentifier:@"SecurityInfo" sender:self];
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

//-(void)RequestAPIPaymentSubmit {
//    [[self navigationController].view addSubview:[self showmask]];
//    [[self view] endEditing:YES];
//    NSString *lat = [NSString stringWithFormat:@"%@", [[[PCUtils execute:@"GetCurrentLocation" withParams:nil] objectForKey:@"params"] objectForKey:@"latitude"]];
//    NSString *lon = [NSString stringWithFormat:@"%@", [[[PCUtils execute:@"GetCurrentLocation" withParams:nil] objectForKey:@"params"] objectForKey:@"longitude"]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"PaymentSubmit" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[CardSelect objectForKey:@"cardId"], @"cardId", [CardSelect objectForKey:@"cardType"], @"cardType", [CardSelect objectForKey:@"cardFinancial"], @"cardFinancial", [data objectForKey:@"ecommRefNo"], @"ecommRefNo", DEVICETOKEN, @"deviceToken", [self encryptHSM:[textField text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"pin", AmtVal, @"totalAmountTrx", lat, @"latitude", lon, @"longitude", nil]];
////        NSLog(@"Payment Submit = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self reset];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                if ([[[response objectForKey:@"params"] objectForKey:@"isBlock"] isEqualToString:@"true"]) {
//                    [maskView removeFromSuperview];
//                    [[self view] endEditing:YES];
//                    [defaults removeObjectForKey:@"Background"];
//                    [self showAlert:L(@"popUpPinBlockedDesc") title:L(@"popUpPinBlockedTitle") btn:L(@"ok") tag:5 delegate:self];
//                }
//                else {
//                    if ([[[response objectForKey:@"params"] objectForKey:@"status"] isEqualToString:@"N"]) {
//                        if ([[[response objectForKey:@"params"] objectForKey:@"message"] containsString:@"||"]) {
//                            NSArray* foo = [[[response objectForKey:@"params"] objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                            [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:4 delegate:self];
//                        } else {
//                            [self showAlert:[[response objectForKey:@"params"] objectForKey:@"message"] title:L(@"message") btn:L(@"ok") tag:4 delegate:self];
//                        }
//                    } else {
//                        [defaults setObject:@"PaymentReceipt" forKey:@"ViewController"];
//                        [self performSegueWithIdentifier:@"Receipt" sender:self];
//                    }
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
//            else if([[response objectForKey:@"ok"] intValue] == 0)
//            {
//                [maskView removeFromSuperview];
//                [self reset];
//                if ([[response objectForKey:@"message"] containsString:@"security.error.user.pin.reset"]) {
//                    [self showAlert:L(@"security.error.user.pin.reset") title:L(@"pinIsReset") btn:L(@"changePin") tag:2 delegate:self];
//                } else if ([[response objectForKey:@"message"] containsString:@"||||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                } else if ([[response objectForKey:@"message"] containsString:@"|||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"|||"];
//                    [self showAlert2:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn1:L(@"tryAgain") btn2:L(@"forgotPIN") tag:1 delegate:self];
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

-(IBAction)prepareForUnwindToPIN:(UIStoryboardSegue *)segue {
}

@end
