//
//  LinkFingerprint.m
//  MPay
//
//  Created by Admin on 7/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "LinkFingerprint.h"
#import "RegFingerprint.h"

@implementation LinkFingerprint
{
    NSString *ret;
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

-(void)BackBtn {
    if ([defaults objectForKey:@"Register"]) {
        [self performSegueWithIdentifier:@"ResultSetPIN" sender:self];
    } else {
        [self performSegueWithIdentifier:@"UnwindToAccAndSecurity" sender:self];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"linkFingerprint"];
}

- (void)UI {
    UIView *bgview = [self UIView:self withFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-60)];
    [[bgview layer] setCornerRadius:10];
    
    [bgview addSubview:[self UIImage:self withFrame:CGRectMake((bgview.frame.size.width/2)-((bgview.bounds.size.width/3)/2), [self view].frame.size.height/12, bgview.frame.size.width/3.5, bgview.frame.size.width/3.5) withImageName:@"fingerprintgray.png"]];
    
    [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, bgview.frame.size.height-([self view].frame.size.height/1.7), bgview.bounds.size.width-40, 50) withText:@"payWithYourFingerprint" withTextSize:18 withAlignment:1 withLines:3]];
    
    UILabel *descfingprint = [self UILabel:self withFrame:CGRectMake(20, bgview.frame.size.height-([self view].frame.size.height/1.9), bgview.bounds.size.width-40, 60) withText:@"useYourFingerprint" withTextSize:textsize16 withAlignment:1 withLines:3];
    [descfingprint setTextColor:[self colorFromHexString:@"#AFAFAF" withAlpha:1.0]];
    [bgview addSubview:descfingprint];
    
    UIButton *btn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, bgview.frame.size.height-([self view].frame.size.height/5), bgview.bounds.size.width-(btnmarginleft*2), btnheight) withTitle:[@"linkMyFingerprint" uppercaseString] withTag:0];
    [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
    [bgview addSubview:btn];
    
    UIButton *notnow = [self UIButton:self withFrame:CGRectMake(10, bgview.frame.size.height-([self view].frame.size.height/10), bgview.bounds.size.width-20, 20) withTitle:@"notNow" withTag:1];
    [notnow setTitleColor:[self colorFromHexString:Color3 withAlpha:1.0] forState:UIControlStateNormal];
    [bgview addSubview:notnow];
    
    UILabel *disclaimer = [self UILabel:self withFrame:CGRectMake(20, bgview.frame.size.height-([self view].frame.size.height/2.8), bgview.bounds.size.width-40, 80) withText:@"fingerprintTermAndConditions" withTextSize:textsize12 withAlignment:1 withLines:0];
    [disclaimer setTextColor:[self colorFromHexString:@"#AFAFAF" withAlpha:1.0]];
    NSMutableAttributedString *attributeline = [[NSMutableAttributedString alloc] initWithString:@"fingerprintTermAndConditions"];
    NSRange customrange = [@"fingerprintTermAndConditions" rangeOfString:@"termAndConditions"];
    [attributeline addAttribute:NSUnderlineStyleAttributeName value:@1 range:customrange];
    [attributeline addAttribute:NSForegroundColorAttributeName value:[self colorFromHexString:@"#21A1CC" withAlpha:1.0] range:customrange];
    disclaimer.attributedText = attributeline;
    disclaimer.userInteractionEnabled = YES;
    [bgview addSubview:disclaimer];
    
    UIButton *terms = [self UIButton:self withFrame:CGRectMake(disclaimer.frame.origin.x, disclaimer.frame.origin.y+(disclaimer.frame.size.height/2), disclaimer.frame.size.width, disclaimer.frame.size.height/2) withTitle:@"" withTag:2];
    [bgview addSubview:terms];
    
    [[self view] addSubview:bgview];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
//        if ([PCFingerPrint checkTouchIdEnroll]) {
            if ([[defaults objectForKey:@"StatusLogin"] isEqualToString:@"Y"]) {
//                [self RequestAPIRegisterTouchIdCust];
                [self performSegueWithIdentifier:@"UnwindToAccAndSecurity" sender:self];
            } else {
//                [self RequestAPIRegisterTouchId];
                [self performSegueWithIdentifier:@"ResultSetPIN" sender:self];
            }
//        }
//        else {
//            [self showAlert:L(@"registerFingerprint") title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//            BOOL cangotosettings = (UIApplicationOpenSettingsURLString != NULL);
//            if (cangotosettings) {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//            }
//        }
    }
    else if([sender tag] == 1)
    {
        [defaults removeObjectForKey:@"ViewController"];
        if ([defaults objectForKey:@"Register"]) {
            [self performSegueWithIdentifier:@"ResultSetPIN" sender:self];
        } else {
            [self performSegueWithIdentifier:@"UnwindToAccAndSecurity" sender:self];
        }
    }
    else if([sender tag] == 2)
    {
        [defaults setObject:@"Settings" forKey:@"ViewController"];
        [self performSegueWithIdentifier:@"Terms" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"RegFingerprint"]) {
        [defaults removeObjectForKey:@"ViewController"];
        RegFingerprint *NVC = [segue destinationViewController];
        NVC.data = [[response objectForKey:@"params"] mutableCopy];
    }
}

//-(void)RequestAPIRegisterTouchId {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    GlobalVariable *GV = [GlobalVariable sharedInstance];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"RegisterTouchId" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICEID, @"deviceId", GV.haveEcash, @"haveECash", nil]];
////        NSLog(@"TouchId = %@",response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                data = [[response objectForKey:@"params"] mutableCopy];
//                [self RequestAPITokenSignatureReceiver];
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

//-(void)RequestAPITokenSignatureReceiver {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        @try {
//            PCToken *pctoken = [[PCToken alloc] init];
//            NSString *tokenSignature = [pctoken activateTokenWithTouchID:TOUCHIDPIN mobileNo:[data objectForKey:@"customerMobileNumber"] passPhrase:[data objectForKey:@"activationKeyPass"] actFile:[data objectForKey:@"actFile"]];
//
//            [self RequestData:self withAction:@"TokenSignatureReceiver" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICEID, @"deviceId", [data objectForKey:@"serialNo"], @"serialNo", [data objectForKey:@"customerId"], @"customerId", [data objectForKey:@"customerMobileNumber"], @"customerMobileNumber", tokenSignature, @"tokenSignature", nil]];
////            NSLog(@"TokenSignature = %@", response);
//        } @catch (NSException *exception) {
//            if (exception) {
//                ret = exception.reason;
//            }
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if ([ret length] > 0) {
//                [maskView removeFromSuperview];
//                [self showAlert:[NSString stringWithFormat:@"%@", ret] title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else {
//                if (response == nil) {
//                    [maskView removeFromSuperview];
//                    [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//                }
//                else if([[response objectForKey:@"ok"] intValue] == 1)
//                {
//                    [maskView removeFromSuperview];
//                    [defaults setObject:@"Y" forKey:@"Fingerprint"];
//                    [defaults setObject:@"ChangeFingerprint" forKey:@"Change"];
//                    [self performSegueWithIdentifier:@"RegFingerprint" sender:self];
////                    [self RequestAPIUpdateAuthentication];
//                } else {
//                    [maskView removeFromSuperview];
//                    if ([[response objectForKey:@"message"] containsString:@"||"]) {
//                        NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                        [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                    } else {
//                        [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                    }
//                }
//            }
//        });
//    });
//}

//-(void)RequestAPIRegisterTouchIdCust {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"RegisterTouchIdCust" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICEID, @"deviceId", nil]];
////        NSLog(@"TouchIdCust = %@",response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                data = [[response objectForKey:@"params"] mutableCopy];
//                [self RequestAPITokenSignatureReceiverCust];
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

//-(void)RequestAPITokenSignatureReceiverCust {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        @try {
//            PCToken *pctoken = [[PCToken alloc] init];
//            NSString *tokenSignature = [pctoken activateTokenWithTouchID:TOUCHIDPIN mobileNo:[data objectForKey:@"customerMobileNumber"] passPhrase:[data objectForKey:@"activationKeyPass"] actFile:[data objectForKey:@"actFile"]];
//
//            [self RequestData:self withAction:@"TokenSignatureReceiverCust" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICEID, @"deviceId", [data objectForKey:@"serialNo"], @"serialNo", tokenSignature, @"tokenSignature", nil]];
////            NSLog(@"TokenSignature = %@", response);
//        } @catch (NSException *exception) {
//            if (exception) {
//                ret = exception.reason;
//            }
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if ([ret length] > 0) {
//                [maskView removeFromSuperview];
//                [self showAlert:[NSString stringWithFormat:@"%@", ret] title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else {
//                if (response == nil) {
//                    [maskView removeFromSuperview];
//                    [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//                }
//                else if([[response objectForKey:@"ok"] intValue] == 1)
//                {
//                    [maskView removeFromSuperview];
//                    [defaults setObject:@"Y" forKey:@"Fingerprint"];
//                    [defaults setObject:@"ChangeFingerprint" forKey:@"Change"];
//                    [self performSegueWithIdentifier:@"RegFingerprint" sender:self];
////                    [self RequestAPIUpdateAuthenticationCust];
//                } else {
//                    [maskView removeFromSuperview];
//                    if ([[response objectForKey:@"message"] containsString:@"||||"]) {
//                        NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||||"];
//                        [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                    } else if ([[response objectForKey:@"message"] containsString:@"||"]) {
//                        NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                        [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                    } else {
//                        [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                    }
//                }
//            }
//        });
//    });
//}

@end
