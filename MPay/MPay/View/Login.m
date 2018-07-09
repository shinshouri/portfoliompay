//
//  Login.m
//  MPay
//
//  Created by Admin on 7/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "Login.h"
#import "Wallet.h"
#import "Register.h"
#import "OTPDiffDevice.h"

@implementation Login
{
    NSString *Page, *PKey, *PVal, *PExpo;
    UIScrollView *bgview;
    UIView *line1, *line2, *view, *view1, *garis;
    UILabel *UserIdLabel, *PasswordLabel, *versi, /* *UserIDwarning, */*Passwordwarning, *Or;
    UITextField *UserID,*Password, *CEmail, *ip;
    UIButton *toggle, *regis, *Lang, *Lang2;
    UIImageView *backimg;
    NSDictionary *CList;
    UIBarButtonItem *newBackButton;
    BOOL V;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationItem] setTitle:@""];
    [defaults removeObjectForKey:@"PersonalInfo"];
    
    if ([[self QsCFtGbHyUJSdaWE] isEqualToString:@"X1UaSDpOwQe0nf4"]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UpdateModules" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateModules:) name:@"UpdateModules" object:nil];
    
        if ([[defaults objectForKey:@"FirstIn"] length] <= 0) {
            [[self navigationController].view addSubview:[self showmask]];
            secondsLeft = 30;
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runTime:) userInfo:nil repeats:YES];
        } else {
//            [self RequestAPImobileBankingStatus];
            [self UI];
        }
    } else {
        [self showAlert:@"rootMsg" title:@"rootTitle" btn:@"ok" tag:0 delegate:self];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [redAlert removeFromSuperview];
    [defaults removeObjectForKey:@"Background"];
    [defaults setObject:@"Login" forKey:@"ViewController"];
    
    UserID.text = nil;
    UserIdLabel.hidden = YES;
    Password.text = nil;
    PasswordLabel.hidden = YES;
    
    if ([Page isEqualToString:@"Login"]) {
        [self navigationController].navigationBar.barStyle = UIBarStyleDefault;
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[self colorFromHexString:Color1 withAlpha:1.0]}];
        [[[self navigationController] navigationBar] setTintColor:[self colorFromHexString:Color1 withAlpha:1.0]];
    } else {
        [self navigationController].navigationBar.barStyle = UIBarStyleBlackOpaque;
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[self colorFromHexString:Color0 withAlpha:1.0]}];
        [[[self navigationController] navigationBar] setTintColor:[self colorFromHexString:Color0 withAlpha:1.0]];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [self navigationController].navigationBar.barStyle = UIBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)UpdateModules:(NSNotification*)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"%@", [notification object]);
        if ([[[notification object] objectForKey:@"totalSyncModules"] intValue] != [[[notification object] objectForKey:@"totalModules"] intValue] && [[[notification object] objectForKey:@"totalSyncModules"] intValue] == 0 && [[[notification object] objectForKey:@"totalModules"] intValue] > 0) {
            [[self navigationController].view addSubview:[self showProgressbar]];
        }
        
        progressView.progress = (float)[[[notification object] objectForKey:@"totalSyncModules"] intValue]/[[[notification object] objectForKey:@"totalModules"] intValue];
        
        if ([[[notification object] objectForKey:@"totalSyncModules"] intValue] == [[[notification object] objectForKey:@"totalModules"] intValue]) {
            [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UpdateModules" object:nil];
//            [maskProgressView removeFromSuperview];
        }
    });
}

-(void)BackBtn {
    if ([Page isEqualToString:@"Login"]) {
        [self UIRegister];
    } else if([Page isEqualToString:@"Register"]) {
        if ([[defaults objectForKey:@"FirstIn"] length] <= 0) {
            [self performSegueWithIdentifier:@"OnBoard" sender:self];
        } else {
            [newBackButton setImage:nil];
            [backimg removeFromSuperview];
        }
    }
}

-(void)ToDo:(NSNotification*)notification
{
    [maskView removeFromSuperview];
//    [self RequestAPImobileBankingStatus];
    [self UI];
}

-(void)runTime:(NSTimer *)runningTimer {
    int minutes, seconds;
    secondsLeft--;
    
    minutes = (secondsLeft % 3600) / 60;
    seconds = (secondsLeft %3600) % 60;
    if ([DEVICETOKEN length] > 0) {
        [timer invalidate];
        [maskView removeFromSuperview];
//        [self RequestAPImobileBankingStatus];
        [self UI];
    }
    
    if (secondsLeft <= 0) {
        [timer invalidate];
        [maskView removeFromSuperview];
//        [self RequestAPImobileBankingStatus];
        [self UI];
    }
}

- (void)UI {
//    [[self navigationItem] setTitle:L(@"login")];
    Page = @"Login";
    [bgimage setImage:[UIImage imageNamed:@"bgwhite.png"]];
    
    [self navigationController].navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[self colorFromHexString:Color1 withAlpha:1.0]}];
    [[[self navigationController] navigationBar] setTintColor:[self colorFromHexString:Color1 withAlpha:1.0]];
    
    if ([[defaults objectForKey:@"FirstIn"] length] <= 0) {
        [backimg removeFromSuperview];
        backimg = [self UIImage:self withFrame:[self view].frame.size.height > 568 ? backposition : backposition1 withImageName:@"back.png"];
        [[self view] addSubview:backimg];
        
        newBackButton = [[UIBarButtonItem alloc] initWithImage:[UIImage new] style:UIBarButtonItemStylePlain target:self action:@selector(BackBtn)];
        self.navigationItem.leftBarButtonItem=newBackButton;
    } else {
        [backimg removeFromSuperview];
        self.navigationItem.leftBarButtonItem=nil;
    }
    [bgview removeFromSuperview];
    bgview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-60)];
    bgview.contentSize = CGSizeMake(0, 500);
    bgview.showsVerticalScrollIndicator = NO;
    bgview.delegate = self;
    [bgview setBackgroundColor:[UIColor clearColor]];
    [[bgview layer] setCornerRadius:10];
    
    Lang = [self UIButton:self withFrame:CGRectMake([self view].frame.size.width-(((bgview.frame.size.height/15)*2)+30), bgview.frame.size.height/35, bgview.frame.size.height/15, bgview.frame.size.height/15) withTitle:@"ID" withTag:98];
    if ([[defaults objectForKey:@"language"] isEqualToString:@"id"]) {
        [Lang setImage:[UIImage imageNamed:@"IDbiruon.png"] forState:UIControlStateNormal];
    } else {
        [Lang setImage:[UIImage imageNamed:@"IDbiruoff.png"] forState:UIControlStateNormal];
    }
    [bgview addSubview:Lang];
    
    Lang2 = [self UIButton:self withFrame:CGRectMake([self view].frame.size.width-((bgview.frame.size.height/15)+20), bgview.frame.size.height/35, bgview.frame.size.height/15, bgview.frame.size.height/15) withTitle:@"EN" withTag:99];
    if ([[defaults objectForKey:@"language"] isEqualToString:@"id"]) {
        [Lang2 setImage:[UIImage imageNamed:@"ENbiruoff.png"] forState:UIControlStateNormal];
    } else {
        [Lang2 setImage:[UIImage imageNamed:@"ENbiruon.png"] forState:UIControlStateNormal];
    }
    [bgview addSubview:Lang2];
    
    UILabel *HeadTitle = [self UILabel:self withFrame:CGRectMake(20, bgview.frame.size.height/6, bgview.frame.size.width, 50) withText:@"welcomeBack" withTextSize:32 withAlignment:0 withLines:0];
    HeadTitle.textColor = [self colorFromHexString:Color2 withAlpha:1.0];
    [bgview addSubview:HeadTitle];
    
    UILabel *DetailTitle = [self UILabel:self withFrame:CGRectMake(20, (bgview.frame.size.height/6)+([self view].frame.size.height/15), bgview.frame.size.width, 50) withText:@"niceToSeeYouAgain" withTextSize:18 withAlignment:0 withLines:0];
    DetailTitle.textColor = [self colorFromHexString:Color2 withAlpha:0.8];
    [bgview addSubview:DetailTitle];
    if ([defaults objectForKey:@"Register"]) {
        [defaults removeObjectForKey:@"Register"];
        [HeadTitle setText:@"congratulation"];
        [DetailTitle setText:@"yourRegistrationSuccessful"];
    } else {
        [HeadTitle setText:@"welcomeBack"];
        [DetailTitle setText:@"niceToSeeYouAgain"];
    }
    
    UserIdLabel = [self UILabel:self withFrame:CGRectMake(20, (bgview.frame.size.height/6)+(([self view].frame.size.height/20)*3), self.view.frame.size.width-40, 10) withText:@"emailOrMobileNumber" withTextSize:textsize12 withAlignment:0 withLines:0];
    [UserIdLabel setTextColor:[self colorFromHexString:Color4 withAlpha:0.5]];
    [UserIdLabel setHidden:YES];
    [bgview addSubview:UserIdLabel];
    UserID = [self CustomTextField:CGRectMake(20, UserIdLabel.frame.origin.y + 5, self.view.frame.size.width - 40, 40) withStrPlcHolder:@"emailOrMobileNumber" withAttrColor:Color4 keyboardType:UIKeyboardTypeEmailAddress withTextColor:Color7 withFontSize:16 withTag:0 withDelegate:self];
    [bgview addSubview:UserID];
    
    PasswordLabel = [self UILabel:self withFrame:CGRectMake(20, (bgview.frame.size.height/6)+(([self view].frame.size.height/20)*5), self.view.frame.size.width-40, 10) withText:@"password" withTextSize:textsize12 withAlignment:0 withLines:0];
    [PasswordLabel setTextColor:[self colorFromHexString:Color4 withAlpha:0.5]];
    [PasswordLabel setHidden:YES];
    [bgview addSubview:PasswordLabel];
    Password = [self PasswordTextField:CGRectMake(20, PasswordLabel.frame.origin.y + 5, self.view.frame.size.width-60, 40) withStrPlcHolder:@"password" withAttrColor:Color4 keyboardType:UIKeyboardTypeDefault withTextColor:Color7 withFontSize:16 withTag:1 withDelegate:self];
    [Password addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [bgview addSubview:Password];
    toggle = [self btnPasswordImage:CGRectMake(Password.frame.origin.x + Password.frame.size.width, PasswordLabel.frame.origin.y + 10, 20, 20) withTag:0];
    [bgview addSubview:toggle];
    garis = [self UIView:self withFrame:CGRectMake(toggle.frame.origin.x, toggle.frame.origin.y+25, toggle.frame.size.width, 1)];
    [garis setBackgroundColor:[self colorFromHexString:Color4 withAlpha:0.2]];
    [garis setTag:1];
    [bgview addSubview:garis];
    
    UIButton *forgotpassword = [self UIButton:self withFrame:CGRectMake(self.view.frame.size.width-150, (bgview.frame.size.height/6)+(([self view].frame.size.height/20)*6.5), 150, 15) withTitle:[NSString stringWithFormat:@"%@", @"forgotPassword"] withTag:1];
    [forgotpassword setTitleColor:[self colorFromHexString:Color6 withAlpha:1.0] forState:UIControlStateNormal];
    [[forgotpassword titleLabel] setFont:[UIFont systemFontOfSize:14]];
    [bgview addSubview:forgotpassword];
    
    UIButton *login = [self UIButton:self withFrame:CGRectMake(btnmarginleft, ([self view].frame.size.height/6)+(([self view].frame.size.height/20)*8), self.view.frame.size.width-(btnmarginleft*2), btnheight) withTitle:[@"login" uppercaseString] withTag:2];
    [login setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
    [bgview addSubview:login];
    
    UIButton *setting = [self UIButton:self withFrame:CGRectMake(50, (bgview.frame.size.height/6)+(([self view].frame.size.height/20)*10), [self view].frame.size.width-100, 40) withTitle:@"Setting Server" withTag:88];
    [setting setTitleColor:[self colorFromHexString:Color3 withAlpha:1.0] forState:UIControlStateNormal];
    [bgview addSubview:setting];

    UILabel *terms = [self UILabel:self withFrame:CGRectMake(0, bgview.frame.size.height-(([self view].frame.size.height/20)*3), bgview.frame.size.width, 30) withText:[NSString stringWithFormat:@"%@ %@ %@", @"termsAndConditions", [[defaults objectForKey:@"language"] isEqualToString:@"en"] ? @"and" : @"dan", @"faqs"] withTextSize:14 withAlignment:1 withLines:0];
    [terms setTextColor:[self colorFromHexString:Color6 withAlpha:1.0]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[terms text]];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [[terms text] length]-([@"faqs" length]+5))];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange([[terms text] length]-[@"faqs" length], [@"faqs" length])];
    [terms setAttributedText:attributedString];
    [bgview addSubview:terms];
    
    UIButton *btnterms = [self UIButton:self withFrame:CGRectMake(0, bgview.frame.size.height-(([self view].frame.size.height/20)*3), (bgview.frame.size.width/3)*2, 30) withTitle:@"" withTag:4];
    [bgview addSubview:btnterms];
    UIButton *btnfaq = [self UIButton:self withFrame:CGRectMake((bgview.frame.size.width/3)*2, bgview.frame.size.height-(([self view].frame.size.height/20)*3), bgview.frame.size.width/3, 30) withTitle:@"" withTag:5];
    [bgview addSubview:btnfaq];
    
    UILabel *term = [self UILabel:self withFrame:CGRectMake(0, bgview.frame.size.height-30, bgview.frame.size.width, 20) withText:@"copyright" withTextSize:textsize12 withAlignment:1 withLines:0];
    term.textColor = [self colorFromHexString:Color4 withAlpha:0.5];
    [bgview addSubview:term];
    
    versi = [self UILabel:self withFrame:CGRectMake(bgview.frame.size.width-50, bgview.frame.size.height-30, 50, 20) withText:[NSString stringWithFormat:@"v.%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]] withTextSize:textsize12 withAlignment:0 withLines:0];
    versi.textColor = [self colorFromHexString:Color4 withAlpha:0.5];
    [bgview addSubview:versi];
    [bgview addSubview:[self UIButton:self withFrame:CGRectMake(bgview.frame.size.width-30, bgview.frame.size.height-30, 30, 20) withTitle:@"" withTag:999]];
    V = TRUE;
    
    [[self view] addSubview:bgview];
}

-(void)UIRegister {
//    [[self navigationItem] setTitle:L(@"createAccount")];
    Page = @"Register";
    [bgimage setImage:[UIImage imageNamed:@"bgblue.png"]];
    
    [self navigationController].navigationBar.barStyle = UIBarStyleBlackOpaque;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[self colorFromHexString:Color0 withAlpha:1.0]}];
    [[[self navigationController] navigationBar] setTintColor:[self colorFromHexString:Color0 withAlpha:1.0]];
    
    if ([[defaults objectForKey:@"FirstIn"] length] <= 0) {
        [backimg removeFromSuperview];
        backimg = [self UIImage:self withFrame:[self view].frame.size.height > 568 ? backposition : backposition1 withImageName:@"Backwhite.png"];
        [[self view] addSubview:backimg];
        
        newBackButton = [[UIBarButtonItem alloc] initWithImage:[UIImage new] style:UIBarButtonItemStylePlain target:self action:@selector(BackBtn)];
        self.navigationItem.leftBarButtonItem=newBackButton;
    } else {
        [backimg removeFromSuperview];
        self.navigationItem.leftBarButtonItem=nil;
    }
    [bgview removeFromSuperview];
    bgview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-60)];
    bgview.contentSize = CGSizeMake(0, 500);
    bgview.showsVerticalScrollIndicator = NO;
    bgview.delegate = self;
    [bgview setBackgroundColor:[UIColor clearColor]];
    [[bgview layer] setCornerRadius:10];
    
    Lang = [self UIButton:self withFrame:CGRectMake([self view].frame.size.width-(((bgview.frame.size.height/15)*2)+30), bgview.frame.size.height/35, bgview.frame.size.height/15, bgview.frame.size.height/15) withTitle:@"" withTag:98];
    if ([[defaults objectForKey:@"language"] isEqualToString:@"id"]) {
        [Lang setImage:[UIImage imageNamed:@"IDputihon.png"] forState:UIControlStateNormal];
    } else {
        [Lang setImage:[UIImage imageNamed:@"IDputihoff.png"] forState:UIControlStateNormal];
    }
    [bgview addSubview:Lang];
    
    Lang2 = [self UIButton:self withFrame:CGRectMake([self view].frame.size.width-((bgview.frame.size.height/15)+20), bgview.frame.size.height/35, bgview.frame.size.height/15, bgview.frame.size.height/15) withTitle:@"" withTag:99];
    if ([[defaults objectForKey:@"language"] isEqualToString:@"id"]) {
        [Lang2 setImage:[UIImage imageNamed:@"ENputihoff.png"] forState:UIControlStateNormal];
    } else {
        [Lang2 setImage:[UIImage imageNamed:@"ENputihon.png"] forState:UIControlStateNormal];
    }
    [bgview addSubview:Lang2];
    
    UILabel *HeadTitle = [self UILabel:self withFrame:CGRectMake(20, bgview.frame.size.height/6, bgview.frame.size.width, 50) withText:@"welcomeTo" withTextSize:32 withAlignment:0 withLines:0];
    HeadTitle.textColor = [self colorFromHexString:Color0 withAlpha:1.0];
    [bgview addSubview:HeadTitle];
    
    UILabel *DetailTitle = [self UILabel:self withFrame:CGRectMake(20, (bgview.frame.size.height/6)+([self view].frame.size.height/15), bgview.frame.size.width, 50) withText:@"mpay" withTextSize:32 withAlignment:0 withLines:0];
    DetailTitle.textColor = [self colorFromHexString:Color0 withAlpha:1.0];
    [DetailTitle setFont:[UIFont boldSystemFontOfSize:32]];
    [bgview addSubview:DetailTitle];
    
    regis = [self UIButton:self withFrame:CGRectMake(btnmarginleft, (bgview.frame.size.height/6)+(([self view].frame.size.height/20)*5), self.view.frame.size.width-(btnmarginleft*2), btnheight) withTitle:[@"register" uppercaseString] withTag:3];
    [regis setTitleColor:[self colorFromHexString:Color5 withAlpha:1.0] forState:UIControlStateNormal];
    [regis setBackgroundColor:[self colorFromHexString:Color0 withAlpha:1.0]];
    [bgview addSubview:regis];
    
    line1 = [self UIView:self withFrame:CGRectMake(20, (bgview.frame.size.height/6)+(([self view].frame.size.height/20)*7.5), (bgview.frame.size.width-90)/2, 1)];
    [line1 setBackgroundColor:[self colorFromHexString:Color0 withAlpha:0.5]];
    [bgview addSubview:line1];
    Or = [self UILabel:self withFrame:CGRectMake(((bgview.frame.size.width-90)/2)+25, line1.frame.origin.y-15, 40, 30) withText:@"or" withTextSize:textsize16 withAlignment:1 withLines:0];
    Or.textColor = [self colorFromHexString:Color0 withAlpha:0.5];
    [bgview addSubview:Or];
    line2 = [self UIView:self withFrame:CGRectMake(bgview.frame.size.width-(((bgview.frame.size.width-90)/2)+20), (bgview.frame.size.height/6)+(([self view].frame.size.height/20)*7.5), (bgview.frame.size.width-90)/2, 1)];
    [line2 setBackgroundColor:[self colorFromHexString:Color0 withAlpha:0.5]];
    [bgview addSubview:line2];
    
    UILabel *haveacc = [self UILabel:self withFrame:CGRectMake(20, (bgview.frame.size.height/6)+(([self view].frame.size.height/20)*8), bgview.frame.size.width-40, 50) withText:@"alreadyHaveAccountLogin" withTextSize:14 withAlignment:1 withLines:0];
    [haveacc setTextColor:[self colorFromHexString:Color0 withAlpha:0.7]];
    [bgview addSubview:haveacc];
    UIButton *haveaccount = [self UIButton:self withFrame:CGRectMake(20, (bgview.frame.size.height/6)+(([self view].frame.size.height/20)*8.7), bgview.frame.size.width-40, 50) withTitle:[@"loginHere" uppercaseString] withTag:8];
    [haveaccount setTitleColor:[self colorFromHexString:Color0 withAlpha:1.0] forState:UIControlStateNormal];
    [[haveaccount titleLabel] setFont:[UIFont systemFontOfSize:16]];
    [bgview addSubview:haveaccount];
    
    UILabel *terms = [self UILabel:self withFrame:CGRectMake(0, bgview.frame.size.height-(([self view].frame.size.height/20)*3), bgview.frame.size.width, 30) withText:[NSString stringWithFormat:@"%@ %@ %@", @"termsAndConditions", [[defaults objectForKey:@"language"] isEqualToString:@"en"] ? @"and" : @"dan", @"faqs"] withTextSize:14 withAlignment:1 withLines:0];
    terms.textColor = [self colorFromHexString:Color0 withAlpha:1.0];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[terms text]];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [[terms text] length]-([@"faqs" length]+5))];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange([[terms text] length]-[@"faqs" length], [@"faqs" length])];
    [terms setAttributedText:attributedString];
    [bgview addSubview:terms];
    
    UIButton *btnterms = [self UIButton:self withFrame:CGRectMake(0, bgview.frame.size.height-(([self view].frame.size.height/20)*3), (bgview.frame.size.width/3)*2, 30) withTitle:@"" withTag:4];
    [bgview addSubview:btnterms];
    UIButton *btnfaq = [self UIButton:self withFrame:CGRectMake((bgview.frame.size.width/3)*2, bgview.frame.size.height-(([self view].frame.size.height/20)*3), bgview.frame.size.width/3, 30) withTitle:@"" withTag:5];
    [bgview addSubview:btnfaq];
    
    UILabel *term = [self UILabel:self withFrame:CGRectMake(0, bgview.frame.size.height-30, bgview.frame.size.width, 20) withText:@"copyright" withTextSize:textsize12 withAlignment:1 withLines:0];
    term.textColor = [self colorFromHexString:Color0 withAlpha:0.5];
    [bgview addSubview:term];
    
    versi = [self UILabel:self withFrame:CGRectMake(bgview.frame.size.width-50, bgview.frame.size.height-30, 50, 20) withText:[NSString stringWithFormat:@"v.%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]] withTextSize:textsize12 withAlignment:0 withLines:0];
    versi.textColor = [self colorFromHexString:Color0 withAlpha:0.5];
    [bgview addSubview:versi];
    [bgview addSubview:[self UIButton:self withFrame:CGRectMake(bgview.frame.size.width-30, bgview.frame.size.height-30, 30, 20) withTitle:@"" withTag:999]];
    V = TRUE;
    [[self view] addSubview:bgview];
}

-(void)PopUP {
    //Custom POP UP
    view = [self UIView:self withFrame:CGRectMake(0, 0, [self view].frame.size.width, [self view].frame.size.height)];
    [view setBackgroundColor:[self transparentBlack]];
    
    UIView *pop = [self UIView:self withFrame:CGRectMake(0, 0, view.frame.size.width-20, 200)];
    [pop setBackgroundColor:[UIColor whiteColor]];
    [pop setCenter:[view center]];
    [[pop layer] setCornerRadius:10];
    
    [pop addSubview:[self UILabelwithBlackText:self withFrame:CGRectMake(10, 5, pop.frame.size.width-20, 35) withText:@"popUpVerifyEmailTitle" withTextSize:textsize16 withAlignment:1 withLines:2]];
    [pop addSubview:[self UILabelwithBlackText:self withFrame:CGRectMake(10, 40, pop.frame.size.width-20, 35) withText:@"popUpVerifyEmailDesc" withTextSize:textsize12 withAlignment:1 withLines:2]];
    
    CEmail = [self UITextField:self withFrame:CGRectMake(20, 80, pop.frame.size.width-40, 30) withText:@"email" withSize:12 withInputType:UIKeyboardTypeEmailAddress withSecure:0];
    CEmail.attributedPlaceholder = [[NSAttributedString alloc]
                                    initWithString:@"email"
                                    attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    [CEmail setTextColor:[UIColor blackColor]];
    [CEmail setTextAlignment:NSTextAlignmentCenter];
    [[CEmail layer] setBorderWidth:1.0];
    [[CEmail layer] setBorderColor:[UIColor grayColor].CGColor];
    [CEmail setTag:3];
    CEmail.text = [[response objectForKey:@"params"] objectForKey:@"emailAddress"];
    [pop addSubview:CEmail];
    
    UILabel *resend = [self UILabelwithBlackText:self withFrame:CGRectMake(10, 110, pop.frame.size.width-20, 40) withText:@"resendEmailActivationLink" withTextSize:textsize12 withAlignment:1 withLines:0];
    [resend setTextColor:[UIColor blueColor]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[resend text]];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [[resend text] length])];
    [resend setAttributedText:attributedString];
    [pop addSubview:resend];
    
    UIButton *Send = [self UIButton:self withFrame:CGRectMake(10, 110, pop.frame.size.width-20, 40) withTitle:@"" withTag:7];
    [pop addSubview:Send];
    
    UIButton *OK = [self UIButton:self withFrame:CGRectMake(0, pop.frame.size.height-50, pop.frame.size.width, 50) withTitle:@"ok" withTag:6];
    [OK setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [[OK layer] setCornerRadius:0];
    [[OK layer] setBorderWidth:0.5];
    [[OK layer] setBorderColor:[UIColor grayColor].CGColor];
    [pop addSubview:OK];
    
    [view addSubview:pop];
    
    [[self view] addSubview:view];
}

-(void)Act:(id)sender {
    if ([sender tag] == 0)
    {
        //Action Show or Hide Password
        if ([Password isSecureTextEntry]) {
            Password.secureTextEntry = NO;
            Password.font = nil;
            Password.font = [UIFont systemFontOfSize:16];
            [toggle setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passclosed.png"]] forState:UIControlStateNormal];
        }
        else
        {
            Password.secureTextEntry = YES;
            Password.font = nil;
            Password.font = [UIFont systemFontOfSize:16];
            [toggle setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passopen.png"]] forState:UIControlStateNormal];
        }
    }
    if([sender tag] == 1)
    {
        //Action Forgot Password
        if ([DEVICETOKEN length] <= 0) {
            [self showAlert:@"popUpTokenNotRegister" title:@"message" btn:@"ok" tag:0 delegate:self];
        } else {
            [self performSegueWithIdentifier:@"ForgotPassword" sender:self];
        }
    }
    else
    if ([sender tag] == 2)
    {
        [self performSegueWithIdentifier:@"Home" sender:self];
        //Action Login
//        if ([[UserID text] length] > 0 && [[Password text] length] > 0 && ([self IsValidEmail:[UserID text]] || [[UserID text] rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound)) {
//            if ([DEVICETOKEN length] > 0) {
//                [self RequestAPIGetPublicKey];
//            } else {
//                [self showAlert:L(@"popUpTokenNotRegister") title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//            }
//        }
//        else if([[UserID text] length] == 0 && [[Password text] length] == 0){
//            [self required:UserID withMsg:nil];
//            [self requiredPassword:Password withMsg:nil];
//            [garis setBackgroundColor:[UIColor redColor]];
//        }
//        else if([[UserID text] length] <=0)
//        {
//            [self required:UserID withMsg:nil];
//        }
//        else if([[Password text] length] <= 0)
//        {
//            [self requiredPassword:Password withMsg:nil];
//            [garis setBackgroundColor:[UIColor redColor]];
//        }
    }
    else
    if ([sender tag] == 3)
    {
        //Action Register
        if ([DEVICETOKEN length] <= 0) {
            [self showAlert:@"popUpTokenNotRegister" title:@"message" btn:@"ok" tag:0 delegate:self];
        } else {
            [self performSegueWithIdentifier:@"Terms" sender:self];
        }
    }
    else
    if ([sender tag] == 4)
    {
        //Action Terms And Conditions
        [defaults setObject:@"Settings" forKey:@"ViewController"];
        [self performSegueWithIdentifier:@"Terms" sender:self];
    }
    else
    if ([sender tag] == 5)
    {
        //Action FAQs
        [self performSegueWithIdentifier:@"FAQ" sender:self];
    }
    else
    if ([sender tag] == 6)
    {
        //Action OK pop up aktivasi
        [view removeFromSuperview];
    }
    else
    if ([sender tag] == 7)
    {
        //Action Resend pop up aktivasi
        if ([[CEmail text] length] > 0 && [self IsValidEmail:[CEmail text]])
        {
//            [self RequestAPIResendLinkActivation];
        }
        else
        {
            [self showAlert:@"errorInvalidEmail" title:@"warning" btn:@"ok" tag:0 delegate:self];
        }
    }
    else
    if ([sender tag] == 8)
    {
        //Action Back di Login Page
        [self UI];
    }
    else
    if ([sender tag] == 76)
    {
        //Action remove page
        [view1 removeFromSuperview];
    }
    else
    if ([sender tag] == 77)
    {
        //Action Setting Save IP Config
//        [defaults setObject:[ip text] forKey:PREF_KEY_SERVER];
        [view1 removeFromSuperview];
    }
    else
    if ([sender tag] == 88)
    {
        //Action show Setting IP Config
        view1 = [self UIView:self withFrame:CGRectMake(0, 0, [self view].frame.size.width, [self view].frame.size.height)];
        [view1 setBackgroundColor:[self transparentBlack]];
        
        UIView *pop = [self UIView:self withFrame:CGRectMake(0, 0, view1.frame.size.width-20, 180)];
        [pop setBackgroundColor:[UIColor whiteColor]];
        [pop setCenter:[view1 center]];
        [[pop layer] setCornerRadius:10];
        
        [pop addSubview:[self UILabel:self withFrame:CGRectMake(5, 10, pop.frame.size.width-10, 50) withText:DEVICEID withTextSize:textsize12 withAlignment:1 withLines:0]];
        
        ip = [self UITextField:self withFrame:CGRectMake(20, 60, pop.frame.size.width-40, 40) withText:@"" withSize:16 withInputType:UIKeyboardTypeDefault withSecure:0];
        [ip setTextAlignment:NSTextAlignmentCenter];
        [[ip layer] setBorderWidth:1.0];
        [[ip layer] setBorderColor:[UIColor blackColor].CGColor];
//        ip.text = [defaults objectForKey:PREF_KEY_SERVER];
        [pop addSubview:ip];
        
        UIButton *cancel = [self UIButton:self withFrame:CGRectMake(0, pop.frame.size.height-50, pop.frame.size.width/2, 50) withTitle:@"Cancel" withTag:76];
        [cancel setTitleColor:[self colorFromHexString:Color1 withAlpha:1.0] forState:UIControlStateNormal];
        [pop addSubview:cancel];
        
        UIButton *Save = [self UIButton:self withFrame:CGRectMake(pop.frame.size.width/2, pop.frame.size.height-50, pop.frame.size.width/2, 50) withTitle:@"Save" withTag:77];
        [Save setTitleColor:[self colorFromHexString:Color1 withAlpha:1.0] forState:UIControlStateNormal];
        [pop addSubview:Save];
        
        [view1 addSubview:pop];
        [[self view] addSubview:view1];
    }
    else if ([sender tag] == 98)
    {
        //Action Language id
        if ([[defaults objectForKey:@"language"] isEqualToString:@"en"]) {
            //Set Language
            [defaults setObject:@"id" forKey:@"language"];
            //Simpan UserID
            NSString *uid = UserID.text;
            //Check Page yang mau di load ulang
            [Page isEqualToString:@"Register"] ? [self UIRegister] : [self UI];
            //Set UserID setelah reload UI
            UserID.text = uid;
            [uid length] > 0 ? [UserIdLabel setHidden:NO] : [UserIdLabel setHidden:YES];
        }
    }
    else if ([sender tag] == 99)
    {
        //Action Language en
        if ([[defaults objectForKey:@"language"] isEqualToString:@"id"]) {
            //Set Language
            [defaults setObject:@"en" forKey:@"language"];
            //Simpan UserID
            NSString *uid = UserID.text;
            //Check Page yang mau di load ulang
            [Page isEqualToString:@"Register"] ? [self UIRegister] : [self UI];
            //Set UserID setelah reload UI
            UserID.text = uid;
            [uid length] > 0 ? [UserIdLabel setHidden:NO] : [UserIdLabel setHidden:YES];
        }
    }
    else if ([sender tag] == 999)
    {
//        BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
//        if (canOpenSettings) {
//            NSURL *url = [NSURL URLWithString:@"App-Prefs:root=Phone"];
//            [[UIApplication sharedApplication] openURL:url];
//        }
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tel://" stringByAppendingString:@"123"]]];
        
        if (V) {
            V = FALSE;
            [versi setText:[NSString stringWithFormat:@"b.%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
        } else {
            V = TRUE;
            [versi setText:[NSString stringWithFormat:@"v.%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]];
        }
        [self copyright:self :UserID.text :Password.text];
    } else if ([sender tag] == 123) {
        [redAlert removeFromSuperview];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"OTPDiffDevice"]) {
        OTPDiffDevice *NVC = [segue destinationViewController];
        NVC.UID = [UserID text];
    }
}

-(void)textFieldDidChange:(id)sender {
    if ([[Password text] length] > 0) {
        [PasswordLabel setHidden:NO];
    } else {
        [PasswordLabel setHidden:YES];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.view addGestureRecognizer:tapRecognizer];
    [bgview setFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-280)];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.view removeGestureRecognizer:tapRecognizer];
    [bgview setFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-60)];
    if ([textField tag] == 0) {
        if ([[UserID text] length] > 0 && !([self IsValidEmail:[UserID text]] || [[UserID text] rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound)) {
            [self removeValidationIcon:UserID withColor:Color4];
            [self required:UserID withMsg:[NSString stringWithFormat:@"%@ %@.", [UserIdLabel text], @"invalid"]];
        }
    }
    else if([textField tag] == 1) {
        if ([[Password text] length] > 0) {
            [self removeValidationIconPassword:Password withColor:Color4];
            [garis setBackgroundColor:[self colorFromHexString:Color4 withAlpha:0.2]];
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
    
    if ([textField tag] == 0) {
        if (newLength > 0) {
            [UserIdLabel setHidden:NO];
            [self removeValidationIcon:UserID withColor:Color4];
        } else {
            [UserIdLabel setHidden:YES];
        }
        return newLength <= 40;
    } else if([textField tag] == 1) {
        NSCharacterSet* numberCharSet = [NSCharacterSet alphanumericCharacterSet];
        
        for (int i = 0; i < [string length]; ++i)
        {
            unichar c = [string characterAtIndex:i];
            if ([string isEqualToString:@" "]) {
                
            } else if (![numberCharSet characterIsMember:c])
            {
                return NO;
            }
        }
        if (newLength > 0) {
            [PasswordLabel setHidden:NO];
            [self removeValidationIconPassword:Password withColor:Color4];
            [garis setBackgroundColor:[self colorFromHexString:Color4 withAlpha:0.2]];
        } else {
            [PasswordLabel setHidden:YES];
        }
        return YES;
    }
    
    return newLength <= 40;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) {
        if(buttonIndex == 1)
        {
            
        }
    } else if ([alertView tag] == 5) {
        if(buttonIndex == 1) {
            [self performSegueWithIdentifier:@"ForgotPassword" sender:self];
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
    NSString *message = file;
    
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
//            [self RequestAPIChangeDevice];
            break;
        }
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

//-(void)RequestAPImobileBankingStatus {
//    [[self navigationController].view addSubview:[self showmask]];
//    [[self view] endEditing:YES];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"mobileBankingStatus" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICETOKEN, @"deviceToken", nil]];
////        NSLog(@"MobileBankingStatus = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [maskProgressView removeFromSuperview];
//                if([[defaults objectForKey:@"FirstIn"] length] <= 0) {
//                    [defaults setObject:@"id" forKey:@"language"];
//                    [self UIRegister];
//                    [self performSegueWithIdentifier:@"OnBoard" sender:self];
//                } else {
//                    [self UI];
//                }
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([response objectForKey:@"DownloadModules"]) {
//                [maskView removeFromSuperview];
//                [maskProgressView removeFromSuperview];
//                [self RequestAPImobileBankingStatus];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [maskProgressView removeFromSuperview];
//                if ([[defaults objectForKey:@"FirstIn"] length] <= 0) {
//                    [defaults setObject:@"id" forKey:@"language"];
//                    [self performSegueWithIdentifier:@"OnBoard" sender:self];
//                } else if ([[defaults objectForKey:@"UserStatus"] isEqualToString:@"3"]) {
//                    [defaults removeObjectForKey:@"UserStatus"];
//                    [self PopUP];
//                } else if ([[defaults objectForKey:@"UserStatus"] isEqualToString:@"5"]) {
//                    [defaults removeObjectForKey:@"UserStatus"];
//                    [self showAlert2:L(@"popUpForgotPasswordDesc") title:L(@"popUpForgotPasswordTitle") btn1:L(@"cancel") btn2:L(@"forgotPassword") tag:5 delegate:self];
//                }
//
//                if([[defaults objectForKey:@"FirstIn"] length] <= 0) {
//                    [defaults setObject:@"id" forKey:@"language"];
//                    [self UIRegister];
//                    [[[PCUtils execute:@"GetCurrentLocation" withParams:nil] objectForKey:@"params"] objectForKey:@"longitude"];
//                }
//                else {
//                    [self UI];
//                    [[[PCUtils execute:@"GetCurrentLocation" withParams:nil] objectForKey:@"params"] objectForKey:@"longitude"];
//                }
//                if([defaults objectForKey:@"SessionTimeOut"]) {
//                    [defaults removeObjectForKey:@"SessionTimeOut"];
//                    [self showAlert:@"User already login in another device" title:@"Warning!" btn:@"OK" tag:0 delegate:self];
//                }
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 0)
//            {
//                [maskView removeFromSuperview];
//                [maskProgressView removeFromSuperview];
//                if ([DEVICETOKEN length] <= 0) {
//                    if([[defaults objectForKey:@"FirstIn"] length] <= 0) {
//                        [defaults setObject:@"id" forKey:@"language"];
//                        [self UIRegister];
//                        [self performSegueWithIdentifier:@"OnBoard" sender:self];
//                    } else {
//                        [self UI];
//                    }
//                    [self showAlert:L(@"popUpTokenNotRegister") title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                } else {
//                    if([[defaults objectForKey:@"FirstIn"] length] <= 0) {
//                        [defaults setObject:@"id" forKey:@"language"];
//                        [self UIRegister];
//                        [self performSegueWithIdentifier:@"OnBoard" sender:self];
//                    } else {
//                        [self UI];
//                    }
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

//-(void)RequestAPIGetPublicKey {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetPublicKey" withParams:[NSDictionary dictionaryWithObjectsAndKeys:@"safenet", @"typePublicKey", [UserID text], @"userId", nil]];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                PKey = [[response objectForKey:@"params"] objectForKey:@"randomNumber"];
//                PVal = [[response objectForKey:@"params"] objectForKey:@"modulusVal"];
//                PExpo = [[response objectForKey:@"params"] objectForKey:@"exponentVal"];
//                [self RequestAPILogin];
//            }
//            else
//            {
//                [maskView removeFromSuperview];
//                if ([[response objectForKey:@"message"] isEqualToString:@"invalidCredentials"]) {
//                    [redAlert removeFromSuperview];
//                    [self showRedAlert:L(@"invalidCredentials") title:L(@"message")];
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

//-(void)RequestAPILogin {
//    [[self navigationController].view addSubview:[self showmask]];
//    [[self view] endEditing:YES];
//    NSString *lat = [NSString stringWithFormat:@"%@", [[[PCUtils execute:@"GetCurrentLocation" withParams:nil] objectForKey:@"params"] objectForKey:@"latitude"]];
//    NSString *lon = [NSString stringWithFormat:@"%@", [[[PCUtils execute:@"GetCurrentLocation" withParams:nil] objectForKey:@"params"] objectForKey:@"longitude"]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"Login" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICETOKEN, @"deviceToken", [UserID text], @"userId", [self encryptHSM:[Password text] withRNumber:PKey withVal:PVal withExpo:PExpo], @"password", lat, @"latitude", lon, @"longitude", [[defaults objectForKey:@"FirstIn"] length] <= 0 ? @"Y":@"N", @"resetFinger", nil]];
////        NSLog(@"Login = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
////                [self showRedAlert:MSGResponseNil title:L(@"message")];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                if ([[[response objectForKey:@"params"] objectForKey:@"userStatus"] isEqualToString:@"2"]) {
//                    [self PopUP];
//                } else if ([[[response objectForKey:@"params"] objectForKey:@"userStatus"] isEqualToString:@"3"]) {
//                    [self showSMS:[[response objectForKey:@"params"] objectForKey:@"smsContent"]];
////                    [self RequestAPIRequestOTPByCust1];
//                } else if ([[[response objectForKey:@"params"] objectForKey:@"userStatus"] isEqualToString:@"5"]) {
//                    [self showAlert2:L(@"popUpForgotPasswordDesc") title:L(@"popUpForgotPasswordTitle") btn1:L(@"cancel") btn2:L(@"forgotPassword") tag:5 delegate:self];
//                } else {
//                    [defaults setObject:@"YES" forKey:@"FirstIn"];
//                    if ([[defaults objectForKey:@"ViewController"] isEqualToString:@"PushNoLogin"]) {
//                        [defaults removeObjectForKey:@"ViewController"];
//                        [defaults setObject:@"Y" forKey:@"StatusLogin"];
//                        [self performSegueWithIdentifier:@"Payment" sender:self];
//                    }
//                    else {
//                        [defaults setObject:@"Y" forKey:@"StatusLogin"];
//                        [self performSegueWithIdentifier:@"Home" sender:self];
//                    }
//                }
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 0)
//            {
//                [maskView removeFromSuperview];
//                if ([DEVICETOKEN length] <= 0) {
//                    [self showAlert:L(@"popUpTokenNotRegister") title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                } else {
//                    if ([[response objectForKey:@"message"] isEqualToString:@"invalidCredentials"]) {
//                        [redAlert removeFromSuperview];
//                        [self showRedAlert:L(@"invalidCredentials") title:L(@"message")];
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

//-(void)RequestAPIChangeDevice {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"ChangeDevice" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICETOKEN, @"deviceToken", nil]];
//        //        NSLog(@"Change Device = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults setObject:@"N" forKey:@"Fingerprint"];
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

//-(void)RequestAPIRequestOTPByCust1 {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"RequestOTP" withParams:[NSDictionary dictionaryWithObjectsAndKeys:@"N", @"haveECash", @"N", @"resendFlag", @"N", @"isTouchID", @"changeDevice", @"view", nil]];
////        NSLog(@"Request OTP = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                if ([[[response objectForKey:@"params"] objectForKey:@"isBlocked"] isEqualToString:@"Y"]) {
//                    [self showAlert:@"You cannot resend verification code in 30 minutes" title:@"Suspend Time" btn:L(@"ok") tag:0 delegate:self];
//                } else {
//                    [self performSegueWithIdentifier:@"OTPDiffDevice" sender:self];
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

//-(void)RequestAPIResendLinkActivation {
//    [[self navigationController].view addSubview:[self showmask]];
//    [[self view] endEditing:YES];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"ResendLinkActivation" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[UserID text], @"userId", [CEmail text], @"emailAddress", nil]];
////        NSLog(@"Resend Link = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults setObject:@"N" forKey:@"StatusLogin"];
//            }
//            else if([[response objectForKey:@"logout"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
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

//-(void)RequestAPIGetAllCardList {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetAllCardList" withParams:nil];
////        NSLog(@"CardList = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"tryAgain") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults setObject:@"Y" forKey:@"StatusLogin"];
//                [self performSegueWithIdentifier:@"Home" sender:self];
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
//            else if([[response objectForKey:@"ok"] intValue] == 0)
//            {
//                [maskView removeFromSuperview];
//                if ([[response objectForKey:@"message"] containsString:@"||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                } else {
//                    [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"tryAgain") tag:0 delegate:self];
//                }
//            }
//        });
//    });
//}

//-(void)RequestAPILogout {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"Logout" withParams:nil];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults setObject:@"N" forKey:@"StatusLogin"];
//            }
//            else if([[response objectForKey:@"logout"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults setObject:@"N" forKey:@"StatusLogin"];
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
//                [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                [[self topViewController] presentViewController:myVC animated:NO completion:nil];
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
