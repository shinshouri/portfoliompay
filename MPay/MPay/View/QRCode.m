//
//  QRCode.m
//  MPay
//
//  Created by Admin on 7/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "QRCode.h"
#import "PaymentDetail.h"
#import "Login.h"
#import <AVFoundation/AVFoundation.h>

@implementation QRCode
{
//    PCScan *PrimeScan;
    NSString *QRString;
    NSDictionary *data;
    UIView *viewscan;
    UILabel *label;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [self navigationController].navigationBar.barStyle = UIBarStyleDefault;
    [bgimage setImage:[UIImage imageNamed:@"bgwhite.png"]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[self colorFromHexString:Color1 withAlpha:1.0]}];
    [[[self navigationController] navigationBar] setTintColor:[self colorFromHexString:Color1 withAlpha:1.0]];
    
    [[self tabBarController] setTitle:@"qrCode"];
    [[[self tabBarController] tabBar] setBackgroundColor:[self colorFromHexString:Color0 withAlpha:1.0]];
    [[[[self tabBarController] tabBar] layer] setBorderWidth:1.0];
    [[[[self tabBarController] tabBar] layer] setBorderColor:[self colorFromHexString:Color4 withAlpha:0.5].CGColor];
    [[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:@"wallet"];
    UIImage *icon1 = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"wallet.png"]];
//    icon1 = [icon1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[self.tabBarController.tabBar.items objectAtIndex:0] setImage:icon1];
    [[self.tabBarController.tabBar.items objectAtIndex:1] setTitle:@"scanQr"];
    UIImage *icon2 = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"scan.png"]];
//    icon2 = [icon2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[self.tabBarController.tabBar.items objectAtIndex:1] setImage:icon2];
    [[self.tabBarController.tabBar.items objectAtIndex:2] setTitle:@"settings"];
    UIImage *icon3 = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"setting.png"]];
//    icon3 = [icon3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[self.tabBarController.tabBar.items objectAtIndex:2] setImage:icon3];
    [[[self tabBarController] tabBar] setTintColor:[self colorFromHexString:Color10 withAlpha:1.0]];
    
    [[[self navigationController] navigationBar] setBarTintColor:[self colorFromHexString:@"#17C87E" withAlpha:1.0]];
    UIBarButtonItem * addButton = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:nil];
    [self tabBarController].navigationItem.rightBarButtonItem = addButton;
}

-(void)viewDidAppear:(BOOL)animated {
    [self StartScan];
}

-(void)viewDidDisappear:(BOOL)animated {
    [viewscan removeFromSuperview];
    [label removeFromSuperview];
}

- (void)UI {
    [viewscan removeFromSuperview];
    [label removeFromSuperview];
//    PrimeScan = [[PCScan alloc] init];
//    PrimeScan.delegate=self;
//    viewscan = [[UIView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, [self view].frame.size.height-100)];
//    viewscan.backgroundColor = [UIColor clearColor];
//    [viewscan addSubview:[PrimeScan showScanner]];
//    [[self view] addSubview:viewscan];
    
    label = [self UILabelwithWhiteText:self withFrame:CGRectMake([self view].frame.size.width/2-([self view].frame.size.width/4), ([self view].frame.size.height/2)-40, [self view].frame.size.width/2, 100) withText:@"placeQRCodeHere" withTextSize:textsize16 withAlignment:1 withLines:0];
    [label setTextColor:[self colorFromHexString:@"#AFED44" withAlpha:1.0]];
    [[self view] addSubview:label];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        
    }
}

-(void)StartScan {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        //do your logic
        [self UI];
    } else if(authStatus == AVAuthorizationStatusDenied){
        // denied
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) {
        if(buttonIndex == 0)
        {
            [self StartScan];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ScanQR"]) {
        
    }
}

-(void)scanCompleted:(NSString *)value {
//    [PrimeScan stopScanner];
    [viewscan removeFromSuperview];
    [label removeFromSuperview];
    NSData *dt = [value dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:dt options:0 error:nil];
    data = [json mutableCopy];
    
    if ([value length] >= 11)
    {
        if ([[value substringToIndex:11] isEqualToString:@"00020101021"] && [[value substringWithRange:NSMakeRange([value length]-8, 4)] isEqualToString:@"6304"])
        {
            QRString = value;
//            [self RequestAPIGetDetailTransactionQR];
            [self performSegueWithIdentifier:@"ScanQR" sender:self];
        }
        else
        {
            [self showAlert:@"invalidQrCode" title:@"message" btn:@"ok" tag:1 delegate:self];
        }
    }
    else
    {
        [self showAlert:@"invalidQrCode" title:@"message" btn:@"ok" tag:1 delegate:self];
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:NO completion:nil];
}

//-(void)RequestAPIGetDetailTransactionQR {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"GetDetailTransactionQR" withParams:[NSDictionary dictionaryWithObjectsAndKeys:QRString, @"qrCodeString", nil]];
//        //        NSLog(@"Detail Transaction = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:1 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                GlobalVariable *GV = [GlobalVariable sharedInstance];
//                GV.DATA = [[response objectForKey:@"params"] mutableCopy];
//                [self performSegueWithIdentifier:@"ScanQR" sender:self];
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
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:1 delegate:self];
//                } else if ([[response objectForKey:@"message"] containsString:@"||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:1 delegate:self];
//                } else {
//                    [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"ok") tag:1 delegate:self];
//                }
//            }
//        });
//    });
//}

@end
