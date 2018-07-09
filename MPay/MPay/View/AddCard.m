//
//  AddCard.m
//  MPay
//
//  Created by Admin on 7/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AddCard.h"
#import "AddExpDate.h"

@implementation AddCard
{
    UIButton *Camera, *Add;
    UITextField *CardNumber;
    NSString *DDYY;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"debitOrCreditCard"];
    if ([[defaults objectForKey:@"QRCardNumber"] length] > 0) {
        CardNumber.text = [NSString stringWithFormat:@"%@ %@ %@ %@", [[defaults objectForKey:@"QRCardNumber"] substringToIndex:4], [[defaults objectForKey:@"QRCardNumber"] substringWithRange:NSMakeRange(4, 4)], [[defaults objectForKey:@"QRCardNumber"] substringWithRange:NSMakeRange(8, 4)], [[defaults objectForKey:@"QRCardNumber"] substringFromIndex:12]];
        if ([defaults objectForKey:@"QRCardExpiryYear"] && [defaults objectForKey:@"QRCardExpiryMonth"]) {
            DDYY = [NSString stringWithFormat:@"%@/%@", [defaults objectForKey:@"QRCardExpiryMonth"], [[defaults objectForKey:@"QRCardExpiryYear"] length] == 4 ? [[defaults objectForKey:@"QRCardExpiryYear"] substringFromIndex:2] : [defaults objectForKey:@"QRCardExpiryYear"]];
        }
        [Camera setHidden:YES];
        [Add setEnabled:YES];
        [Add setTitleColor:[self colorFromHexString:@"#FAFAFA" withAlpha:1.0] forState:UIControlStateNormal];
        [Add setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        [defaults removeObjectForKey:@"QRCardNumber"];
        [defaults removeObjectForKey:@"QRCardExpiryMonth"];
        [defaults removeObjectForKey:@"QRCardExpiryYear"];
        [self performSegueWithIdentifier:@"ExpDate" sender:self];
    }
    
    [CardNumber becomeFirstResponder];
}

- (void)UI {
    UIView *bgview = [self UIView:self withFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-60)];
    [[bgview layer] setCornerRadius:10];
    
    UIImageView *imgcard = [self UIImage:self withFrame:CGRectMake((bgview.frame.size.width/2)-40, 30, 80, 50) withImageName:@"FCard.png"];
    [[imgcard layer] setCornerRadius:5];
    [[imgcard layer] setBorderWidth:1.0];
    [[imgcard layer] setBorderColor:[UIColor grayColor].CGColor];
    [bgview addSubview:imgcard];
    [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, 100, bgview.frame.size.width-40, 50) withText:@"pleaseInsertYourCardNumber" withTextSize:textsize12 withAlignment:1 withLines:0]];
    
    CardNumber = [self UITextField:self withFrame:CGRectMake(20, 150, bgview.frame.size.width-40, 40) withText:@"cardNumber" withSize:24 withInputType:UIKeyboardTypeNumberPad withSecure:0];
    [CardNumber setTextAlignment:NSTextAlignmentCenter];
    [CardNumber addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    CardNumber.delegate = self;
    [bgview addSubview:CardNumber];
    
    Camera = [self UIButton:self withFrame:CGRectMake(bgview.frame.size.width-80, CardNumber.frame.origin.y+5, 30, 25) withTitle:@"" withTag:1];
    [Camera setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"camera.png"]] forState:UIControlStateNormal];
    [bgview addSubview:Camera];
    
    Add = [self UIButton:self withFrame:CGRectMake(btnmarginleft, ([self view].frame.size.height/2)-50, bgview.frame.size.width-(btnmarginleft*2), btnheight) withTitle:[@"addCard" uppercaseString] withTag:0];
    [Add setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    [Add setEnabled:NO];
    [bgview addSubview:Add];
    
    [[self view] addSubview:bgview];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        if ([[[CardNumber text] stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 16) {
            [self performSegueWithIdentifier:@"ExpDate" sender:self];
        }
        else
        {
            [self showAlert:@"invalidCardNumber" title:@"warning" btn:@"ok" tag:0 delegate:self];
        }
    }
    else
    if([sender tag] == 1)
    {
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

#pragma mark - Segue Delegate
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ExpDate"]) {
        AddExpDate *NVC = [segue destinationViewController];
        NVC.CardNumber = [CardNumber text];
        NVC.ExpCard = DDYY;
    }
}

-(void)textFieldDidChange:(id)sender {
    if ([[[CardNumber text] stringByReplacingOccurrencesOfString:@" " withString:@""] length] >= 16 ) {
        CardNumber.text = [NSString stringWithFormat:@"%@ %@ %@ %@", [[[CardNumber text] stringByReplacingOccurrencesOfString:@" " withString:@""] substringToIndex:4] ,[[[CardNumber text] stringByReplacingOccurrencesOfString:@" " withString:@""] substringWithRange:NSMakeRange(4, 4)],[[[CardNumber text] stringByReplacingOccurrencesOfString:@" " withString:@""] substringWithRange:NSMakeRange(8, 4)], [[[CardNumber text] stringByReplacingOccurrencesOfString:@" " withString:@""] substringWithRange:NSMakeRange(12, 4)]];
        [Add setEnabled:YES];
        [Add setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        [self performSegueWithIdentifier:@"ExpDate" sender:self];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
            
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    if (newLength >= 1)
    {
        [Camera setHidden:YES];
    }
    else
    {
        [Camera setHidden:NO];
    }
    
    if ([CardNumber.text length] == 4 && newLength == 5) {
        CardNumber.text = [CardNumber.text stringByAppendingString:@" "];
    }
    if ([CardNumber.text length] == 9 && newLength == 10) {
        CardNumber.text = [CardNumber.text stringByAppendingString:@" "];
    }
    if ([CardNumber.text length] == 14 && newLength == 15) {
        CardNumber.text = [NSString stringWithFormat:@"%@ %@ %@ %@", [[[CardNumber text] stringByReplacingOccurrencesOfString:@" " withString:@""] substringToIndex:4] ,[[[CardNumber text] stringByReplacingOccurrencesOfString:@" " withString:@""] substringWithRange:NSMakeRange(4, 4)],[[[CardNumber text] stringByReplacingOccurrencesOfString:@" " withString:@""] substringWithRange:NSMakeRange(8, 4)], [[[CardNumber text] stringByReplacingOccurrencesOfString:@" " withString:@""] substringWithRange:NSMakeRange(12, [[[CardNumber text] stringByReplacingOccurrencesOfString:@" " withString:@""] length]-12)]];
    }
    
    NSCharacterSet* numberCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    for (int i = 0; i < [string length]; ++i)
    {
        unichar c = [string characterAtIndex:i];
        if (![numberCharSet characterIsMember:c])
        {
            return NO;
        }
    }
    
    if (newLength >= 19)
    {
        [Add setEnabled:YES];
        [Add setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
    }
    else
    {
        [Add setEnabled:NO];
        [Add setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    }
    
    return newLength <= 19;
}
/*
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
}*/

@end
