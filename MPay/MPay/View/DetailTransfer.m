//
//  DetailTransfer.m
//  MPay
//
//  Created by Admin on 7/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "DetailTransfer.h"
#import <AprismaLibrary/AprismaLibrary.h>

@implementation DetailTransfer
{
    UIView *view;
    UIButton *done, *fingerprint;
}
@synthesize val;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
}

- (void)UI {
    [[self view] addSubview:[self UIImage:self withFrame:CGRectMake(20, 70, self.view.frame.size.width-40, self.view.frame.size.height/4) withImageName:@"E-Cash.png"]];
    
    view = [self UIView:self withFrame:CGRectMake(20, (self.view.frame.size.height/4)+110, self.view.frame.size.width-40, self.view.frame.size.height-260)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    [view addSubview:[self UIView:self withFrame:CGRectMake(10, 40, ((self.view.frame.size.width-40)-50)/2, 1)]];
    UILabel *To = [self UILabel:self withFrame:CGRectMake((((self.view.frame.size.width-40)-50)/2)+10, 25, 30, 30) withText:@"To" withTextSize:14 withAlignment:1 withLines:0];
    [To setTextColor:[UIColor blackColor]];
    [view addSubview:To];
    [view addSubview:[self UIView:self withFrame:CGRectMake((((self.view.frame.size.width-40)-50)/2)+40, 40, ((self.view.frame.size.width-40)-50)/2, 1)]];
    
    UIImageView *img = [self UIImage:self withFrame:CGRectMake((view.frame.size.width/2)-30, 50, 60, 60) withImageName:@"E-Cash.png"];
    [[img layer] setCornerRadius:30];
    [img setClipsToBounds:YES];
    [[img layer] setBorderWidth:2.0f];
    [[img layer] setBorderColor:[UIColor whiteColor].CGColor];
    [view addSubview:img];
    
    UILabel *nama = [self UILabel:self withFrame:CGRectMake(10, 110, view.frame.size.width-20, 20) withText:@"Agung Triharso" withTextSize:12 withAlignment:1 withLines:0];
    [nama setTextColor:[UIColor blackColor]];
    [view addSubview:nama];
    UILabel *email = [self UILabel:self withFrame:CGRectMake(10, 130, view.frame.size.width-20, 20) withText:@"agung_triharso@gmail.com" withTextSize:12 withAlignment:1 withLines:0];
    [email setTextColor:[UIColor blackColor]];
    [view addSubview:email];
    [view addSubview:[self UIView:self withFrame:CGRectMake(10, 150, view.frame.size.width-20, 1)]];
    
    fingerprint = [self UIButton:self withFrame:CGRectMake((view.frame.size.width/2)-30, 160, 60, 60) withTitle:@"" withTag:1];
    [fingerprint setBackgroundImage:[UIImage imageNamed:@"fingerprint.png"] forState:UIControlStateNormal];
    [view addSubview:fingerprint];
    UILabel *lbl = [self UILabel:self withFrame:CGRectMake(10, 220, view.frame.size.width-20, 20) withText:L(@"sendWithFingerprint") withTextSize:12 withAlignment:1 withLines:0];
    [lbl setTextColor:[UIColor blackColor]];
    [view addSubview:lbl];
    
    [view addSubview:[self UIView:self withFrame:CGRectMake(10, 250, ((self.view.frame.size.width-40)-50)/2, 1)]];
    UILabel *Or = [self UILabel:self withFrame:CGRectMake((((self.view.frame.size.width-40)-50)/2)+10, 235, 30, 30) withText:L(@"or") withTextSize:14 withAlignment:1 withLines:0];
    [Or setTextColor:[UIColor blackColor]];
    [view addSubview:Or];
    [view addSubview:[self UIView:self withFrame:CGRectMake((((self.view.frame.size.width-40)-50)/2)+40, 250, ((self.view.frame.size.width-40)-50)/2, 1)]];
    
    UIButton *btn = [self UIButton:self withFrame:CGRectMake((view.frame.size.width/2)-50, 270, 100, 30) withTitle:L(@"enterPin") withTag:0];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[btn layer] setBorderWidth:1.0f];
    [[btn layer] setBorderColor:[UIColor blackColor].CGColor];
    [view addSubview:btn];
    
    [[self view] addSubview:view];
    
    UILabel *amount = [self UILabel:self withFrame:CGRectMake(([self view].frame.size.width/2)/2, (self.view.frame.size.height/4)+85, [self view].frame.size.width/2, 50) withText:[NSString stringWithFormat:@"Rp %@", val] withTextSize:16 withAlignment:1 withLines:0];
    [amount setTextColor:[UIColor whiteColor]];
    [amount setBackgroundColor:[self colorFromHexString:@"#FE541C" withAlpha:1.0]];
    [[amount layer] setCornerRadius:([self view].frame.size.width/2)/7];
    [amount setClipsToBounds:YES];
    [[self view] addSubview:amount];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        [defaults setObject:@"DetailTransfer" forKey:@"ViewController"];
        [self performSegueWithIdentifier:@"InputPIN" sender:self];
    }
    else
    if ([sender tag] == 1) {
        [fingerprint setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        UIView *maskview = [[UIView alloc] initWithFrame:CGRectMake((view.frame.size.width/2)-30, 160, 60, 60)];
        [[maskview layer] setCornerRadius:30];
        [[maskview layer] setBorderColor:[UIColor greenColor].CGColor];
        UIImageView *check=[self UIImage:self withFrame:CGRectMake((view.frame.size.width/2)-30, 160, 60, 60) withImageName:@"checkdone.png"];
        [[check layer] setCornerRadius:30];
        [[check layer] setBorderColor:[UIColor greenColor].CGColor];
        
        CABasicAnimation *border = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
        [border setFromValue:[NSNumber numberWithInt:2]];
        [border setToValue:[NSNumber numberWithInt:30]];
        [border setRemovedOnCompletion:NO];
        border.fillMode = kCAFillModeForwards;
        border.duration = 0.5;
        
        [maskview.layer addAnimation:border forKey:@"border"];
        [view addSubview:maskview];
        [view addSubview:check];
    }
}

#pragma mark - Animation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}

@end
