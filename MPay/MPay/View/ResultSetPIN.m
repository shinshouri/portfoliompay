//
//  ResultSetPIN.m
//  MPay
//
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ResultSetPIN.h"
#import "Login.h"

@implementation ResultSetPIN
{
    UIView *bgview;
    UIButton *btn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem=newBackButton;
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"setPin"];
}

- (void)UI {
    GlobalVariable *GV = [GlobalVariable sharedInstance];
    bgview = [self UIView:self withFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-60)];
    [[bgview layer] setCornerRadius:10];
    
    [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, 20, [self view].frame.size.width-40, 50) withText:@"success" withTextSize:28 withAlignment:1 withLines:0]];
    
    [bgview addSubview:[self UIImage:self withFrame:CGRectMake((bgview.frame.size.width/2)-((bgview.frame.size.width/2.5)/2), 100, bgview.frame.size.width/2.5, bgview.frame.size.width/2.5) withImageName:@"success.png"]];
    
    [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, (bgview.frame.size.height/2)+(bgview.frame.size.height/20), self.view.frame.size.width-40, 50) withText:@"pinReady" withTextSize:18 withAlignment:1 withLines:3]];
    [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, (bgview.frame.size.height/2)+((bgview.frame.size.height/20)*3), self.view.frame.size.width-40, 20) withText:@"weHaveSentActivationLinkTo"  withTextSize:textsize16 withAlignment:1 withLines:0]];
    UILabel *lbl = [self UILabel:self withFrame:CGRectMake(20, (bgview.frame.size.height/2)+((bgview.frame.size.height/20)*4), self.view.frame.size.width-40, 20) withText:GV.Email  withTextSize:textsize16 withAlignment:1 withLines:0];
    [lbl setFont:[UIFont boldSystemFontOfSize:16]];
    [bgview addSubview:lbl];
    [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, (bgview.frame.size.height/2)+((bgview.frame.size.height/20)*5), self.view.frame.size.width-40, 20) withText:@"pleaseVerifyBeforeLogin"  withTextSize:textsize16 withAlignment:1 withLines:0]];
    
    btn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, bgview.frame.size.height-70, bgview.frame.size.width-(btnmarginleft*2), btnheight) withTitle:[@"continue" uppercaseString] withTag:0];
    [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
    [bgview addSubview:btn];
    
    [[self view] addSubview:bgview];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
        [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [[self topViewController] presentViewController:myVC animated:NO completion:nil];
    }
}

@end
