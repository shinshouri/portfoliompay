//
//  DetailTransaction.m
//  MPay
//
//  Created by Admin on 7/13/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "DetailTransaction.h"
#import "Wallet.h"
#import "PushPassword.h"

@implementation DetailTransaction
{
    UIView *view;
}
@synthesize Response, CardSelect, RefNo, CardNumberTrx, AmtTrx;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
}

-(void)viewWillDisappear:(BOOL)animated {
    [bgimage setImage:[UIImage imageNamed:@"bgwhite.png"]];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"HomeClick" object:nil];
}

-(void)ToBackground {
    UIViewController *ac = [self presentedViewController];
    if (ac != nil) {
        [ac dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)UI {
    UIView *bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self view].frame.size.width, [self view].frame.size.height)];
    [bg setBackgroundColor:[UIColor clearColor]];
    [[self view] addSubview:bg];
    
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self view].frame.size.width, [self view].frame.size.height/4)];
    [top setBackgroundColor:[UIColor clearColor]];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(10, 120, [self view].frame.size.width-20, [self view].frame.size.height-180)];
    [view setBackgroundColor:[UIColor whiteColor]];
    [[view layer] setBorderWidth:0];
    [[view layer] setBorderColor:[UIColor blackColor].CGColor];
    [[view layer] setShadowOffset:CGSizeMake(3, 3)];
    [[view layer] setShadowColor:[UIColor blackColor].CGColor];
    [[view layer] setShadowRadius:3];
    [[view layer] setShadowOpacity:0.5];
    
    int f = [self view].frame.size.height/28;
    
    if([[defaults objectForKey:@"ViewController"] isEqualToString:@"PaymentReceipt"])
    {
        UILabel *line = [self UILabel:self withFrame:CGRectMake(0, (view.frame.size.height/8)+65, view.frame.size.width, 20) withText:@"------------------------------------------------------------------------------------------------------------" withTextSize:12 withAlignment:1 withLines:1];
        [view addSubview:line];
//        UILabel *lbl = [self UILabelwithBlackText:self withFrame:CGRectMake([[defaults objectForKey:@"language"] isEqualToString:@"id"] ? (view.frame.size.width/2)-70 : (view.frame.size.width/2)-90, (view.frame.size.height/8)+65, [[defaults objectForKey:@"language"] isEqualToString:@"id"] ? 140 : 180, 20) withText:L(@"transactionSuccess") withTextSize:14 withAlignment:1 withLines:0];
//        [[lbl layer] setBackgroundColor:[UIColor whiteColor].CGColor];
//        [view addSubview:lbl];
        UILabel *lbl = [self UILabel:self withFrame:CGRectMake(0, 60, top.frame.size.width, 20) withText:@"transactionSuccess" withTextSize:16 withAlignment:1 withLines:0];
        [lbl setTextColor:[UIColor grayColor]];
        [top addSubview:lbl];
        [top addSubview:[self UILabel:self withFrame:CGRectMake(0, 80, top.frame.size.width, 20) withText:@"thankYou" withTextSize:28 withAlignment:1 withLines:0]];
        
        UILabel *line1 = [self UILabel:self withFrame:CGRectMake(0, view.frame.size.height-60, view.frame.size.width, 20) withText:@"-----------------------------------------------------------------------------------------------------" withTextSize:12 withAlignment:1 withLines:1];
        [view addSubview:line1];
        
        UIButton *done = [self UIButton:self withFrame:CGRectMake(0, view.frame.size.height-50, view.frame.size.width, 50) withTitle:[@"close" uppercaseString] withTag:0];
        [done setTitleColor:[self colorFromHexString:Color3 withAlpha:1.0] forState:UIControlStateNormal];
        [view addSubview:done];
    }
    else
    {
        UILabel *line = [self UILabel:self withFrame:CGRectMake(0, (view.frame.size.height/8)+65, view.frame.size.width, 20) withText:@"------------------------------------------------------------------------------------------------------------" withTextSize:12 withAlignment:1 withLines:1];
        [view addSubview:line];
        [[self navigationItem] setTitle:@"detailTransactionHistory"];
        
        f = [self view].frame.size.height/25;
    }
    [[self view] addSubview:top];
    
    [view addSubview:[self UIImage:self withFrame:CGRectMake((view.bounds.size.width/2)-((view.bounds.size.width/3)/2), 20, view.bounds.size.width/3, view.frame.size.height/14) withImageName:@"logoreceipt.png"]];
    
    [view addSubview:[self UILabel:self withFrame:CGRectMake(10, (view.frame.size.height/8)+20, view.frame.size.width-20, 20) withText:[NSString stringWithFormat:@"trxRef", [Response objectForKey:@"referenceNoTrx"]] withTextSize:[self view].frame.size.height > 568 ? 14 : 12 withAlignment:1 withLines:0]];
    [view addSubview:[self UILabel:self withFrame:CGRectMake(10, (view.frame.size.height/8)+40, view.frame.size.width-20, 20) withText:[NSString stringWithFormat:@"time", [Response objectForKey:@"dateTimeTrx"]] withTextSize:[self view].frame.size.height > 568 ? 14 : 12 withAlignment:1 withLines:0]];
    
    [view addSubview:[self UILabel:self withFrame:CGRectMake(10, f*7, view.frame.size.width-20, 20) withText:@"merchantId" withTextSize:[self view].frame.size.height > 568 ? 14 : 12 withAlignment:0 withLines:0]];
    [view addSubview:[self UILabelwithBlackText:self withFrame:CGRectMake(10, f*7, view.frame.size.width-20, 20) withText:[Response objectForKey:@"merchantNameTrx"] withTextSize:[self view].frame.size.height > 568 ? 14 : 12 withAlignment:2 withLines:0]];
    
    [view addSubview:[self UILabel:self withFrame:CGRectMake(10, f*9.5, (view.frame.size.width-20)/2, 20) withText:@"paymentMethod" withTextSize:[self view].frame.size.height > 568 ? 14 : 12 withAlignment:0 withLines:0]];
    [view addSubview:[self UILabelwithBlackText:self withFrame:CGRectMake(10, f*9.5, view.frame.size.width-20, 20) withText:[Response objectForKey:@"paymentMethodNameTrx"] withTextSize:[self view].frame.size.height > 568 ? 14 : 12 withAlignment:2 withLines:0]];
    
    [view addSubview:[self UILabel:self withFrame:CGRectMake(10, f*12, view.frame.size.width-20, 20) withText:@"cardNumber" withTextSize:[self view].frame.size.height > 568 ? 14 : 12 withAlignment:0 withLines:0]];
    [view addSubview:[self UILabelwithBlackText:self withFrame:CGRectMake(10, f*12, view.frame.size.width-20, 20) withText:[NSString stringWithFormat:@"%@", CardNumberTrx] withTextSize:[self view].frame.size.height > 568 ? 14 : 12 withAlignment:2 withLines:0]];
    
    [view addSubview:[self UILabel:self withFrame:CGRectMake(10, f*14.5, view.frame.size.width-20, 20) withText:@"receiptNumber" withTextSize:[self view].frame.size.height > 568 ? 14 : 12 withAlignment:0 withLines:0]];
    [view addSubview:[self UILabelwithBlackText:self withFrame:CGRectMake(10, f*14.5, view.frame.size.width-20, 20) withText:RefNo withTextSize:[self view].frame.size.height > 568 ? 14 : 12 withAlignment:2 withLines:0]];
    
    [view addSubview:[self UILabel:self withFrame:CGRectMake(10, f*17, (view.frame.size.width-20)/2, 20) withText:@"amount" withTextSize:[self view].frame.size.height > 568 ? 14 : 12 withAlignment:0 withLines:0]];
    UILabel *amountlabel = [self UILabelwithBlackText:self withFrame:CGRectMake(10, f*17, view.frame.size.width-20, 20) withText:[NSString stringWithFormat:@"%@%@", [[defaults objectForKey:@"language"] isEqualToString:@"id"] ? @"Rp" : @"IDR", [self FormatNumber:self from:AmtTrx]] withTextSize:[self view].frame.size.height > 568 ? 18 : 16 withAlignment:2 withLines:0];
    [view addSubview:amountlabel];
    if ([[Response objectForKey:@"isVoid"] isEqualToString:@"Y"]) {
        UILabel *voidLabel =[[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width-amountlabel.intrinsicContentSize.width-10, amountlabel.frame.origin.y-10, amountlabel.intrinsicContentSize.width, 10)];
        voidLabel.textColor = [UIColor redColor];
        voidLabel.textAlignment = NSTextAlignmentRight;
        voidLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        voidLabel.text = @"void";
        [view addSubview:voidLabel];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(view.frame.size.width-amountlabel.intrinsicContentSize.width-10, amountlabel.frame.origin.y+(amountlabel.frame.size.height/2), amountlabel.intrinsicContentSize.width, 1)];
        line.backgroundColor = [UIColor redColor];
        [view addSubview:line];
    }
    
    [[self view] addSubview:view];
    
    UIButton *btn = [self UIButton:self withFrame:CGRectMake(([self view].frame.size.width/2)-20, [self view].frame.size.height-50, 25, 25) withTitle:@"" withTag:1];
    [btn setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"share.png"]] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    [[self view] addSubview:btn];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"PaymentReceipt"]) {
            [defaults removeObjectForKey:@"ViewController"];
            if ([[defaults objectForKey:@"FromPush"] isEqualToString:@"YES"]) {
                [defaults setObject:@"Cancel" forKey:@"FromPush"];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                PushPassword *myVC = (PushPassword *)[storyboard instantiateViewControllerWithIdentifier:@"PushPassword"];
                [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                [[self topViewController] presentViewController:myVC animated:NO completion:nil];
            } else {
                [defaults removeObjectForKey:@"FromPush"];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                Wallet *myVC = (Wallet *)[storyboard instantiateViewControllerWithIdentifier:@"RootHome"];
                [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                [[self topViewController] presentViewController:myVC animated:NO completion:nil];
            }
        } else {
            [defaults removeObjectForKey:@"ViewController"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if([sender tag] == 1)
    {
        [[self view] addSubview:[self showmask]];
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.frame.size.width, view.frame.size.height-50),YES,0.0f);
//            CGContextRef context = UIGraphicsGetCurrentContext();
//            [view.layer renderInContext:context];
//            UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [maskView removeFromSuperview];
//                //Pilih share salah satu saja antara text atau image
//                [PCUtils shareText:@"" andImage:capturedImage andViewController:self];
//                [[NSNotificationCenter defaultCenter] removeObserver:self name:@"HomeClick" object:nil];
//                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ToBackground) name:@"HomeClick" object:nil];
//            });
//        });
        
//        UIImageWriteToSavedPhotosAlbum(capturedImage, NULL, NULL, NULL);
    }
}

@end
