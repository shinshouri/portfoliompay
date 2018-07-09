//
//  VerifyEcashPIN.m
//  MPay
//
//  Created by Andi on 7/28/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "VerifyEcashPIN.h"
#import "Verification.h"

@implementation VerifyEcashPIN
{
//    UILabel *pinLabel;
//    UITextField *PIN;
    UIView *bgview, *garis1, *garis2, *garis3, *garis4, *garis5, *garis6;
    UITextField *res;
    UITextField *textFields;
    UIButton *sendBtn, *openPIN;
    UIView *newView;
}
@synthesize data, FlagECash;

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"verification"];
    [self.view addGestureRecognizer:tapRecognizer];
    [self UI];
    [res becomeFirstResponder];
}

- (void)UI {
    [bgview removeFromSuperview];
    bgview = [self UIView:self withFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-60)];
    [[bgview layer] setCornerRadius:10];
    
    res = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [res setKeyboardType:UIKeyboardTypeNumberPad];
    [res becomeFirstResponder];
    [res setDelegate:self];
    [res setHidden:TRUE];
    [res setTag:10000000];
    [bgview addSubview:res];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, [self view].frame.size.height/20, self.view.frame.size.width - 40, 60)];
    [label setText:@"verificationDescHasEcash"];
    [label setTextColor:[self colorFromHexString:@"#6E6E6E" withAlpha:1.0]];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setNumberOfLines:3];
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
            openPIN = [self btnPasswordImage:CGRectMake([self view].frame.size.width-40, textFields.frame.origin.y+((textFields.frame.size.height/2)-12.5), 25, 25) withTag:i];
            [openPIN addTarget:self action:@selector(openPassword) forControlEvents:UIControlEventTouchUpInside];
            [bgview addSubview:openPIN];
        }
    }
    
    
    UIButton *showKeyboard = [[UIButton alloc] initWithFrame:CGRectMake(0, textFields.frame.origin.y + 10, self.view.frame.size.width - (openPIN.frame.size.width + 15), 50)];
    [showKeyboard setBackgroundColor:[UIColor clearColor]];
    [showKeyboard setTag:0];
    [showKeyboard addTarget:self action:@selector(openKeyboard:) forControlEvents:UIControlEventTouchUpInside];\
    [bgview addSubview:showKeyboard];
    
    sendBtn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, ([self view].frame.size.height/2)-50, self.view.frame.size.width-(btnmarginleft*2), btnheight) withTitle:[@"send" uppercaseString] withTag:1];
    [sendBtn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    [sendBtn setEnabled:NO];
    [bgview addSubview:sendBtn];
    
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
                [openPIN setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passopen.png"]] forState:UIControlStateNormal];
            }else{
                [aSubview setSecureTextEntry:false];
                [openPIN setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passclosed.png"]] forState:UIControlStateNormal];
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
    
    return newField;
}

- (void) CustomLine:(id)sender withColor:(NSString *)color{
//    if([[[sender subviews] objectAtIndex:0] tag] == [sender tag]){
//    if([[[[[sender layer] sublayers] objectAtIndex:0] name] isEqualToString:@"bottomLayer"]){
//        UIColor *attrColor = [self colorFromHexString:color withAlpha:1.0];
        
//        CALayer *newLayer = [CALayer layer];
//        
//        CGFloat flHeight = [sender frame].size.height;
//        CGFloat flWidth = [sender frame].size.width;
//        newLayer.frame = CGRectMake(0, flHeight, flWidth, 1.5);
//        newLayer.backgroundColor = [attrColor CGColor];
//        newLayer.name = @"bottomLayer";
//        
//        [[sender layer] replaceSublayer:[[[sender layer] sublayers] objectAtIndex:0] with:newLayer];
        
//        newView = [[UIView alloc] initWithFrame:CGRectMake(0, flHeight, flWidth, 1.0)];
//        [newView setBackgroundColor:attrColor];
//        [newView setTag:[sender tag]];
        
//        [[[[sender subviews] objectAtIndex:0] viewWithTag:[sender tag]] removeFromSuperview];
//        [sender addSubview:newView];
//    }
}

-(void)Act:(id)sender {
    if([sender tag] == 1)
    {
        if ([[res text] length] == 6) {
//            [self RequestAPIValidatePINECash];
//            [self RequestAPIRequestOTP];
            [self performSegueWithIdentifier:@"Verification" sender:self];
        }
        else {
            [self showAlert:@"pleaseInsertECashPIN" title:@"resendVerificationCode" btn:@"ok" tag:0 delegate:self];
        }
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
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
                
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UIView *)aSubview tag] == newLength)) {
                }
            }
        }
    }else{
        if (range.length==1 && string.length==0){
            for (id aSubview in bgview.subviews){
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == (newLength))) {
                    [[aSubview viewWithTag:[aSubview tag]] setText:string];
                }
                
                if ([aSubview isKindOfClass:[UITextField class]] &&  ([(UITextField *)aSubview tag] == (newLength + 1))) {
                    [[aSubview viewWithTag:[aSubview tag]] setText:string];
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Verification"]) {
        Verification *NVC = [segue destinationViewController];
        NVC.data = data;
        NVC.FlagECash = FlagECash;
        NVC.ECash = [res text];
    }
}

//-(void)RequestAPIValidatePINECash {
//    [[self view] endEditing:YES];
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"ValidatePINECash" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[res text], @"pinEcash", [PCFingerPrint checkTouchIdSupport] ? @"Y": @"N", @"isTouchID", nil]];
////        NSLog(@"Validate E-Cash = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self RequestAPIRequestOTP];
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

//-(void)RequestAPIRequestOTP {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"RequestOTP" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICETOKEN, @"deviceToken", [res text], @"pinEcash", [PCFingerPrint checkTouchIdSupport] ? @"Y": @"N", @"isTouchID", FlagECash, @"haveECash", @"N", @"resendFlag", @"register", @"view", nil]];
////        NSLog(@"Request OTP = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self performSegueWithIdentifier:@"Verification" sender:self];
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
