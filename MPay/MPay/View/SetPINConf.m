//
//  SetPINConf.m
//  MPay
//
//  Created by Andi Wijaya on 10/17/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "SetPINConf.h"
#import "LinkFingerprint.h"

@interface SetPINConf (){
    NSString *PVal, *PExpo, *PKey;
    UIView *bgview, *garis1, *garis2, *garis3, *garis4, *garis5, *garis6;
    UITextField *textFields;
    UIButton *openPINS, *confBTN;
    UITextField *res;
    UIView *newView;
}

@end

@implementation SetPINConf

@synthesize pin,data, PInfo, Bday, ActKey, ActFile;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"confirmPin"];
}

- (void)UI {
    bgview = [self UIView:self withFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-60)];
    [[bgview layer] setCornerRadius:10];
    
    res = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [res setKeyboardType:UIKeyboardTypeNumberPad];
    [res becomeFirstResponder];
    [res setDelegate:self];
    [res setHidden:TRUE];
    [res setTag:10000000];
    [bgview addSubview:res];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, [self view].frame.size.height/20, self.view.frame.size.width - 40, [self view].frame.size.height/10)];
    [label setText:@"setConfirmPinDesc"];
    [label setTextColor:[self colorFromHexString:@"#6E6E6E" withAlpha:1.0]];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setNumberOfLines:2];
    [label setTag:20000000];
    [bgview addSubview:label];
    
    for (int i=0; i<7; i++) {
        if(i < 6){
            textFields = [self dot:CGRectMake(30+(i*(([self view].frame.size.width-130)/6)+(i*10)), label.frame.origin.y + label.frame.size.height + [self view].frame.size.height/10, ([self view].frame.size.width-130)/6, [self view].frame.size.height/20) withTag:i];
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
        }else{
            openPINS = [self btnPasswordImage:CGRectMake([self view].frame.size.width-40, textFields.frame.origin.y+((textFields.frame.size.height/2)-12.5), 25, 25) withTag:i];
            [openPINS addTarget:self action:@selector(openPassword) forControlEvents:UIControlEventTouchUpInside];
            [bgview addSubview:openPINS];
        }
    }
    
    UIButton *showKeyboard = [[UIButton alloc] initWithFrame:CGRectMake(0, textFields.frame.origin.y, self.view.frame.size.width - (openPINS.frame.size.width + 15), [self view].frame.size.height/20)];
    [showKeyboard setBackgroundColor:[UIColor clearColor]];
    [showKeyboard setTag:0];
    [showKeyboard addTarget:self action:@selector(openKeyboard:) forControlEvents:UIControlEventTouchUpInside];\
    [bgview addSubview:showKeyboard];
    
    confBTN = [self UIButton:self withFrame:CGRectMake(btnmarginleft, ([self view].frame.size.height/2)-50, self.view.frame.size.width-(btnmarginleft*2), btnheight) withTitle:[@"confirmPin" uppercaseString] withTag:1];
    [confBTN setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    [confBTN setEnabled:NO];
    [bgview addSubview:confBTN];
    
    [[self view] addSubview:bgview];
}

- (void) openKeyboard:(id)sender{
    [res becomeFirstResponder];
}

- (void)openPassword{
    for (id aSubview in bgview.subviews){
        if ([aSubview isKindOfClass:[UITextField class]] && ([(UITextField *)aSubview tag] != 10000000)) {
            if([aSubview isSecureTextEntry] == false){
                [aSubview setSecureTextEntry:true];
                [openPINS setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passopen.png"]] forState:UIControlStateNormal];
            }else{
                [aSubview setSecureTextEntry:false];
                [openPINS setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passclosed.png"]] forState:UIControlStateNormal];
            }
        }
    }
}

- (UITextField *)dot:(CGRect)frame withTag:(int)tag{
    UITextField *newField = [[UITextField alloc] initWithFrame:frame];
    [newField setBackgroundColor:[UIColor clearColor]];
    [newField setTag:tag];
    [newField setTextAlignment:NSTextAlignmentCenter];
    [newField setKeyboardType:UIKeyboardTypeNumberPad];
    [newField setFont:[UIFont boldSystemFontOfSize:24]];
    [newField setTintColor:[UIColor clearColor]];
    [newField setTextColor:[self colorFromHexString:@"#6E6E6E" withAlpha:1.0]];
    [newField setDelegate:self];
    [newField setEnabled:FALSE];
    [newField setSecureTextEntry:TRUE];
    
//    CALayer *newLayer = [CALayer layer];
//    
    CGFloat flHeight = newField.frame.size.height;
    CGFloat flWidth = newField.frame.size.width;
//    newLayer.frame = CGRectMake(0, flHeight, flWidth, 1.5);
//    newLayer.backgroundColor = [[self colorFromHexString:@"#E6E6E6" withAlpha:1.5] CGColor];
//    newLayer.name = @"bottomLayer";
//    
//    [[newField layer] addSublayer:newLayer];
    
    newView = [[UIView alloc] initWithFrame:CGRectMake(0, flHeight, flWidth, 1.5)];
    [newView setBackgroundColor:[self colorFromHexString:@"#E6E6E6" withAlpha:1.5]];
    [newView setTag:tag];
    
    [newField addSubview:newView];
    
    return newField;
}

-(void)Act:(id)sender {
    if([sender tag] == 1){
        if([[res text] length] != 6){
            [self showAlert:[NSString stringWithFormat:@"PIN %@", @"mustContainDigit"] title:@"warning" btn:@"ok" tag:0 delegate:self];
        }else{
            if(![[pin objectForKey:@"PIN"] isEqualToString:[res text]]){
                [self showAlert:@"pinMustEqual" title:@"warning" btn:@"ok" tag:0 delegate:self];
            }else{
//                [self RequestAPIValidatePINBackOffice];
                [self performSegueWithIdentifier:@"LinkFingerprint" sender:self];
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 2) {
        if(buttonIndex == 0)
        {
            [self performSegueWithIdentifier:@"UnwindToRegister" sender:self];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.view addGestureRecognizer:tapRecognizer];
    [confBTN setFrame:CGRectMake(10, ([self view].frame.size.height/2)-50, self.view.frame.size.width - 20, btnheight)];
    for (id aSubview in bgview.subviews){
        if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == [[textField text] length])) {
            [self CustomLine:aSubview withColor:@"#81DCEC"];
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.view removeGestureRecognizer:tapRecognizer];
    [confBTN setFrame:CGRectMake(10, bgview.frame.size.height-([self view].frame.size.height/7), self.view.frame.size.width - 20, btnheight)];
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
            for (id aSubview in  bgview.subviews){
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == (newLength))) {
                    [[aSubview viewWithTag:[aSubview tag]] setText:string];
                    [self CustomLine:aSubview withColor:@"#81DCEC"];
                }
                
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == (newLength + 1))) {
                    [[aSubview viewWithTag:[aSubview tag]] setText:string];
                    [self CustomLine:aSubview withColor:@"#E6E6E6"];
                }
                
            }
        }else{
            for (id aSubview in bgview.subviews){
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == (newLength - 1))) {
                    [[aSubview viewWithTag:[aSubview tag]] setText:string];
                    [self CustomLine:aSubview withColor:@"#E6E6E6"];
                }
                
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == newLength)) {
                    [self CustomLine:aSubview withColor:@"#81DCEC"];
                }
            }
        }
    }else{
        if (range.length==1 && string.length==0){
            for (id aSubview in bgview.subviews){
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == (newLength))) {
                    [[aSubview viewWithTag:[aSubview tag]] setText:string];
                    [self CustomLine:aSubview withColor:@"#81DCEC"];
                }
                
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == (newLength + 1))) {
                    [[aSubview viewWithTag:[aSubview tag]] setText:string];
                    [self CustomLine:aSubview withColor:@"#E6E6E6"];
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
        [confBTN setEnabled:YES];
        [confBTN setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
    } else {
        [confBTN setEnabled:NO];
        [confBTN setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    }
    
    return newLength <= 6;
}

- (void) CustomLine:(id)sender withColor:(NSString *)color{
    if([[[sender subviews] objectAtIndex:0] tag] == [sender tag]){
//    if([[[[[sender layer] sublayers] objectAtIndex:0] name] isEqualToString:@"bottomLayer"]){
        UIColor *attrColor = [self colorFromHexString:color withAlpha:1.0];
        
//        CALayer *newLayer = [CALayer layer];
//        
        CGFloat flHeight = [sender frame].size.height;
        CGFloat flWidth = [sender frame].size.width;
//        newLayer.frame = CGRectMake(0, flHeight, flWidth, 1.5);
//        newLayer.backgroundColor = [attrColor CGColor];
//        newLayer.name = @"bottomLayer";
//        
//        [[sender layer] replaceSublayer:[[[sender layer] sublayers] objectAtIndex:0] with:newLayer];
        
        newView = [[UIView alloc] initWithFrame:CGRectMake(0, flHeight, flWidth, 1.5)];
        [newView setBackgroundColor:attrColor];
        [newView setTag:[sender tag]];
        
        [[[[sender subviews] objectAtIndex:0] viewWithTag:[sender tag]] removeFromSuperview];
        [sender addSubview:newView];
    }
}

//-(void)RequestAPIValidatePINBackOffice {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"ValidatePINBackOffice" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[res text], @"pin", nil]];
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
//                [self RequestAPIRegisterMPayUser];
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

//-(void)RequestAPIRegisterMPayUser {
//    [[self view] endEditing:YES];
//    [[self navigationController].view addSubview:[self showmask]];
//    NSString *lat = [NSString stringWithFormat:@"%@", [[[PCUtils execute:@"GetCurrentLocation" withParams:nil] objectForKey:@"params"] objectForKey:@"latitude"]];
//    NSString *lon = [NSString stringWithFormat:@"%@", [[[PCUtils execute:@"GetCurrentLocation" withParams:nil] objectForKey:@"params"] objectForKey:@"longitude"]];
//
//    GlobalVariable *GV = [GlobalVariable sharedInstance];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"RegisterMPayUser" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[data objectForKey:@"FirstName"], @"firstName", [data objectForKey:@"LastName"], @"lastName", [data objectForKey:@"IDType"], @"idType", [data objectForKey:@"IDNumber"], @"idTypeValue", [data objectForKey:@"ListSQ"], @"listSecurityQuestion", [PInfo objectForKey:@"Email"], @"emailAddress", [PInfo objectForKey:@"Password"], @"password", Bday, @"dateOfBirthday", [self encryptHSM:[res text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"pinHashed", [res text], @"pin", DEVICETOKEN, @"deviceToken", GV.haveEcash, @"haveECash", [PCFingerPrint checkTouchIdSupport] ? @"Y": @"N", @"isTouchID", lat, @"latitude", lon, @"longitude", nil]];
////        NSLog(@"%@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:@"Warning!" btn:@"OK" tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                GlobalVariable *GV = [GlobalVariable sharedInstance];
//                GV.Email = [PInfo objectForKey:@"Email"];
//                [defaults removeObjectForKey:@"MobileNumber"];
//                [defaults setObject:@"YES" forKey:@"FirstIn"];
//                [defaults setObject:@"Register" forKey:@"Register"];
//                if ([PCFingerPrint checkTouchIdSupport]) {
//                    [self performSegueWithIdentifier:@"LinkFingerprint" sender:self];
//                } else {
//                    [self performSegueWithIdentifier:@"ResultSetPIN" sender:self];
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


@end
