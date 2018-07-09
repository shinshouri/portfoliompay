//
//  ChangeEmail.m
//  MPay
//
//  Created by Admin on 7/27/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ChangeEmail.h"
#import "Login.h"

@implementation ChangeEmail
{
    UITextField *email;
    UIButton *save;
}
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationItem] setTitle:@"email"];
    [self UI];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(BackBtn)];
    [newBackButton setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"back.png"]]];
    self.navigationItem.leftBarButtonItem=newBackButton;
}

-(void)BackBtn {
    [self performSegueWithIdentifier:@"UnwindToAccAndSecurity" sender:self];
}

- (void)UI {
    UIView *bgview = [self UIView:self withFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-70)];
    [[bgview layer] setCornerRadius:10];
    
    [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, [self view].frame.size.height/20, bgview.bounds.size.width-40, 50) withText:@"setNewEmail" withTextSize:textsize16 withAlignment:0 withLines:0]];
    
    email = [self TextFieldWithButton:CGRectMake(20, ([self view].frame.size.height/20)*3, bgview.frame.size.width - 90, 40) withPaddingWidth:(self.view.frame.size.width - 40) withStrPlcHolder:@"email" withAttrColor:nil keyboardType:UIKeyboardTypeEmailAddress withTextColor:nil withFontSize:16 withTag:0 withDelegate:self];
    [bgview addSubview:email];
    
    UIButton *btn = [self btnText:CGRectMake(bgview.frame.size.width - 80, email.frame.origin.y + 10, 60, 20) withTag:0 withTitle:@"resend" withFontSize:12 withColor:@"#0000FF"];
    [bgview addSubview:btn];
    
    save = [self UIButton:self withFrame:CGRectMake(btnmarginleft, ([self view].frame.size.height/2)-50, bgview.frame.size.width-(btnmarginleft*2), btnheight) withTitle:[@"save" uppercaseString] withTag:1];
    [save setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    [save setEnabled:NO];
    [bgview addSubview:save];
    
    [[self view] addSubview:bgview];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    if(newLength > 0){
        [self removeValidationTextFieldWithButton:email withColor:nil withPaddingWidth:(email.frame.size.width + 50)];
        [save setEnabled:YES];
        [save setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
    } else {
        [save setEnabled:NO];
        [save setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    }
    
    return true;
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        if ([[email text] length] > 0 && ([self IsValidEmail:[email text]])) {
            [self showAlert2:@"popUpResendEmailDesc" title:@"message" btn1:@"cancel" btn2:@"send" tag:2 delegate:self];
        }
    } else
    if([sender tag] == 1)
    {
        if ([[email text] length] > 0 && ([self IsValidEmail:[email text]])) {
//            [self RequestAPIChangeEmail];
            [defaults setObject:@"ChangeEmail" forKey:@"Change"];
            [self performSegueWithIdentifier:@"UnwindToAccAndSecurity" sender:self];
        }else{
            if([[email text] length]  > 0 && ![self IsValidEmail:[email text]])
                [self requiredTextFieldWithButton:email withMsg:@"invalidEmailAddress" withPaddingWidth:(email.frame.size.width + 50)];
            
            if([[email text] length] == 0)
               [self requiredTextFieldWithButton:email withMsg:nil withPaddingWidth:(email.frame.size.width + 50)];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 2) {
        if(buttonIndex == 1)
        {
//            [self RequestAPIChangeEmail];
        }
    }
}

//-(void)RequestAPIGetEmail {
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"GetEmail" withParams:nil];
////        NSLog(@"GetEmail = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self RequestAPIChangeEmail];
//            }
//            else if([[response objectForKey:@"logout"] intValue] == 1)
//            {
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

//-(void)RequestAPIChangeEmail {
//    [[self view] endEditing:YES];
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"ChangeEmail" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[email text], @"newEmailAddress", nil]];
////        NSLog(@"ChangeEmail = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults setObject:@"ChangeEmail" forKey:@"Change"];
//                [self performSegueWithIdentifier:@"UnwindToAccAndSecurity" sender:self];
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

@end
