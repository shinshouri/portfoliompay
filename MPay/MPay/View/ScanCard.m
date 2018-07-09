//
//  ScanCard.m
//  MPay
//
//  Created by Admin on 7/25/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ScanCard.h"
#import <AVFoundation/AVFoundation.h>

@implementation ScanCard
{
    UIButton *btn;
    NSString *CNumber, *CMonth, *CYear;
//    CardIOView *cardIOView;
    UILabel *lbl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"scanCard"];
//    [self navigationController].navigationBar.barStyle = UIBarStyleBlackOpaque;
    [bgimage setImage:[UIImage imageNamed:@"bgwhite.png"]];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[self colorFromHexString:Color0 withAlpha:1.0]}];
//    [[[self navigationController] navigationBar] setTintColor:[self colorFromHexString:Color0 withAlpha:1.0]];
    
    UIImage *myImage = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"Close.png"]];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithImage:myImage style:UIBarButtonItemStylePlain target:self action:@selector(BackBtn)];
    self.navigationItem.leftBarButtonItem=newBackButton;
    
    [lbl setHidden:NO];
    [btn setTitle:[@"enterCardManually" uppercaseString] forState:UIControlStateNormal];
    
    [defaults removeObjectForKey:@"QRCardNumber"];
    [defaults removeObjectForKey:@"QRCardExpiryMonth"];
    [defaults removeObjectForKey:@"QRCardExpiryYear"];
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        // do your logic
        [self UI];
    } else if(authStatus == AVAuthorizationStatusDenied){
        // denied
        btn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, [self view].frame.size.height-50, self.view.frame.size.width-(btnmarginleft*2), 40) withTitle:[@"enterCardManually" uppercaseString] withTag:0];
        [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
//        [btn setTitleColor:[self colorFromHexString:Color1 withAlpha:1.0] forState:UIControlStateNormal];
        [[btn titleLabel] setFont:[UIFont systemFontOfSize:[self view].frame.size.height > 568 ? 18 : 14]];
//        [[btn layer] setBorderWidth:1.0f];
//        [[btn layer] setBorderColor:[self colorFromHexString:Color1 withAlpha:1.0].CGColor];
        [[self view] addSubview:btn];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
//    [cardIOView removeFromSuperview];
    [btn removeFromSuperview];
    [self navigationController].navigationBar.barStyle = UIBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)dealloc {
    
}

-(void)BackBtn {
    [[self navigationController] popViewControllerAnimated:YES];
//    [self performSegueWithIdentifier:@"UnwindToHome" sender:self];
}

- (void)UI {
//    [cardIOView removeFromSuperview];
    [btn removeFromSuperview];
    
//    cardIOView = [[CardIOView alloc] initWithFrame:CGRectMake(0, 20, [self view].frame.size.width, [self view].frame.size.height-60)];
//    [cardIOView setDelegate:self];
//    [cardIOView setHideCardIOLogo:YES];
//    [[self view] addSubview:cardIOView];
    
    lbl = [self UILabel:self withFrame:CGRectMake(10, ([self view].frame.size.height/2)-40, self.view.frame.size.width-20, 40) withText:@"placeYourCardHere" withTextSize:20 withAlignment:1 withLines:0];
    [lbl setTextColor:[self colorFromHexString:@"#AFED44" withAlpha:1.0]];
    [[self view] addSubview:lbl];
    
    btn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, [self view].frame.size.height-([self view].frame.size.height/9), self.view.frame.size.width-(btnmarginleft*2), btnheight) withTitle:[@"enterCardManually" uppercaseString] withTag:0];
    [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
//    [btn setTitleColor:[self colorFromHexString:Color1 withAlpha:1.0] forState:UIControlStateNormal];
    [[btn titleLabel] setFont:[UIFont systemFontOfSize:[self view].frame.size.height > 568 ? 18 : 14]];
//    [[btn layer] setBorderWidth:1.0f];
//    [[btn layer] setBorderColor:[self colorFromHexString:Color1 withAlpha:1.0].CGColor];
    [[self view] addSubview:btn];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        [self performSegueWithIdentifier:@"AddCard" sender:self];
//        [self.navigationController popViewControllerAnimated:NO];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@""]) {
        
    }
}

-(void)cardIOView:(CardIOView *)cardIOView didScanCard:(CardIOCreditCardInfo *)cardInfo {
    CNumber = cardInfo.cardNumber;
    if (cardInfo.expiryMonth > 9) {
        CMonth = [NSString stringWithFormat:@"%li", (unsigned long)cardInfo.expiryMonth];
    }
    else {
        CMonth = [NSString stringWithFormat:@"0%li", (unsigned long)cardInfo.expiryMonth];
    }
    CYear = [NSString stringWithFormat:@"%li", (unsigned long)cardInfo.expiryYear];
    
    [defaults setValue:CNumber forKey:@"QRCardNumber"];
    [defaults setValue:CMonth forKey:@"QRCardExpiryMonth"];
    [defaults setValue:CYear forKey:@"QRCardExpiryYear"];
    
    [lbl setHidden:YES];
    [btn setTitle:@"next" forState:UIControlStateNormal];
}
@end
