//
//  PushPIN.m
//  MPay
//
//  Copyright © 2016 Admin. All rights reserved.
//

#import "PushPIN.h"
#import "Login.h"
#import "DetailTransaction.h"
#import "Wallet.h"
#import "ChangeEmail.h"

@implementation PushPIN
{
    UITextField *PIN;
    UIImageView *img1;
    UIImageView *img2;
    UIImageView *img3;
    UIImageView *img4;
    UIImageView *img5;
    UIImageView *img6;
}
@synthesize data, CardSelect;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *bgview = [self UIView:self withFrame:CGRectMake(0, 0, [self view].frame.size.width, [self view].frame.size.height)];
    [bgview setBackgroundColor:[self colorFromHexString:@"#FAFAFA" withAlpha:1.0]];
    [[self view] addSubview:bgview];
    
    [self UI];
}

-(void)viewWillAppear:(BOOL)animated {
    [PIN becomeFirstResponder];
    
    if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"Receipt"]) {
        [defaults removeObjectForKey:@"ViewController"];
        [self dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)UI {
//    UIButton *X = [self UIButton:self withFrame:CGRectMake(10, 20, 40, 40) withTitle:@"" withTag:0];
//    [X setImage:[UIImage imageNamed:@"Close.png"] forState:UIControlStateNormal];
//    [[self view] addSubview:X];
    
    if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"Payment"]) {
        if ([[CardSelect objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
            [[self view] addSubview:[self ECardAssets:self withFrame:CGRectMake(20, 70, (self.view.frame.size.width-40), ((self.view.frame.size.width-40)/5)*3) withImage:[NSString stringWithFormat:@"%@.png",[CardSelect objectForKey:@"cardType"]] withBalance:[CardSelect objectForKey:@"cardBalance"] withCardNumber:[CardSelect objectForKey:@"cardNumberMasking"] withCardType:[CardSelect objectForKey:@"cardType"] withTag:1]];
        } else {
            [[self view] addSubview:[self CardAssets:self withFrame:CGRectMake(20, 70, (self.view.frame.size.width-40), ((self.view.frame.size.width-40)/5)*3) withImage:[NSString stringWithFormat:@"%@.png",[CardSelect objectForKey:@"cardType"]] withBalance:[CardSelect objectForKey:@"cardBalance"] withCardNumber:[CardSelect objectForKey:@"cardNumberMasking"] withCardExp:[CardSelect objectForKey:@"cardExp"] withCardType:[CardSelect objectForKey:@"cardType"] withTag:1]];
        }
        
//        UIImageView *img = [self UIImage:self withFrame:CGRectMake(20, 40, [self view].frame.size.width-40, (self.view.frame.size.width-40)/2) withImageName:[NSString stringWithFormat:@"%@.png", [CardSelect objectForKey:@"cardType"]]];
//        [[self view] addSubview:img];
        [[self view] addSubview:[self UILabel:self withFrame:CGRectMake(([self view].frame.size.width/2)-75, ([self view].frame.size.height/2)-40, 150, 20) withText:L(@"paymentApproval") withTextSize:14 withAlignment:1 withLines:0]];
        [[self view] addSubview:[self UILabel:self withFrame:CGRectMake(([self view].frame.size.width/2)-75, ([self view].frame.size.height/2)-20, 150, 20) withText:L(@"enterYourPin") withTextSize:14 withAlignment:1 withLines:0]];
    } else if([[defaults objectForKey:@"ViewController"] isEqualToString:@"ChangeEmail"]) {
        GlobalVariable *GV = [GlobalVariable sharedInstance];
        UIImageView *img = [self UIImage:self withFrame:CGRectMake(([self view].frame.size.width/2)-(([self view].frame.size.height/5)/2), 60, [self view].frame.size.height/5, [self view].frame.size.height/5) withImageName:@""];
        [[img layer] setCornerRadius:([self view].frame.size.height/5)/2];
        [img setClipsToBounds:YES];
        [[img layer] setBorderWidth:2.0f];
        [[img layer] setBorderColor:[UIColor whiteColor].CGColor];
        NSURL *url = [NSURL URLWithString:GV.ImageBase64];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        [img setImage:[UIImage imageWithData:imageData]];
        [[self view] addSubview:img];
        
        [[self view] addSubview:[self UILabel:self withFrame:CGRectMake(([self view].frame.size.width/2)-75, ([self view].frame.size.height/2)-40, 150, 20) withText:L(@"enterYourPin") withTextSize:14 withAlignment:1 withLines:0]];
    }
    
    int imgsize = 30;
    img1 = [self UIImage:self withFrame:CGRectMake(([self view].frame.size.width/2)-(imgsize*3)-30, [self view].frame.size.height/2, imgsize, imgsize) withImageName:@"PIN2.png"];
    [[self view] addSubview:img1];
    img2 = [self UIImage:self withFrame:CGRectMake(([self view].frame.size.width/2)-(imgsize*2)-20, [self view].frame.size.height/2, imgsize, imgsize) withImageName:@"PIN2.png"];
    [[self view] addSubview:img2];
    img3 = [self UIImage:self withFrame:CGRectMake(([self view].frame.size.width/2)-imgsize-10, [self view].frame.size.height/2, imgsize, imgsize) withImageName:@"PIN2.png"];
    [[self view] addSubview:img3];
    img4 = [self UIImage:self withFrame:CGRectMake(([self view].frame.size.width/2), [self view].frame.size.height/2, imgsize, imgsize) withImageName:@"PIN2.png"];
    [[self view] addSubview:img4];
    img5 = [self UIImage:self withFrame:CGRectMake(([self view].frame.size.width/2)+imgsize+10, [self view].frame.size.height/2, imgsize, imgsize) withImageName:@"PIN2.png"];
    [[self view] addSubview:img5];
    img6 = [self UIImage:self withFrame:CGRectMake(([self view].frame.size.width/2)+(imgsize*2)+20, [self view].frame.size.height/2, imgsize, imgsize) withImageName:@"PIN2.png"];
    [[self view] addSubview:img6];
    
    PIN = [self UITextField:self withFrame:CGRectMake(0, 0, 0, 0) withText:@"" withSize:16 withInputType:UIKeyboardTypeNumberPad withSecure:1];
    [PIN setDelegate:self];
    [PIN setTag:0];
    [PIN setHidden:YES];
    [[self view] addSubview:PIN];
    
    [PIN becomeFirstResponder];
}

-(void)Act:(id)sender {
    if ([sender tag] == 0) {
//        [[self view] endEditing:YES];
//        [[self topViewController] dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Segue Delegate
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Receipt"]) {
        DetailTransaction *NVC = [segue destinationViewController];
        NVC.Response = data;
        NVC.CardSelect = CardSelect;
    } else if ([[segue identifier] isEqualToString:@"ChangeEmail"]) {
        ChangeEmail *NVC = [segue destinationViewController];
        NVC.data = data;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if ([[textField text] length] ==6) {
        [self RequestAPIAuthenticationPIN];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField tag] == 0) {
        // Prevent crashing undo bug – see note below.
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        
        switch (newLength) {
            case 0:
                [img1 setImage:[UIImage imageNamed:@"PIN2.png"]];
                break;
            case 1:
                [img1 setImage:[UIImage imageNamed:@"PIN1.png"]];
                [img2 setImage:[UIImage imageNamed:@"PIN2.png"]];
                break;
            case 2:
                [img2 setImage:[UIImage imageNamed:@"PIN1.png"]];
                [img3 setImage:[UIImage imageNamed:@"PIN2.png"]];
                break;
            case 3:
                [img3 setImage:[UIImage imageNamed:@"PIN1.png"]];
                [img4 setImage:[UIImage imageNamed:@"PIN2.png"]];
                break;
            case 4:
                [img4 setImage:[UIImage imageNamed:@"PIN1.png"]];
                [img5 setImage:[UIImage imageNamed:@"PIN2.png"]];
                break;
            case 5:
                [img5 setImage:[UIImage imageNamed:@"PIN1.png"]];
                [img6 setImage:[UIImage imageNamed:@"PIN2.png"]];
                break;
            case 6:
                [img6 setImage:[UIImage imageNamed:@"PIN1.png"]];
                [[self view] addSubview:[self showmask]];
                [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(PINdone) userInfo:nil repeats:NO];
                break;
                
            default:
                break;
        }
        
        return newLength <= 6;
    }
    return NO;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) {
        if(buttonIndex == 1)
        {
            [self performSegueWithIdentifier:@"SecurityInfo" sender:self];
        }
    } else
    if ([alertView tag] == 5) {
        if(buttonIndex == 0)
        {
            [self GotoPage:self withIdentifier:@"RootHome"];
        }
    }
}

-(void)PINdone {
    [PIN endEditing:YES];
}

-(void)RequestAPIAuthenticationPIN {
    [[self view] endEditing:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self RequestData:self withAction:@"AuthenticationPIN" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICETOKEN, @"deviceToken", [PCUtils sha1:[PIN text]], @"pin", nil]];
        NSLog(@"AuthPIN = %@", response);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response == nil) {
                [maskView removeFromSuperview];
                [PIN becomeFirstResponder];
                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
            }
            else if([[response objectForKey:@"ok"] intValue] == 1)
            {
                if ([[[response objectForKey:@"params"] objectForKey:@"isBlock"] isEqualToString:@"true"]) {
                    [maskView removeFromSuperview];
                    [[self view] endEditing:YES];
                    [defaults removeObjectForKey:@"Background"];
                    [self showAlert:L(@"popUpPinBlockedDesc") title:L(@"popUpPinBlockedTitle") btn:@"OK" tag:5 delegate:self];
                }
                else {
                    [maskView removeFromSuperview];
                    if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"PushNotif"]) {
                        [defaults removeObjectForKey:@"Background"];
                        [defaults removeObjectForKey:@"ViewController"];
                        [self performSegueWithIdentifier:@"Payment" sender:self];
                    }
                    else if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"Payment"]) {
                        [defaults removeObjectForKey:@"Background"];
                        [self RequestAPIPaymentSubmit];
                    }
                    else if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"ChangeEmail"]) {
                        [defaults removeObjectForKey:@"ViewController"];
                        [self performSegueWithIdentifier:@"ChangeEmail" sender:self];
                    }
                }
            }
            else if([[response objectForKey:@"logout"] intValue] == 1)
            {
                [defaults setObject:@"N" forKey:@"StatusLogin"];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
                [[self topViewController] presentViewController:myVC animated:NO completion:nil];
            }
            else if([[response objectForKey:@"ok"] intValue] == 0)
            {
                [maskView removeFromSuperview];
                [PIN becomeFirstResponder];
                [self showAlert2:[response objectForKey:@"message"] title:L(@"popUpIncorrectPinTitle") btn1:L(@"tryAgain") btn2:L(@"forgotPIN") tag:1 delegate:self];
            }
            [PIN setText:@""];
            [img1 setImage:[UIImage imageNamed:@"PIN2.png"]];
            [img2 setImage:[UIImage imageNamed:@"PIN2.png"]];
            [img3 setImage:[UIImage imageNamed:@"PIN2.png"]];
            [img4 setImage:[UIImage imageNamed:@"PIN2.png"]];
            [img5 setImage:[UIImage imageNamed:@"PIN2.png"]];
            [img6 setImage:[UIImage imageNamed:@"PIN2.png"]];
            
        });
    });
}

-(void)RequestAPIPaymentSubmit {
    [[self view] addSubview:[self showmask]];
    [[self view] endEditing:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self RequestData:self withAction:@"PaymentSubmit" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[CardSelect objectForKey:@"cardId"], @"cardId", [CardSelect objectForKey:@"cardType"], @"cardType", [data objectForKey:@"ecommRefNo"], @"ecommRefNo", nil]];
        NSLog(@"Payment Submit = %@", response);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response == nil) {
                [maskView removeFromSuperview];
                [PIN becomeFirstResponder];
                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
            }
            else if([[response objectForKey:@"ok"] intValue] == 1)
            {
                [maskView removeFromSuperview];
                [defaults setObject:@"PaymentReceipt" forKey:@"ViewController"];
                [self performSegueWithIdentifier:@"Receipt" sender:self];
            }
            else if([[response objectForKey:@"logout"] intValue] == 1)
            {
                [defaults setObject:@"N" forKey:@"StatusLogin"];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
                [[self topViewController] presentViewController:myVC animated:NO completion:nil];
            }
            else if([[response objectForKey:@"ok"] intValue] == 0)
            {
                [maskView removeFromSuperview];
                [PIN becomeFirstResponder];
                [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
            }
        });
    });
}

-(void)RequestAPILogout {
    [[self view] addSubview:[self showmask]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self RequestData:self withAction:@"Logout" withParams:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response == nil) {
                [maskView removeFromSuperview];
                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
            }
            else if([[response objectForKey:@"ok"] intValue] == 1)
            {
                [maskView removeFromSuperview];
                [defaults setObject:@"N" forKey:@"StatusLogin"];
            }
            else if([[response objectForKey:@"logout"] intValue] == 1)
            {
                [defaults setObject:@"N" forKey:@"StatusLogin"];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
                [[self topViewController] presentViewController:myVC animated:NO completion:nil];
            }
            else
            {
                [maskView removeFromSuperview];
                [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
            }
        });
    });
}

-(IBAction)prepareForUnwindToPIN:(UIStoryboardSegue *)segue {
}

@end
