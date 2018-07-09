//
//  TermsAndConditions.m
//  MPay
//
//  Created by Admin on 7/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "TermsAndConditions.h"
#import "Login.h"
#import "Register.h"

@implementation TermsAndConditions
{
    UIView *Footer;
    UIButton *AG, *DG;
    UITextView *txt;
    NSString *datatnc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([defaults objectForKey:@"tnc"]) {
//        datatnc = [defaults objectForKey:@"tnc"];
//        [self UI];
//    } else {
//        [self RequestAPIGetTermsAndCondition];
//        [self UI];
//    }
    datatnc = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi et egestas odio. Suspendisse venenatis ex vitae suscipit finibus. Sed vulputate, dolor id varius interdum, ante urna efficitur odio, a fringilla urna magna ac orci. Proin iaculis lorem dolor, ut vestibulum urna fermentum sed. Sed libero purus, porttitor id augue id, ornare maximus tortor. Ut placerat ac lorem id interdum. Morbi lorem nunc, blandit ac ornare ac, rutrum at quam. Proin nibh dui, porta ac ligula nec, luctus interdum dui. Fusce varius turpis in tempor scelerisque. Duis gravida justo ut enim posuere dictum. Etiam sit amet commodo nisi. Maecenas fringilla elit ac lobortis vestibulum. Donec dictum quis lectus ac rhoncus. Maecenas id purus nec leo vestibulum eleifend. Morbi accumsan, quam in dapibus aliquam, libero nulla dignissim urna, vel molestie orci lectus sed ligula. In iaculis orci neque, nec sodales purus feugiat a. In turpis augue, vestibulum ac blandit at, sollicitudin at ante. Etiam tempor lacus dictum urna consequat, vel ultrices nibh semper. Sed laoreet arcu non mi varius, quis imperdiet libero tempor. Nullam tristique diam nec ultricies sagittis. Ut nisl nunc, rutrum non sodales vitae, efficitur sed ligula. Curabitur in eros non lacus auctor placerat fringilla nec massa. Proin euismod mattis laoreet. Aliquam non mollis ante. Pellentesque nec augue leo. Integer eget arcu dignissim, fringilla ante quis, porttitor odio. Sed at posuere erat, vel accumsan mi. Morbi sit amet pretium quam. Sed pretium vehicula enim sit amet venenatis. Cras placerat, odio eget mattis congue, ligula erat posuere erat, id blandit nibh sapien id eros. Ut eget diam neque. Sed auctor imperdiet mi, quis finibus enim sollicitudin in. Quisque vel sodales arcu, ac posuere urna. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nam nec dolor sapien. Donec sed ante nec ex lacinia scelerisque. Nullam vitae nisl nisi. Integer vel blandit enim. Phasellus consectetur dui non efficitur tincidunt. Pellentesque a enim nec sapien egestas auctor eu accumsan est. Sed at ante leo. Nam hendrerit sollicitudin nunc, ac elementum nulla aliquam ac. Nunc rutrum ultrices mauris a lacinia. Donec tempus pulvinar convallis. Integer varius sapien aliquam diam ullamcorper malesuada. Integer pharetra congue pellentesque. Ut pellentesque, lacus sed elementum dictum, odio ante faucibus velit, luctus blandit lorem elit id elit. Maecenas consectetur purus nulla, ut ultricies leo vehicula quis. Ut ut eros ut neque pulvinar ultrices a id tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla blandit augue vel diam bibendum pretium. Vestibulum vitae iaculis tellus. Mauris nec malesuada magna, sit amet lacinia eros. Proin condimentum erat eros, et dapibus mi aliquam quis. Vestibulum quis lacus imperdiet, convallis arcu vel, suscipit massa. Mauris faucibus consectetur justo sed laoreet. Pellentesque mollis enim ac ligula varius, non gravida sem pulvinar. In cursus tincidunt arcu. Etiam vitae fermentum sem. Curabitur id iaculis tellus, ac ornare massa. Donec sapien magna, malesuada sit amet ornare et, finibus nec lacus. Curabitur mollis efficitur auctor. Fusce nunc risus, efficitur ac condimentum ut, congue sit amet massa. Maecenas blandit finibus porttitor. Vivamus tristique tortor nisl, at lacinia erat aliquam eget. Vivamus fringilla sollicitudin nulla non consequat. Integer eu finibus magna. Etiam porttitor purus id est congue, vel mollis sem auctor.";
    [self UI];
}

- (void)UI {
    [[self navigationItem] setTitle:@"termsAndConditions"];
    UIView *bgview = [self UIView:self withFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-60)];
    [[bgview layer] setCornerRadius:10];
    
    txt = [[UITextView alloc] initWithFrame:CGRectMake(20, 0, self.view.frame.size.width-40, self.view.frame.size.height-120)];
    txt.attributedText = [[NSAttributedString alloc]
                                     initWithData: [datatnc dataUsingEncoding:NSUTF8StringEncoding]
                                     options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                     documentAttributes: nil
                                     error: nil];
    txt.textColor = [self colorFromHexString:@"#666666" withAlpha:1.0];
    txt.textAlignment = NSTextAlignmentJustified;
    txt.font = [UIFont systemFontOfSize:14];
    txt.backgroundColor = [UIColor clearColor];
    txt.showsVerticalScrollIndicator = NO;
    txt.editable = NO;
    txt.delegate = self;
    [bgview addSubview:txt];
    [[self view] addSubview:bgview];
    
    Footer = [[UIView alloc] initWithFrame:CGRectMake(0, [self view].frame.size.height-50, [self view].frame.size.width, 50)];
    Footer.backgroundColor = [self colorFromHexString:Color0 withAlpha:1.0];
    
    UIView *separator = [self UIView:self withFrame:CGRectMake(0, 0, [self view].frame.size.width, 1)];
    [separator setBackgroundColor:[self colorFromHexString:Color4 withAlpha:0.2]];
    [Footer addSubview:separator];
    DG = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, [[defaults objectForKey:@"language"] isEqualToString:@"en"] ? 100 : 150, 50)];
    [DG setTitle:@"disagree" forState:UIControlStateNormal];
    [DG setTitleColor:[self colorFromHexString:Color4 withAlpha:0.5] forState:UIControlStateNormal];
    [DG addTarget:self action:@selector(Act:) forControlEvents:UIControlEventTouchUpInside];
    [DG setBackgroundColor:[UIColor clearColor]];
    [DG setTag:0];
    [Footer addSubview:DG];
    
    AG = [[UIButton alloc] initWithFrame:CGRectMake(Footer.frame.size.width-100, 0, 100, 50)];
    [AG setTitle:@"agree" forState:UIControlStateNormal];
    [AG addTarget:self action:@selector(Act:) forControlEvents:UIControlEventTouchUpInside];
    [AG setBackgroundColor:[UIColor clearColor]];
    [AG setTag:1];
    
    if (txt.contentSize.height+10 > txt.frame.size.height) {
        [AG setEnabled:NO];
        [AG setTitleColor:[self colorFromHexString:Color4 withAlpha:0.5] forState:UIControlStateNormal];
    } else {
        [AG setEnabled:YES];
        [AG setTitleColor:[self colorFromHexString:Color3 withAlpha:1.0] forState:UIControlStateNormal];
    }
    [Footer addSubview:AG];
    
    if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"Settings"])
    {
        [defaults removeObjectForKey:@"ViewController"];
        txt.frame = CGRectMake(20, 0, self.view.frame.size.width-40, self.view.frame.size.height-80);
    }
    else
    {
        [[self view] addSubview:Footer];
    }
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
    else
    if ([sender tag] == 1)
    {
        [self showAlert2:@"popUpSendSmsDesc" title:@"popUpSendSmsTitle" btn1:@"cancel" btn2:@"ok" tag:1 delegate:self];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) {
        if(buttonIndex == 1)
        {
//            [self RequestAPIAgreeTncRegister];
        }
    }
}

- (void)showSMS:(NSString*)file {
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = @[@"smsNo"];
    NSString *message = [NSString stringWithFormat:@"smsMsg", file];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
        {
            break;
        }
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
        case MessageComposeResultSent:
        {
//            [self RequestAPIGetMobileNoCustomer];
            break;
        }
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Register"]) {
        Register *NVC = [segue destinationViewController];
        NVC.SQdata = response;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scView {
    if (scView.contentOffset.y >= scView.contentSize.height - scView.frame.size.height) {
        [AG setTitleColor:[self colorFromHexString:@"#047FDB" withAlpha:1.0] forState:UIControlStateNormal];
        [AG setEnabled:YES];
    }
}

#pragma Request API
//-(void)RequestAPIGetTermsAndCondition {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetTermsAndCondition" withParams:nil];
////        NSLog(@"Get TermsCondition = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                datatnc = [[response objectForKey:@"params"] objectForKey:@"tnc"];
////                [defaults setObject:datatnc forKey:@"tnc"];
//                [self UI];
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

//-(void)RequestAPIGetSecurityQuestion {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetSecurityQuestion" withParams:nil];
////        NSLog(@"SQ = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self performSegueWithIdentifier:@"Register" sender:self];
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

//-(void)RequestAPIGetMobileNoCustomer {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetMobileNoCustomer" withParams:nil];
////        NSLog(@"Get MobileNo Customer = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults removeObjectForKey:@"MobileNumber"];
//                [defaults setObject:[[response objectForKey:@"params"] objectForKey:@"mobileNumber"] forKey:@"MobileNumber"];
//                [self RequestAPIGetSecurityQuestion];
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

//-(void)RequestAPIAgreeTncRegister {
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"AgreeTncRegister" withParams:nil];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self showSMS:DEVICEID];
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
