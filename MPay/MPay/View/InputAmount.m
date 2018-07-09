//
//  InputAmount.m
//  MPay
//
//  Created by Admin on 7/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "InputAmount.h"
#import "DetailTransfer.h"

@implementation InputAmount
{
    UITextField *Amount;
    UIButton *btn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
}

-(void)viewWillAppear:(BOOL)animated {
    [Amount becomeFirstResponder];
}

- (void)UI {
    [[self view] addSubview:[self UILabel:self withFrame:CGRectMake((self.view.frame.size.width/2)-25, 80, 50, 30) withText:@"IDR" withTextSize:16 withAlignment:1 withLines:0]];
    
    Amount = [self UITextField:self withFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 60) withText:@"0" withSize:30 withInputType:UIKeyboardTypeNumberPad withSecure:0];
    Amount.attributedPlaceholder = [[NSAttributedString alloc]
                                 initWithString:@"0"
                                 attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [Amount setTextAlignment:NSTextAlignmentCenter];
    Amount.delegate = self;
    [[self view] addSubview:Amount];
    
    btn = [self UIButton:self withFrame:CGRectMake(20, 250, self.view.frame.size.width-40, 50) withTitle:L(@"next") withTag:0];
    [btn setTitleColor:[self colorFromHexString:@"#FFFFFF" withAlpha:0.5] forState:UIControlStateNormal];
    [btn setBackgroundColor:[self colorFromHexString:@"#047FDB" withAlpha:0.5]];
    [[btn layer] setCornerRadius:3];
    [btn setEnabled:NO];
    [[self view] addSubview:btn];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        [self performSegueWithIdentifier:@"DetailTrans" sender:self];
    }
}

#pragma mark - Segue Delegate
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"DetailTrans"]) {
        DetailTransfer *myVC = [segue destinationViewController];
        myVC.val = [self FormatNumber:self from:[Amount text]];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    if (newLength >= 1) {
        [btn setTitleColor:[self colorFromHexString:@"#FFFFFF" withAlpha:1.0] forState:UIControlStateNormal];
        [btn setBackgroundColor:[self colorFromHexString:@"#047FDB" withAlpha:1.0]];
        [btn setEnabled:YES];
    }
    else
    {
        [btn setTitleColor:[self colorFromHexString:@"#FFFFFF" withAlpha:0.5] forState:UIControlStateNormal];
        [btn setBackgroundColor:[self colorFromHexString:@"#047FDB" withAlpha:0.5]];
        [btn setEnabled:NO];
    }
    
    
    return newLength <= 15;
}

@end
