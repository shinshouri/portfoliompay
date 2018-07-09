//
//  UBirthday.m
//  MPay
//
//  Created by Admin on 7/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "UBirthday.h"
#import "SetPIN.h"

@implementation UBirthday
{
    UIButton *btn;
    UIDatePicker *datepicker;
    NSDate *maxDate;
}
@synthesize data, PInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"yourBirthday"];
}

- (void)UI {
    UIView *bgview = [self UIView:self withFrame:CGRectMake(0, 70, [self view].frame.size.width, [self view].frame.size.height-60)];
    [[bgview layer] setCornerRadius:10];
    
    [bgview addSubview:[self UILabel:self withFrame:CGRectMake(20, [self view].frame.size.height/40, bgview.bounds.size.width-40, [self view].frame.size.height/10) withText:@"birthdayDesc" withTextSize:textsize16 withAlignment:0 withLines:3]];
    
    datepicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(20, [self view].frame.size.height/8, bgview.frame.size.width-40, [self view].frame.size.height/3)];
    [datepicker setDatePickerMode:UIDatePickerModeDate];
    [datepicker setMaximumDate:[NSDate date]];
    [datepicker setLocale:[NSLocale localeWithLocaleIdentifier:[defaults objectForKey:@"language"]]];
    [bgview addSubview:datepicker];
    
    btn = [self UIButton:self withFrame:CGRectMake(btnmarginleft, [self view].frame.size.height/2, bgview.bounds.size.width-(btnmarginleft*2), btnheight) withTitle:[@"next" uppercaseString] withTag:0];
    [btn setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
    [bgview addSubview:btn];
    
    [[self view] addSubview:bgview];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        [self performSegueWithIdentifier:@"SetPIN" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SetPIN"]) {
        SetPIN *NVC = [segue destinationViewController];
        NVC.data =  data;
        NVC.PInfo =  PInfo;
        NVC.Bday = [self FormatDate:self from:[datepicker date] withFormat:@"dd-MM-yyyy"];
    }
}

@end
