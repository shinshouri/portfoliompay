//
//  RegFingerprint.m
//  MPay
//
//  Copyright © 2016 Admin. All rights reserved.
//

#import "RegFingerprint.h"
#import "Login.h"

@implementation RegFingerprint
{
    NSString *ret;
    UIButton *btn;
    UILabel *result;
}
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem=newBackButton;
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"linkFingerprint"];
}

- (void)UI {
    GlobalVariable *GV = [GlobalVariable sharedInstance];
    
    UIView *bgview = [self UIView:self withFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-60)];
    [[bgview layer] setCornerRadius:10];
    
    result = [self UILabel:self withFrame:CGRectMake(20, [self view].frame.size.height/20, bgview.frame.size.width-40, 50) withText:@"success" withTextSize:36 withAlignment:1 withLines:0];
    [result setTextColor:[self colorFromHexString:Color1 withAlpha:1.0]];
    [bgview addSubview:result];
    
    [bgview addSubview:[self UIImage:self withFrame:CGRectMake((bgview.frame.size.width/2)-((bgview.frame.size.width/3)/2), ([self view].frame.size.height/20)*3.5, bgview.frame.size.width/3, bgview.frame.size.width/3) withImageName:@"fingerprintlinked.png"]];
    
    if ([defaults objectForKey:@"Register"]) {
        [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*9, self.view.frame.size.width-40, 50) withText:@"fingerprintReady" withTextSize:18 withAlignment:1 withLines:3]];
        
        [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, (([self view].frame.size.height/20)*12.5)-25, self.view.frame.size.width-40, 20) withText:@"weHaveSentActivationLinkTo"  withTextSize:16 withAlignment:1 withLines:0]];
        UILabel *em = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*12.5, self.view.frame.size.width-40, 20) withText:GV.Email  withTextSize:16 withAlignment:1 withLines:0];
        em.font = [UIFont boldSystemFontOfSize:16];
        [bgview addSubview:em];
        [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, (([self view].frame.size.height/20)*12.5)+25, self.view.frame.size.width-40, 20) withText:@"pleaseVerifyBeforeLogin"  withTextSize:16 withAlignment:1 withLines:0]];
    } else {
        [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*11, self.view.frame.size.width-40, 50) withText:@"fingerprintReady" withTextSize:20 withAlignment:1 withLines:3]];
    }
    
    btn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, bgview.frame.size.height-70, bgview.frame.size.width-(btnmarginleft*2), btnheight) withTitle:[@"continue" uppercaseString] withTag:0];
    [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
    [bgview addSubview:btn];
    
    [[self view] addSubview:bgview];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        if ([defaults objectForKey:@"Register"]) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
            [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [[self topViewController] presentViewController:myVC animated:NO completion:nil];
        } else {
            [self performSegueWithIdentifier:@"UnwindToAccAndSecurity" sender:self];
        }
    }
}

@end
