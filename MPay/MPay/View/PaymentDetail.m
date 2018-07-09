//
//  PaymentDetail.m
//  MPay
//
//  Created by Admin on 7/22/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "PaymentDetail.h"
#import "PushPIN.h"
#import "Login.h"
#import "Wallet.h"
#import "DetailTransaction.h"
#import "PushPassword.h"
#import "CustomPIN.h"

@implementation PaymentDetail
{
    UIView *view, *viewaddamt;
    UITextField *amt;
    UIButton *done;
    UILabel *amtlbl, *cur, *addamtlbl;
    NSString *exc, *res, *CNo, *AmtVal, *StAmt;
    NSInteger cardflag;
    int lebarkartu, tinggikartu, y, h, w, n;
}
@synthesize scrollView, pageControl, table, CardList, data;

- (void)viewDidLoad {
    [super viewDidLoad];
    [defaults removeObjectForKey:@"Background"];
    lebarkartu = (self.view.frame.size.width/2);
    tinggikartu = 0;
    AmtVal = @"";
    
    if ([[self QsCFtGbHyUJSdaWE] isEqualToString:@"X1UaSDpOwQe0nf4"]) {
        GlobalVariable *GV = [GlobalVariable sharedInstance];
        data = [GV.DATA mutableCopy];
        GV.DATA = nil;
        if ([[data objectForKey:@"pointOfInitiationMethod"] isEqualToString:@"11"] || [[data objectForKey:@"pointOfInitiationMethod"] isEqualToString:@"12"]) {
            //        NSLog(@"NON PUSH");
            CardList = [data objectForKey:@"sourceOfFundList"];
            [self UI];
        } else {
            //        NSLog(@"PUSH");
            NSString *OJS = [NSString stringWithFormat:@"%@", [[defaults dictionaryForKey:@"UserInfo"] objectForKey:@"params"]];
            NSData *ODT = [OJS dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *usr = [NSJSONSerialization JSONObjectWithData:ODT options:NSJSONReadingMutableLeaves error:nil];
            data = [usr mutableCopy];
            [defaults removeObjectForKey:@"UserInfoParams"];
            [defaults removeObjectForKey:@"UserInfo"];
            [defaults setObject:@"YES" forKey:@"FromPush"];
//            [self RequestAPIGetDetailTransaction];
        }
    } else {
        [self showAlert:@"rootMsg" title:@"rootTitle" btn:@"ok" tag:0 delegate:self];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"payment"];
//    [self navigationController].navigationBar.barStyle = UIBarStyleBlackOpaque;
    [bgimage setImage:[UIImage imageNamed:@"bgwhite.png"]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[self colorFromHexString:Color1 withAlpha:1.0]}];
    [[[self navigationController] navigationBar] setTintColor:[self colorFromHexString:Color1 withAlpha:1.0]];
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(BackBtn)];
    [newBackButton setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"Close.png"]]];
    self.navigationItem.leftBarButtonItem=newBackButton;
    
    if ([StAmt isEqualToString:@"Amt"]) {
        [amt becomeFirstResponder];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
//    [self navigationController].navigationBar.barStyle = UIBarStyleDefault;
}

-(void)BackBtn {
    [self showAlert2:@"popUpCancelPayment" title:@"popUpCancelPaymentTitle" btn1:@"no" btn2:@"yes" tag:3 delegate:self];
}

- (void)UI {
    CGFloat contentOffset = 0.0f;
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 80, self.view.frame.size.width-60, lebarkartu)];
    scrollView.contentSize = CGSizeMake((self.view.frame.size.width) * [CardList count], (self.view.frame.size.height/10)*3);
    scrollView.showsHorizontalScrollIndicator = NO;
    [scrollView setClipsToBounds:NO];
    [scrollView setPagingEnabled:YES];
    [scrollView setDelegate:self];
    [scrollView setTag:1];
    
    for (int i = 1; i <= [CardList count]; i++) {
        if ([[[CardList objectAtIndex:i-1] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
            [scrollView addSubview:[self ECardAssets:self withFrame:CGRectMake(contentOffset, 0, scrollView.frame.size.width-20, lebarkartu) withImage:[NSString stringWithFormat:@"%@.png",[[CardList objectAtIndex:i-1] objectForKey:@"cardType"]] withBalance:[[CardList objectAtIndex:i-1] objectForKey:@"cardBalance"] withCardNumber:[[CardList objectAtIndex:i-1] objectForKey:@"cardNumberMasking"] withCardType:[[CardList objectAtIndex:i-1] objectForKey:@"cardType"] withTag:i]];
        } else {
            [scrollView addSubview:[self CardAssets:self withFrame:CGRectMake(contentOffset, 0, scrollView.frame.size.width-20, lebarkartu) withImage:[NSString stringWithFormat:@"%@.png",[[CardList objectAtIndex:i-1] objectForKey:@"cardType"]] withBalance:[[CardList objectAtIndex:i-1] objectForKey:@"cardBalance"] withCardNumber:[[CardList objectAtIndex:i-1] objectForKey:@"cardNumberMasking"] withCardExp:[[CardList objectAtIndex:i-1] objectForKey:@"cardExp"] withCardType:[[CardList objectAtIndex:i-1] objectForKey:@"cardType"] withTag:i]];
        }
        
        contentOffset += scrollView.frame.size.width;
        scrollView.contentSize = CGSizeMake(contentOffset, lebarkartu);
        
        if ([[[CardList objectAtIndex:i-1] objectForKey:@"isDefault"] isEqualToString:@"Y"]) {
            cardflag = i-1;
        }
    }
    
    [[self view] addSubview:scrollView];
    //SET a property of UIPageControl
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(20,lebarkartu+95,self.view.frame.size.width-40,20);
    pageControl.numberOfPages = scrollView.contentSize.width/scrollView.frame.size.width;
    pageControl.currentPage = cardflag;
    pageControl.enabled = NO;
    pageControl.transform = CGAffineTransformMakeScale(1.5, 1.5);
    [pageControl setCurrentPageIndicatorTintColor:[self colorFromHexString:Color3 withAlpha:1.0]];
    [pageControl setPageIndicatorTintColor:[self colorFromHexString:Color3 withAlpha:0.3]];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self changePage:self];
    [[self view] addSubview:pageControl];
    
    for(UIView *vw in scrollView.subviews)
    {
        if([vw viewWithTag:pageControl.currentPage+1])
        {
            if ([[[CardList objectAtIndex:pageControl.currentPage] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
                CABasicAnimation *theAnimation1;
                theAnimation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                theAnimation1.duration=1;
                theAnimation1.fillMode=kCAFillModeForwards;
                theAnimation1.fromValue=[NSNumber numberWithFloat:1.0f];
                theAnimation1.toValue=[NSNumber numberWithFloat:1.08f];
                theAnimation1.removedOnCompletion = NO;
                [theAnimation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                theAnimation1.delegate=self;
                [[[vw viewWithTag:pageControl.currentPage+1] layer] addAnimation:theAnimation1 forKey:@"transform.scale"];
            } else {
                CABasicAnimation *theAnimation1;
                theAnimation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                theAnimation1.duration=1;
                theAnimation1.fillMode=kCAFillModeForwards;
                theAnimation1.fromValue=[NSNumber numberWithFloat:1.0f];
                theAnimation1.toValue=[NSNumber numberWithFloat:1.08f];
                theAnimation1.removedOnCompletion = NO;
                [theAnimation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                theAnimation1.delegate=self;
                [[[vw viewWithTag:pageControl.currentPage+1] layer] addAnimation:theAnimation1 forKey:@"transform.scale"];
            }
            //here do your work
        }

        for(UIImageView *iv in scrollView.subviews)
        {
            for (int i = 1; i <= [CardList count]; i++) {
                if([iv tag] == i)
                {
                    [iv setAlpha:0.5];
                }
            }
            if([iv tag] == pageControl.currentPage+1)
            {
                [iv setAlpha:1.0];
            }
        }
    }
    
    view = [self UIView:self withFrame:CGRectMake(0, lebarkartu+120, [self view].frame.size.width, [self view].frame.size.height -(lebarkartu+110))];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view setClipsToBounds:YES];
    
    UIView *headtitle = [self UIView:self withFrame:CGRectMake(0, 0, view.frame.size.width, 30)];
    [headtitle setBackgroundColor:[self colorFromHexString:@"#EEEEEE" withAlpha:1.0]];
    [view addSubview:headtitle];
    
//    UIImageView *content1 = [self UIImage:self withFrame:CGRectMake(10, 10, 20, 20) withImageName:@"transdetail.png"];
////    UIView *content1 = [self UIView:self withFrame:CGRectMake(10, 10, 20, 20)];
////    [content1 setBackgroundColor:[self colorFromHexString:@"#D8D8D8" withAlpha:1.0]];
//    [view addSubview:content1];
    
    int hv = 30;
    int tsize = [self view].frame.size.height > 568 ? 16 : 14;
    int tsizer = [self view].frame.size.height > 568 ? textsize16 : textsize14;
    
    [view addSubview:[self UILabelwithBlackText:self withFrame:CGRectMake(20, 0, view.frame.size.width-40, 30) withText:@"transactionDetail" withTextSize:tsize withAlignment:1 withLines:0]];
    
    [view addSubview:[self UILabel:self withFrame:CGRectMake(10, ([self view].frame.size.height/20)*2, (view.frame.size.width-20)/2, hv) withText:@"merchantId" withTextSize:tsize withAlignment:0 withLines:0]];
    [view addSubview:[self UILabelwithBlackText:self withFrame:CGRectMake(10, ([self view].frame.size.height/20)*2, (view.frame.size.width-20), hv) withText:[data objectForKey:@"merchantNameTrx"] withTextSize:tsizer withAlignment:2 withLines:0]];
    UIView *line1 = [self UIView:self withFrame:CGRectMake(10, ([self view].frame.size.height/20)*3, view.frame.size.width-20, 1)];
    [line1 setBackgroundColor:[self colorFromHexString:Color9 withAlpha:1.0]];
    [view addSubview:line1];
    
    [view addSubview:[self UILabel:self withFrame:CGRectMake(10, ([self view].frame.size.height/20)*3.5, (view.frame.size.width-20)/2, hv) withText:@"paymentMethod" withTextSize:tsize withAlignment:0 withLines:0]];
    [view addSubview:[self UILabelwithBlackText:self withFrame:CGRectMake(10, ([self view].frame.size.height/20)*3.5, view.frame.size.width-20, hv) withText:[data objectForKey:@"paymentMethodNameTrx"] withTextSize:tsizer withAlignment:2 withLines:0]];
    UIView *line2 = [self UIView:self withFrame:CGRectMake(10, ([self view].frame.size.height/20)*4.5, view.frame.size.width-20, 1)];
    [line2 setBackgroundColor:[self colorFromHexString:Color9 withAlpha:1.0]];
    [view addSubview:line2];
    
    [view addSubview:[self UILabel:self withFrame:CGRectMake(10, ([self view].frame.size.height/20)*5, (view.frame.size.width-20)/2, hv) withText:@"receiptNumber" withTextSize:tsize withAlignment:0 withLines:0]];
    [view addSubview:[self UILabelwithBlackText:self withFrame:CGRectMake(10, ([self view].frame.size.height/20)*5, (view.frame.size.width-20), hv) withText:[data objectForKey:@"referenceNoTrx"] withTextSize:tsizer withAlignment:2 withLines:0]];
    UIView *line3 = [self UIView:self withFrame:CGRectMake(10, ([self view].frame.size.height/20)*6, view.frame.size.width-20, 1)];
    [line3 setBackgroundColor:[self colorFromHexString:Color9 withAlpha:1.0]];
    [view addSubview:line3];
    
    UILabel *ttllbl = [self UILabel:self withFrame:CGRectMake(10, ([self view].frame.size.height/20)*6.5, (view.frame.size.width-20)/2, hv) withText:@"amount" withTextSize:[self view].frame.size.height > 568 ? textsize18 : textsize16 withAlignment:0 withLines:0];
    [view addSubview:ttllbl];
    amtlbl = [self UILabelwithBlackText:self withFrame:CGRectMake(10, ([self view].frame.size.height/20)*6.5, (view.frame.size.width-20), hv) withText:[NSString stringWithFormat:@"%@%@", [[defaults objectForKey:@"language"] isEqualToString:@"id"] ? @"Rp" : @"IDR", [self FormatNumber:self from:[data objectForKey:@"totalAmountTrx"]]] withTextSize:[self view].frame.size.height > 568 ? textsize18 : textsize16 withAlignment:2 withLines:0];
    [view addSubview:amtlbl];
    UIView *line4 = [self UIView:self withFrame:CGRectMake(10, ([self view].frame.size.height/20)*7.5, view.frame.size.width-20, 1)];
    [line4 setBackgroundColor:[self colorFromHexString:Color9 withAlpha:1.0]];
    [view addSubview:line4];
    
    if ([[defaults objectForKey:@"Fingerprint"] isEqualToString:@"Y"]) {
//        if ([PCFingerPrint checkTouchIdSupport] && [PCFingerPrint checkTouchIdEnroll]) {
            UIButton *fingerprint = [self UIButton:self withFrame:CGRectMake((view.frame.size.width/4), view.frame.size.height-([self view].frame.size.height/20)*2.5, view.frame.size.width/2, 40) withTitle:[@"confirm" uppercaseString] withTag:101];
            [fingerprint setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
            [fingerprint setTitleColor:[self colorFromHexString:Color0 withAlpha:1.0] forState:UIControlStateNormal];
//            [[fingerprint layer] setBorderWidth:1.0f];
//            [[fingerprint layer] setBorderColor:[self colorFromHexString:Color3 withAlpha:1.0].CGColor];
            [view addSubview:fingerprint];
//        }
    }
    else
    {
        UIButton *btn = [self UIButton:self withFrame:CGRectMake((view.frame.size.width/4), view.frame.size.height-([self view].frame.size.height/20)*2.5, view.frame.size.width/2, 40) withTitle:[@"enterPin" uppercaseString] withTag:102];
        [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        [btn setTitleColor:[self colorFromHexString:Color0 withAlpha:1.0] forState:UIControlStateNormal];
//        [[btn layer] setBorderWidth:1.0f];
//        [[btn layer] setBorderColor:[self colorFromHexString:Color3 withAlpha:1.0].CGColor];
        [view addSubview:btn];
    }
    [[self view] addSubview:view];
    
    if ([[data objectForKey:@"pointOfInitiationMethod"] isEqualToString:@"11"]) {
        [ttllbl setTextColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        UIButton *reamt = [self UIButton:self withFrame:CGRectMake(amtlbl.frame.origin.x, amtlbl.frame.origin.y, amtlbl.frame.size.width, amtlbl.frame.size.height) withTitle:@"" withTag:104];
        [view addSubview:reamt];
        [self Amt];
    }
}

-(void)Amt {
    StAmt = @"Amt";
    y = [self view].frame.size.height > 568 ? 75 : 30;
    h = [self view].frame.size.height > 568 ? [self view].frame.size.height/12 : [self view].frame.size.height/18;
    w = [self view].frame.size.height > 568 ? [self view].frame.size.height/10 : 40;
    n = [self view].frame.size.height > 568 ? 28 : 20;
    
    viewaddamt = [self UIView:self withFrame:CGRectMake(0, lebarkartu+120, [self view].frame.size.width, [self view].frame.size.height -(lebarkartu+110))];
    [viewaddamt setBackgroundColor:[UIColor whiteColor]];
    [viewaddamt setClipsToBounds:YES];
    
    UILabel *hd = [self UILabel:self withFrame:CGRectMake(0, 0, viewaddamt.frame.size.width, [self view].frame.size.height > 568 ? 40 : 25) withText:@"enterAmount" withTextSize:[self view].frame.size.height > 568 ? 18 : 14 withAlignment:1 withLines:0];
    [hd setBackgroundColor:[self colorFromHexString:Colorm1 withAlpha:1.0]];
    [viewaddamt addSubview:hd];
    
    amt = [self UITextField:self withFrame:CGRectMake(([self view].frame.size.width/2)-(n/2), y, n, h) withText:@"" withSize:[self view].frame.size.height > 568 ? 45 : 32 withInputType:UIKeyboardTypeNumberPad withSecure:0];
    [amt setHidden:YES];
    [viewaddamt addSubview:amt];
    [amt becomeFirstResponder];
    
    addamtlbl = [self UILabel:self withFrame:CGRectMake(([self view].frame.size.width/2)-(n/2), y, n, h) withText:@"0" withTextSize:[self view].frame.size.height > 568 ? 45 : 32 withAlignment:1 withLines:0];
    [addamtlbl setTextColor:[UIColor blackColor]];
    [viewaddamt addSubview:addamtlbl];
    
    cur = [self UILabel:self withFrame:CGRectMake(addamtlbl.frame.origin.x-w, y-5, w, h) withText:[[defaults objectForKey:@"language"] isEqualToString:@"id"] ? @"Rp" : @"IDR" withTextSize:20 withAlignment:2 withLines:0];
    [cur setTextColor:[self colorFromHexString:Color2 withAlpha:0.3]];
    [viewaddamt addSubview:cur];
    
    done = [self UIButton:self withFrame:CGRectMake(viewaddamt.frame.size.width-h-10, y, h, h) withTitle:@"" withTag:103];
    [done setBackgroundImage:[UIImage imageNamed:@"btnamt2.png"] forState:UIControlStateNormal];
    [done setEnabled:NO];
    [viewaddamt addSubview:done];
    
    [[self view] addSubview:viewaddamt];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        
    }
    else if([sender tag] == 101)
    {
//        [self RequestAPIGetChallengeNo];
        [defaults setObject:@"PaymentReceipt" forKey:@"ViewController"];
        [self performSegueWithIdentifier:@"Receipt" sender:self];
    }
    else if([sender tag] == 102)
    {
        [defaults setObject:@"Payment" forKey:@"ViewController"];
        [self performSegueWithIdentifier:@"InputPIN" sender:self];
    }
    else if([sender tag] == 103)
    {
        [amtlbl removeFromSuperview];
        AmtVal = [amt text];
        amtlbl = [self UILabelwithBlackText:self withFrame:CGRectMake(10, ([self view].frame.size.height/20)*6.5, (view.frame.size.width-20), 30) withText:[NSString stringWithFormat:@"%@%@", [[defaults objectForKey:@"language"] isEqualToString:@"id"] ? @"Rp" : @"IDR", [self FormatNumber:self from:[amt text]]] withTextSize:[self view].frame.size.height > 568 ? textsize24 : textsize16 withAlignment:2 withLines:0];
        [amtlbl setTextColor:[self colorFromHexString:Color3 withAlpha:1.0]];
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[amtlbl text]];
//        [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [[amtlbl text] length])];
//        [amtlbl setAttributedText:attributedString];
        [view addSubview:amtlbl];
        [amt resignFirstResponder];
        [viewaddamt removeFromSuperview];
        StAmt = @"";
    }
    else if([sender tag] == 104)
    {
        if ([[data objectForKey:@"pointOfInitiationMethod"] isEqualToString:@"11"]) {
            [self Amt];
        }
    }
}

- (void)changePage:(id)sender {
    CGFloat x = pageControl.currentPage * scrollView.frame.size.width;
    [scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
    
//    [bgimage setImage:[PCUtils getImageFromFolder:@"img" andFilename:[NSString stringWithFormat:@"%@bg.png", [[CardList objectAtIndex:[pageControl currentPage]] objectForKey:@"cardType"]]]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scView {
    if ([scView tag] == 1) {
        CGFloat pageWidth = scView.frame.size.width;
        float fractionalPage = scView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        self.pageControl.currentPage = page;
        
//        [bgimage setImage:[PCUtils getImageFromFolder:@"img" andFilename:[NSString stringWithFormat:@"%@bg.png", [[CardList objectAtIndex:[pageControl currentPage]] objectForKey:@"cardType"]]]];
        
//        if (page == (fractionalPage - fmodf(fractionalPage, 1))) {
//            if (1-(ABS(fmodf(fractionalPage, 1))) <= 0.7) {
//                [bgimage setAlpha:0.7];
//            } else {
//                [bgimage setAlpha:1-(ABS(fmodf(fractionalPage, 1)))];
//            }
//        } else {
//            if (fmodf(fractionalPage, 1) <= 0.7) {
//                [bgimage setAlpha:0.7];
//            } else {
//                [bgimage setAlpha:fmodf(fractionalPage, 1)];
//            }
//        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scView {
    if ([scView tag] == 1) {
        for(UIView *vw in scView.subviews)
        {
            if([vw viewWithTag:pageControl.currentPage+1])
            {
                if ([[[CardList objectAtIndex:pageControl.currentPage] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
                    CABasicAnimation *theAnimation1;
                    theAnimation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                    theAnimation1.duration=0;
                    theAnimation1.fillMode=kCAFillModeForwards;
                    theAnimation1.fromValue=[NSNumber numberWithFloat:1.0f];
                    theAnimation1.toValue=[NSNumber numberWithFloat:0.98f];
                    theAnimation1.removedOnCompletion = NO;
                    [theAnimation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                    theAnimation1.delegate=self;
                    [[[vw viewWithTag:pageControl.currentPage+1] layer] addAnimation:theAnimation1 forKey:@"transform.scale"];
                } else {
                    CABasicAnimation *theAnimation1;
                    theAnimation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                    theAnimation1.duration=0;
                    theAnimation1.fillMode=kCAFillModeForwards;
                    theAnimation1.fromValue=[NSNumber numberWithFloat:1.0f];
                    theAnimation1.toValue=[NSNumber numberWithFloat:0.98f];
                    theAnimation1.removedOnCompletion = NO;
                    [theAnimation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                    theAnimation1.delegate=self;
                    [[[vw viewWithTag:pageControl.currentPage+1] layer] addAnimation:theAnimation1 forKey:@"transform.scale"];
                }
                //here do your work
            }
            
            for(UIImageView *iv in scrollView.subviews)
            {
                for (int i = 1; i <= [CardList count]; i++) {
                    if([iv tag] == i)
                    {
                        [iv setAlpha:1.0];
                    }
                }
            }
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scView {
    if ([scView tag] == 1) {
        for(UIView *vw in scrollView.subviews)
        {
            if([vw viewWithTag:pageControl.currentPage+1])
            {
                if ([[[CardList objectAtIndex:pageControl.currentPage] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
                    CABasicAnimation *theAnimation1;
                    theAnimation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                    theAnimation1.duration=1;
                    theAnimation1.fillMode=kCAFillModeForwards;
                    theAnimation1.fromValue=[NSNumber numberWithFloat:1.0f];
                    theAnimation1.toValue=[NSNumber numberWithFloat:1.08f];
                    theAnimation1.removedOnCompletion = NO;
                    [theAnimation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                    theAnimation1.delegate=self;
                    [[[vw viewWithTag:pageControl.currentPage+1] layer] addAnimation:theAnimation1 forKey:@"transform.scale"];
                } else {
                    CABasicAnimation *theAnimation1;
                    theAnimation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                    theAnimation1.duration=1;
                    theAnimation1.fillMode=kCAFillModeForwards;
                    theAnimation1.fromValue=[NSNumber numberWithFloat:1.0f];
                    theAnimation1.toValue=[NSNumber numberWithFloat:1.08f];
                    theAnimation1.removedOnCompletion = NO;
                    [theAnimation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                    theAnimation1.delegate=self;
                    [[[vw viewWithTag:pageControl.currentPage+1] layer] addAnimation:theAnimation1 forKey:@"transform.scale"];
                }
                //here do your work
            }
            
            for(UIImageView *iv in scrollView.subviews)
            {
                for (int i = 1; i <= [CardList count]; i++) {
                    if([iv tag] == i)
                    {
                        [iv setAlpha:0.5];
                    }
                }
                if([iv tag] == pageControl.currentPage+1)
                {
                    [iv setAlpha:1.0];
                }
            }
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
//    if ([textField tag] == 0) {
//        return YES;
//    }
    
    if (newLength <= 9) {
        [addamtlbl setFrame:CGRectMake(([self view].frame.size.width/2)-(((newLength+1)*n)/2), y, (newLength+1)*n, h)];
        [cur setFrame:CGRectMake(addamtlbl.frame.origin.x-w, y-5, w, h)];
        if ([string isEqualToString:@""]) {
            addamtlbl.text = [self FormatNumber:self from:[[amt text] substringToIndex:[[amt text] length]-1]];
        } else {
            addamtlbl.text = [self FormatNumber:self from:[NSString stringWithFormat:@"%@%@", [amt text], string]];
        }
    }
    if (newLength > 0) {
        [done setBackgroundImage:[UIImage imageNamed:@"btnamt.png"] forState:UIControlStateNormal];
        [done setEnabled:YES];
    } else {
        [done setBackgroundImage:[UIImage imageNamed:@"btnamt2.png"] forState:UIControlStateNormal];
        [done setEnabled:NO];
    }
    
    
//    if ([amt.text length] == 3 && newLength == 4) {
//        amt.text = [[defaults objectForKey:@"language"] isEqualToString:@"id"] ? [amt.text stringByAppendingString:@"."] : [amt.text stringByAppendingString:@","];
//    }
//    if ([amt.text length] == 7 && newLength == 8) {
//        amt.text = [[defaults objectForKey:@"language"] isEqualToString:@"id"] ? [amt.text stringByAppendingString:@"."] : [amt.text stringByAppendingString:@","];
//    }
    
    return newLength <= 9;
}

#pragma mark - Segue Delegate
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"InputPIN"]) {
        CustomPIN *NVC = [segue destinationViewController];
        NVC.data = data;
        NVC.CardSelect = [CardList objectAtIndex:[pageControl currentPage]];
        NVC.CardNumberTrx = [[response objectForKey:@"params"] objectForKey:@"cardNumberTrx"];
        NVC.AmtVal = AmtVal;
    } else if([[segue identifier] isEqualToString:@"Receipt"]) {
        DetailTransaction *NVC = [segue destinationViewController];
        NVC.Response = data;
        NVC.CardSelect = [CardList objectAtIndex:[pageControl currentPage]];
        NVC.RefNo = [[response objectForKey:@"params"] objectForKey:@"retrievalReferenceNoTrx"];
        NVC.CardNumberTrx = [[response objectForKey:@"params"] objectForKey:@"cardNumberTrx"];
        NVC.AmtTrx = [[response objectForKey:@"params"] objectForKey:@"totalAmountTrx"];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) {
        if(buttonIndex == 0)
        {
            if ([[defaults objectForKey:@"StatusLogin"] isEqualToString:@"Y"]) {
                if ([[data objectForKey:@"pointOfInitiationMethod"] isEqualToString:@"11"]) {
                    CardList = [data objectForKey:@"sourceOfFundList"];
                    [self UI];
                } else {
//                    [self RequestAPIGetDetailTransaction];
                    [self UI];
                }
            }
        }
    } else
    if ([alertView tag] == 2) {
        if(buttonIndex == 0)
        {
            if ([[defaults objectForKey:@"StatusLogin"] isEqualToString:@"Y"]) {
                [defaults setObject:@"Payment" forKey:@"ViewController"];
                [self performSegueWithIdentifier:@"InputPIN" sender:self];
            }
        }
    } else if([alertView tag] == 3) {
        if (buttonIndex == 1) {
//            [self RequestAPICancelTransaction];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            Wallet *myVC = (Wallet *)[storyboard instantiateViewControllerWithIdentifier:@"RootHome"];
            [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [[self navigationController] presentViewController:myVC animated:NO completion:nil];
        }
    } else if([alertView tag] == 4) {
        if (buttonIndex == 0) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            Wallet *myVC = (Wallet *)[storyboard instantiateViewControllerWithIdentifier:@"RootHome"];
            [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [[self navigationController] presentViewController:myVC animated:NO completion:nil];
        }
    }
}

//-(void)RequestAPIGetChallengeNo {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetChallengeNo" withParams:nil];
////        NSLog(@"ChallengeNo = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                exc = @"";
//                CNo = [[response objectForKey:@"params"] objectForKey:@"challengeNo"];
//                PCToken *token = [[PCToken alloc] init];
//                @try {
//                    res = [token getResponse:TOUCHIDPIN andChallenge:[[response objectForKey:@"params"] objectForKey:@"challengeNo"]];
//                } @catch (NSException *exception) {
//                    NSLog(@"Except %@", exception.reason);
//                    exc = exception.reason;
//                }
//
//                if ([exc isEqualToString:@"error.token.errSecItemNotFound"]) {
//                    [self showAlert:@"Invalid Authentication! Please re-link your fingerprint." title:@"Warning!" btn:L(@"enterPin") tag:2 delegate:self];
////                } else if ([exc isEqualToString:@"error.token.responseFailed"]) {
////                    [self showAlert:@"Failed Authentication!" title:@"Warning!" btn:L(@"ok") tag:0 delegate:self];
//                } else if ([exc isEqualToString:@"error.token.errSecAuthFailed"]) {
//                    [defaults setObject:@"Payment" forKey:@"ViewController"];
//                    [self performSegueWithIdentifier:@"InputPIN" sender:self];
//                } else if ([exc isEqualToString:@"error.token.errSecUserCanceled"]) {
//
//                } else {
////                    [self RequestAPIAuthentication];
//                    [self RequestAPIPaymentSubmit];
//                }
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
//    NSString *lat = [NSString stringWithFormat:@"%@", [[[PCUtils execute:@"GetCurrentLocation" withParams:nil] objectForKey:@"params"] objectForKey:@"latitude"]];
//    NSString *lon = [NSString stringWithFormat:@"%@", [[[PCUtils execute:@"GetCurrentLocation" withParams:nil] objectForKey:@"params"] objectForKey:@"longitude"]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"PaymentSubmit" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[[CardList objectAtIndex:[pageControl currentPage]] objectForKey:@"cardId"], @"cardId", [[CardList objectAtIndex:[pageControl currentPage]] objectForKey:@"cardType"], @"cardType", [[CardList objectAtIndex:[pageControl currentPage]] objectForKey:@"cardFinancial"], @"cardFinancial", [data objectForKey:@"ecommRefNo"], @"ecommRefNo", res, @"responseNo", CNo, @"challengeNo", AmtVal, @"totalAmountTrx", lat, @"latitude", lon, @"longitude", nil]];
////        NSLog(@"Payment Submit = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                if ([[[response objectForKey:@"params"] objectForKey:@"status"] isEqualToString:@"N"]) {
//                    if ([[[response objectForKey:@"params"] objectForKey:@"message"] containsString:@"||"]) {
//                        NSArray* foo = [[[response objectForKey:@"params"] objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                        [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:4 delegate:self];
//                    } else {
//                        [self showAlert:[[response objectForKey:@"params"] objectForKey:@"message"] title:L(@"message") btn:L(@"ok") tag:4 delegate:self];
//                    }
//                } else {
//                    [defaults setObject:@"PaymentReceipt" forKey:@"ViewController"];
//                    [self performSegueWithIdentifier:@"Receipt" sender:self];
//                }
//            }
//            else if([[response objectForKey:@"logout"] intValue] == 1)
//            {
//                [self showAlert:L(@"systemRestart") title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                [defaults setObject:@"N" forKey:@"StatusLogin"];
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
//                [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                [[self navigationController] presentViewController:myVC animated:NO completion:nil];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 0)
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

//-(void)RequestAPIGetDetailTransaction {
//    [[self view] endEditing:YES];
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetDetailTransaction" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[data objectForKey:@"ecommRefNo"], @"ecommRefNo", [data objectForKey:@"checksum"], @"checksum", [data objectForKey:@"mid"], @"mid", nil]];
////        NSLog(@"Detail Transaction = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:1 delegate:self];
//            }
//            else if([response objectForKey:@"DownloadModules"]) {
//                [maskView removeFromSuperview];
//                [self RequestAPIGetDetailTransaction];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                CardList = [[response objectForKey:@"params"] objectForKey:@"sourceOfFundList"];
//                data = [response objectForKey:@"params"];
//                [self UI];
//            }
//            else if([[response objectForKey:@"logout"] intValue] == 1)
//            {
//                [self showAlert:L(@"systemRestart") title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                [defaults setObject:@"N" forKey:@"StatusLogin"];
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
//                [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                [[self navigationController] presentViewController:myVC animated:NO completion:nil];
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

//-(void)RequestAPICancelTransaction {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"CancelTransaction" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[data objectForKey:@"ecommRefNo"], @"ecommRefNo", nil]];
////        NSLog(@"CancelTransaction = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                if ([[defaults objectForKey:@"FromPush"] isEqualToString:@"YES"]) {
//                    [defaults setObject:@"Cancel" forKey:@"FromPush"];
//                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                    PushPassword *myVC = (PushPassword *)[storyboard instantiateViewControllerWithIdentifier:@"PushPassword"];
//                    [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                    [[self navigationController] presentViewController:myVC animated:NO completion:nil];
//                } else {
//                    [defaults removeObjectForKey:@"ViewController"];
//                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                    Wallet *myVC = (Wallet *)[storyboard instantiateViewControllerWithIdentifier:@"RootHome"];
//                    [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                    [[self navigationController] presentViewController:myVC animated:NO completion:nil];
//                }
//            }
//            else if([[response objectForKey:@"logout"] intValue] == 1)
//            {
//                [self showAlert:L(@"systemRestart") title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                [defaults setObject:@"N" forKey:@"StatusLogin"];
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
//                [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                [[self navigationController] presentViewController:myVC animated:NO completion:nil];
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

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
}

@end
