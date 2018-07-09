//
//  Register.m
//  MPay
//
//  Created by Admin on 7/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "Register.h"
#import "VerifyEcashPIN.h"
#import "Verification.h"

@implementation Register
{
    NSMutableArray *SecurityQuestion, *TypeID;
    NSMutableArray *SQArray1, *SQArray2;
    UILabel *FNLabel, *LNLabel, *IDTypeLabel, *IDLabel, *SQ1Label, *SQ2Label, *AN1Label, *AN2Label;
    UITextField *FN, *LN, *IDType, *ID, *SQ1, *AN1, *SQ2, *AN2;
    UIScrollView *scrollView;
    UIButton *next;
    UIPickerView *Picker1, *Picker2, *Picker3;
    UITableView *table1, *table2;
    UIView *bgview, *view, *pop;
}
@synthesize SQdata;

- (void)viewDidLoad {
    [super viewDidLoad];
    SecurityQuestion = [[NSMutableArray alloc] init];
    SecurityQuestion = [[SQdata objectForKey:@"params"] objectForKey:@"listQuestion"];
    TypeID = [[[SQdata objectForKey:@"params"] objectForKey:@"listIdType"] mutableCopy];
    SQArray1 = [SecurityQuestion mutableCopy];
    SQArray2 = [SecurityQuestion mutableCopy];
    [self UI];
}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationItem] setTitle:@"personalInformation"];
}

- (void)UI {
    [[self view] addSubview:[self UIView:self withFrame:CGRectMake(0, 90, [self view].frame.size.width, [self view].frame.size.height-60)]];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-60)];
    [scrollView setBackgroundColor:[UIColor clearColor]];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 600);
    scrollView.showsVerticalScrollIndicator = NO;
    [[scrollView layer] setCornerRadius:10];
    //Label
    UILabel *lbl = [self UILabel:self withFrame:CGRectMake(20, [self view].frame.size.height/20, scrollView.frame.size.width-40, 60) withText:@"personalInformationDesc" withTextSize:textsize16 withAlignment:0 withLines:3];
    [scrollView addSubview:lbl];
    //Text Field
    FNLabel = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*3.5, (scrollView.frame.size.width-50)/2, 15) withText:@"firstName" withTextSize:13 withAlignment:0 withLines:0];
    [FNLabel setTextColor:[self colorFromHexString:@"9B9B9B" withAlpha:0.5]];
    [FNLabel setHidden:YES];
    [scrollView addSubview:FNLabel];
    FN = [self CustomTextField:CGRectMake(20, FNLabel.frame.origin.y + 5, (scrollView.frame.size.width-50)/2, 40) withStrPlcHolder:@"firstName" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:18 withTag:0 withDelegate:self];
    [FN setTag:0];
    [FN setDelegate:self];
    [scrollView addSubview:FN];
    
    LNLabel = [self UILabel:self withFrame:CGRectMake(((scrollView.frame.size.width-50)/2)+30, ([self view].frame.size.height/20)*3.5, (scrollView.frame.size.width-50)/2, 15) withText:@"lastName" withTextSize:13 withAlignment:0 withLines:0];
    [LNLabel setTextColor:[self colorFromHexString:@"9B9B9B" withAlpha:0.5]];
    [LNLabel setHidden:YES];
    [scrollView addSubview:LNLabel];
    LN = [self CustomTextField:CGRectMake(((scrollView.frame.size.width-50)/2)+30, LNLabel.frame.origin.y + 5, (scrollView.frame.size.width-50)/2, 40) withStrPlcHolder:@"lastName" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:18 withTag:1 withDelegate:self];
    [scrollView addSubview:LN];
    
    IDTypeLabel = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*5.5, (scrollView.frame.size.width-50)/3, 15) withText:@"idType" withTextSize:13 withAlignment:0 withLines:0];
    [IDTypeLabel setTextColor:[self colorFromHexString:@"9B9B9B" withAlpha:0.5]];
    [IDTypeLabel setHidden:YES];
    [scrollView addSubview:IDTypeLabel];
    IDType = [self CustomTextField:CGRectMake(20, IDTypeLabel.frame.origin.y + 5, (scrollView.frame.size.width-50)/3, 40) withStrPlcHolder:@"idType" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:18 withTag:6 withDelegate:self];
    Picker3 = [self UIPickerView:self withFrame:CGRectMake(0, 0, 0, 0) withTag:3];
    IDType.inputView = Picker3;
    [scrollView addSubview:IDType];
    [scrollView addSubview:[self UIImage:self withFrame:CGRectMake(IDType.frame.size.width, IDType.frame.origin.y+10, 12, 10) withImageName:@"arrowdown.png"]];
    
    IDLabel = [self UILabel:self withFrame:CGRectMake(((scrollView.frame.size.width-50)/3)+30, ([self view].frame.size.height/20)*5.5, ((scrollView.frame.size.width-50)/3)*2, 15) withText:@"idNumber" withTextSize:13 withAlignment:0 withLines:0];
    [IDLabel setTextColor:[self colorFromHexString:@"9B9B9B" withAlpha:0.5]];
    [IDLabel setHidden:YES];
    [scrollView addSubview:IDLabel];
    ID = [self CustomTextField:CGRectMake(((scrollView.frame.size.width-50)/3)+30, IDLabel.frame.origin.y + 5, ((scrollView.frame.size.width-50)/3)*2, 40) withStrPlcHolder:@"idNumber" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:18 withTag:7 withDelegate:self];
    [scrollView addSubview:ID];
    
    SQ1Label = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*7.5, scrollView.frame.size.width-40, 18) withText:@"securityQuestion" withTextSize:13 withAlignment:0 withLines:0];
    [SQ1Label setTextColor:[self colorFromHexString:@"9B9B9B" withAlpha:0.5]];
    [SQ1Label setHidden:YES];
    [scrollView addSubview:SQ1Label];
    SQ1 = [self CustomTextField:CGRectMake(20, SQ1Label.frame.origin.y + 10, scrollView.frame.size.width-40, 40) withStrPlcHolder:@"securityQuestion" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:18 withTag:2 withDelegate:self];
    Picker1 = [self UIPickerView:self withFrame:CGRectMake(0, 0, 0, 0) withTag:1];
    SQ1.inputView = Picker1;
    [scrollView addSubview:SQ1];
    [scrollView addSubview:[self UIImage:self withFrame:CGRectMake(SQ1.frame.size.width, SQ1.frame.origin.y+10, 12, 10) withImageName:@"arrowdown.png"]];
    
    AN1Label = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*9.5, scrollView.frame.size.width-40, 15) withText:@"answer" withTextSize:13 withAlignment:0 withLines:0];
    [AN1Label setHidden:YES];
    [AN1Label setTextColor:[self colorFromHexString:@"9B9B9B" withAlpha:0.5]];
    [scrollView addSubview:AN1Label];
    AN1 = [self CustomTextField:CGRectMake(20, AN1Label.frame.origin.y + 5, scrollView.frame.size.width-40, 40) withStrPlcHolder:@"answer" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:18 withTag:3 withDelegate:self];
    [scrollView addSubview:AN1];
    
    SQ2Label = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*11.5, scrollView.frame.size.width-40, 18) withText:@"securityQuestion" withTextSize:13 withAlignment:0 withLines:0];
    [SQ2Label setHidden:YES];
    [SQ2Label setTextColor:[self colorFromHexString:@"9B9B9B" withAlpha:0.5]];
    [scrollView addSubview:SQ2Label];
    SQ2 = [self CustomTextField:CGRectMake(20, SQ2Label.frame.origin.y + 10, scrollView.frame.size.width-40, 40) withStrPlcHolder:@"securityQuestion" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:18 withTag:4 withDelegate:self];
    Picker2 = [self UIPickerView:self withFrame:CGRectMake(0, 0, 0, 0) withTag:2];
    SQ2.inputView =Picker2;
    [SQ2 setHidden:YES];
    [scrollView addSubview:SQ2];
     
    AN2Label = [self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.height/20)*13.5, scrollView.frame.size.width-40, 15) withText:@"answer" withTextSize:13 withAlignment:0 withLines:0];
    [AN2Label setHidden:YES];
    [AN2Label setTextColor:[self colorFromHexString:@"9B9B9B" withAlpha:0.5]];
    [scrollView addSubview:AN2Label];
    AN2 = [self CustomTextField:CGRectMake(20, AN2Label.frame.origin.y + 5, scrollView.frame.size.width-40, 40) withStrPlcHolder:@"answer" withAttrColor:nil keyboardType:UIKeyboardTypeDefault withTextColor:nil withFontSize:18 withTag:5 withDelegate:self];
    [AN2 setHidden:YES];
    [scrollView addSubview:AN2];
    
    //Button
    next = [self UIButton:self withFrame:CGRectMake(btnmarginleft, scrollView.frame.size.height-70, scrollView.frame.size.width-(btnmarginleft*2), btnheight) withTitle:[@"next" uppercaseString] withTag:0];
    [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
    [next setEnabled:NO];
    [scrollView addSubview:next];
    
    //PopUpDownloadECash
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self view].frame.size.width, [self view].frame.size.height)];
    [view setBackgroundColor:[self transparentBlack]];
    [view setHidden:YES];
    
    pop = [self UIView:self withFrame:CGRectMake(0, 0, view.frame.size.width-40, 210)];
    [pop setBackgroundColor:[UIColor whiteColor]];
    [pop setCenter:[view center]];
    [[pop layer] setCornerRadius:10];
    
    [pop addSubview:[self UILabel:self withFrame:CGRectMake(10, 10, pop.frame.size.width-20, 50) withText:@"popUpDownloadEcashTitle" withTextSize:textsize16 withAlignment:1 withLines:0]];
    [pop addSubview:[self UILabel:self withFrame:CGRectMake(10, 60, pop.frame.size.width-20, 50) withText:@"popUpDownloadEcash" withTextSize:14 withAlignment:1 withLines:0]];
    
    UIButton *Download = [self UIButton:self withFrame:CGRectMake(0, pop.frame.size.height-100, pop.frame.size.width, 50) withTitle:@"downloadEcash" withTag:3];
    [Download setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [[Download layer] setBorderWidth:0.5];
    [[Download layer] setBorderColor:[UIColor grayColor].CGColor];
    [pop addSubview:Download];
    
    UIButton *Cancel = [self UIButton:self withFrame:CGRectMake(0, pop.frame.size.height-50, pop.frame.size.width, 50) withTitle:@"cancel" withTag:4];
    [Cancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [[Cancel layer] setBorderWidth:0.5];
    [[Cancel layer] setBorderColor:[UIColor grayColor].CGColor];
    [pop addSubview:Cancel];
    
    [view addSubview:pop];
    
    [[self view] addSubview:scrollView];
    
    [[self view] addSubview:view];
    
    [FN becomeFirstResponder];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        if (([[FN text] length] > 0) && ([[LN text] length] > 0) && ([[AN1 text] length] > 0) && ([[AN2 text] length]> 0) && ([[SQ1 text] length] > 0) && ([[SQ2 text] length] > 0)) {
            if ((![[SQ1 text] isEqualToString:[SQ2 text]])) {
//                [self RequestAPIValidateMobileNoECash];
                [self performSegueWithIdentifier:@"VerifyEcashPIN" sender:self];
            }
            else {
                [self showAlert:@"securityQuestionDiff" title:@"warning" btn:@"ok" tag:0 delegate:self];
            }
        }
        else {
            if([[FN text] length] <= 0){
                [self required:FN withMsg:nil];
            }
            if([[LN text] length] <= 0){
                [self required:LN withMsg:nil];
            }
            if([[SQ1 text] length] <= 0){
                [self required:SQ1 withMsg:nil];
            }
            if([[AN1 text] length] <= 0){
                [self required:AN1 withMsg:nil];
            }
            if([[SQ2 text] length] <= 0){
                [self required:SQ2 withMsg:nil];
            }
            if([[AN2 text] length] <= 0){
                [self required:AN2 withMsg:nil];
            }
        }
    }
    else if([sender tag] == 1)
    {
        [[self view] endEditing:YES];
        bgview = [self UIView:self withFrame:CGRectMake(0, 0, [self view].frame.size.width, [self view].frame.size.height)];
        [bgview setBackgroundColor:[self transparentBlack]];
        
        table1 = [self UITableView:self withFrame:CGRectMake(0, bgview.frame.size.height-(bgview.frame.size.height/3), bgview.frame.size.width, bgview.frame.size.height/3) withStyle:0];
        [table1 setDelegate:self];
        [table1 setDataSource:self];
        [table1 setTag:0];
        [bgview addSubview:table1];
        [[self view] addSubview:bgview];
    }
    else if([sender tag] == 2)
    {
        [[self view] endEditing:YES];
        bgview = [self UIView:self withFrame:CGRectMake(0, 0, [self view].frame.size.width, [self view].frame.size.height)];
        [bgview setBackgroundColor:[self transparentBlack]];
        
        table2 = [self UITableView:self withFrame:CGRectMake(0, bgview.frame.size.height-(bgview.frame.size.height/3), bgview.frame.size.width, bgview.frame.size.height/3) withStyle:0];
        [table2 setDelegate:self];
        [table2 setDataSource:self];
        [table2 setTag:1];
        [bgview addSubview:table2];
        [[self view] addSubview:bgview];
    }
    else if([sender tag] == 3)
    {
        [view setHidden:YES];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/id/app/mandiri-e-cash/id694970837?mt=8"]];
    }
    else if([sender tag] == 4)
    {
        [view setHidden:YES];
    }
}

-(void)Opt {
    [bgview removeFromSuperview];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 2) {
        if(buttonIndex == 1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/id/app/mandiri-e-cash/id694970837?mt=8"]];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *IT, *SC1, *SC2;
    for (int i = 0; i < [SecurityQuestion count]; i++) {
        if ([[SQ1 text] isEqualToString:[[SecurityQuestion objectAtIndex:i] objectForKey:@"securityQuestion"]]) {
            SC1 = [[SecurityQuestion objectAtIndex:i] objectForKey:@"securityQuestCode"];
        }
    }
    for (int i = 0; i < [SecurityQuestion count]; i++) {
        if ([[SQ2 text] isEqualToString:[[SecurityQuestion objectAtIndex:i] objectForKey:@"securityQuestion"]]) {
            SC2 = [[SecurityQuestion objectAtIndex:i] objectForKey:@"securityQuestCode"];
        }
    }
    for (int i = 0; i < [TypeID count]; i++) {
        if ([[IDType text] isEqualToString:[[TypeID objectAtIndex:i] objectForKey:@"idTypeName"]]) {
            IT = [[TypeID objectAtIndex:i] objectForKey:@"idTypeCode"];
        }
    }
    NSString *SQ = [NSString stringWithFormat:@"%@|%@,%@|%@", SC1,[AN1 text], SC2, [AN2 text], nil];
    NSMutableDictionary *dt = [NSMutableDictionary dictionaryWithObjectsAndKeys:[FN text], @"FirstName", [LN text], @"LastName", IT, @"IDType", [ID text], @"IDNumber", SQ, @"ListSQ", nil];
    
    GlobalVariable *GV = [GlobalVariable sharedInstance];
    
    if ([[segue identifier] isEqualToString:@"Verification"]) {
        Verification *NVC = [segue destinationViewController];
        NVC.data = dt;
        NVC.FlagECash = GV.haveEcash;
    } else
    if ([[segue identifier] isEqualToString:@"VerifyEcashPIN"]) {
        VerifyEcashPIN *NVC = [segue destinationViewController];
        NVC.data = dt;
        NVC.FlagECash = GV.haveEcash;
    }
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView tag] == 0) {
        [SQ1Label setHidden:NO];
        SQArray1 = [SecurityQuestion mutableCopy];
        for (int i = 0; i < [SecurityQuestion count]; i++) {
            if ([[SQ2 text] isEqualToString:[[SecurityQuestion objectAtIndex:i] objectForKey:@"securityQuestion"]]) {
                [SQArray1 removeObjectAtIndex:i];
            }
        }
        
        return [SQArray1 count];
    }
    else if([tableView tag] == 1) {
        [SQ2Label setHidden:NO];
        SQArray2 = [SecurityQuestion mutableCopy];
        for (int i = 0; i < [SecurityQuestion count]; i++) {
            if ([[SQ1 text] isEqualToString:[[SecurityQuestion objectAtIndex:i] objectForKey:@"securityQuestion"]]) {
                [SQArray2 removeObjectAtIndex:i];
            }
        }
        
        return [SQArray2 count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if ([tableView tag] == 0) {
        cell.textLabel.text = [[SQArray1 objectAtIndex:[indexPath row]] objectForKey:@"securityQuestion"];
        cell.textLabel.textColor = [self colorFromHexString:@"#6E6E6E" withAlpha:1.0];
    }
    else if ([tableView tag] == 1) {
        cell.textLabel.text = [[SQArray2 objectAtIndex:[indexPath row]] objectForKey:@"securityQuestion"];
        cell.textLabel.textColor = [self colorFromHexString:@"#6E6E6E" withAlpha:1.0];
    }
    
    return cell;
}

#pragma mark - Tableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView tag] == 0) {
        SQ1.text = [[SQArray1 objectAtIndex:[indexPath row]] objectForKey:@"securityQuestion"];
        [bgview removeFromSuperview];
    }
    else if ([tableView tag] == 1) {
        SQ2.text = [[SQArray2 objectAtIndex:[indexPath row]] objectForKey:@"securityQuestion"];
        [bgview removeFromSuperview];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Pickerview Delegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([pickerView tag] == 1) {
        [SQ1Label setHidden:NO];
        SQArray1 = [SecurityQuestion mutableCopy];
        for (int i = 0; i < [SecurityQuestion count]; i++) {
            if ([[SQ2 text] isEqualToString:[[SecurityQuestion objectAtIndex:i] objectForKey:@"securityQuestion"]]) {
                [SQArray1 removeObjectAtIndex:i];
            }
        }
        
        return [SQArray1 count];
    }
    else if([pickerView tag] == 2) {
        [SQ2Label setHidden:NO];
        SQArray2 = [SecurityQuestion mutableCopy];
        for (int i = 0; i < [SecurityQuestion count]; i++) {
            if ([[SQ1 text] isEqualToString:[[SecurityQuestion objectAtIndex:i] objectForKey:@"securityQuestion"]]) {
                [SQArray2 removeObjectAtIndex:i];
            }
        }
        
        return [SQArray2 count];
    }
    else if([pickerView tag] == 3) {
        return [TypeID count];
    }
    
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([pickerView tag] == 1) {
        return [[SQArray1 objectAtIndex:row] objectForKey:@"securityQuestion"];
    }
    else if([pickerView tag] == 2) {
        return [[SQArray2 objectAtIndex:row] objectForKey:@"securityQuestion"];
    }
    else if([pickerView tag] == 3) {
        return [[TypeID objectAtIndex:row] objectForKey:@"idTypeName"];
    }
    
    return 0;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if ([pickerView tag] == 1) {
        if ([pickerView selectedRowInComponent:0] == row) {
            SQ1.text = [[SQArray1 objectAtIndex:row] objectForKey:@"securityQuestion"];
        }
    }
    else if([pickerView tag] == 2) {
        if ([pickerView selectedRowInComponent:0] == row) {
            SQ2.text = [[SQArray2 objectAtIndex:row] objectForKey:@"securityQuestion"];
        }
    }
    else if([pickerView tag] == 3) {
        if ([pickerView selectedRowInComponent:0] == row) {
            IDType.text = [[TypeID objectAtIndex:row] objectForKey:@"idTypeName"];
        }
    }
}

#pragma mark - TextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.view addGestureRecognizer:tapRecognizer];
    [scrollView setContentOffset:CGPointMake(0, [textField layer].frame.origin.y-[self view].frame.size.height/4) animated:NO];
    if ([textField isFirstResponder]) {
        [scrollView setFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-270)];
    }
    
    if ([textField tag] == 2) {
        
    } else if ([textField tag] == 3) {
        [SQ2 setHidden:NO];
        [scrollView addSubview:[self UIImage:self withFrame:CGRectMake(SQ2.frame.size.width, SQ2.frame.origin.y+10, 12, 10) withImageName:@"arrowdown.png"]];
        SQArray2 = [SecurityQuestion mutableCopy];
        for (int i = 0; i < [SecurityQuestion count]; i++) {
            if ([[SQ1 text] isEqualToString:[[SecurityQuestion objectAtIndex:i] objectForKey:@"securityQuestion"]]) {
                [SQArray2 removeObjectAtIndex:i];
            }
        }
    } else if ([textField tag] == 4) {
        [AN2 setHidden:NO];
        if ([[SQ2 text] length] <= 0) {
            SQ2.text = [[SQArray2 objectAtIndex:0] objectForKey:@"securityQuestion"];
        }else {
            SQArray2 = [SecurityQuestion mutableCopy];
            for (int i = 0; i < [SecurityQuestion count]; i++) {
                if ([[SQ1 text] isEqualToString:[[SecurityQuestion objectAtIndex:i] objectForKey:@"securityQuestion"]]) {
                    [SQArray2 removeObjectAtIndex:i];
                }
            }
            
            for (int i = 0; i < [SQArray2 count]; i++) {
                if ([[SQ2 text] isEqualToString:[[SQArray2 objectAtIndex:i] objectForKey:@"securityQuestion"]]) {
                    [Picker2 selectRow:i inComponent:0 animated:NO];
                }
            }
        }
    } else if ([textField tag] == 5) {
        [next setHidden:NO];
    } else if ([textField tag] == 6) {
        [ID setText:@""];
        [IDTypeLabel setHidden:NO];
        if ([[IDType text] length] <= 0) {
            IDType.text = [[TypeID objectAtIndex:0] objectForKey:@"idTypeName"];
        }
    } else if ([textField tag] == 7) {
        if ([[IDType text] isEqualToString:@"KTP"]) {
            [ID setKeyboardType:UIKeyboardTypeNumberPad];
        } else {
            [ID setKeyboardType:UIKeyboardTypeDefault];
        }
        [AN1 setHidden:NO];
        [SQ1Label setHidden:YES];
        if ([[SQ1 text] length] <= 0) {
            SQ1.text = [[SQArray1 objectAtIndex:0] objectForKey:@"securityQuestion"];
        } else {
            SQArray1 = [SecurityQuestion mutableCopy];
            for (int i = 0; i < [SecurityQuestion count]; i++) {
                if ([[SQ2 text] isEqualToString:[[SecurityQuestion objectAtIndex:i] objectForKey:@"securityQuestion"]]) {
                    [SQArray1 removeObjectAtIndex:i];
                }
            }
            
            for (int i = 0; i < [SQArray1 count]; i++) {
                if ([[SQ1 text] isEqualToString:[[SQArray1 objectAtIndex:i] objectForKey:@"securityQuestion"]]) {
                    [Picker1 selectRow:i inComponent:0 animated:NO];
                }
            }
        }
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.view removeGestureRecognizer:tapRecognizer];
    if (![textField isFirstResponder]) {
        [scrollView setFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
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
        
        //Field FN
        if (newLength > 0 && [[LN text] length] > 0 && [[SQ1 text] length] > 0 && [[AN1 text] length] > 0 && [[SQ2 text] length] > 0 && [[AN2 text] length] > 0 && [[IDType text] length] > 0 && [[ID text] length] > 0) {
            [next setEnabled:YES];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [next setEnabled:NO];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        
        if (newLength > 0) {
            [FNLabel setHidden:NO];
            [self removeValidationIcon:FN withColor:nil];
        } else {
            [FNLabel setHidden:YES];
        }
        return newLength <= 20;
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
        //Field LN
        if (newLength > 0 && [[FN text] length] > 0 && [[SQ1 text] length] > 0 && [[AN1 text] length] > 0 && [[SQ2 text] length] > 0 && [[AN2 text] length] > 0 && [[IDType text] length] > 0 && [[ID text] length] > 0) {
            [next setEnabled:YES];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [next setEnabled:NO];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        
        if (newLength > 0) {
            [LNLabel setHidden:NO];
            [self removeValidationIcon:LN withColor:nil];
        } else {
            [LNLabel setHidden:YES];
        }
        return newLength <= 20;
    } else if([textField tag] == 2) {
        //Field SQ1
        if (newLength > 0 && [[FN text] length] > 0 && [[LN text] length] > 0 && [[AN1 text] length] > 0 && [[SQ2 text] length] > 0 && [[AN2 text] length] > 0 && [[IDType text] length] > 0 && [[ID text] length] > 0) {
            [next setEnabled:YES];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [next setEnabled:NO];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
    } else if([textField tag] == 3) {
        //Field AN1
        if (newLength > 0 && [[LN text] length] > 0 && [[SQ1 text] length] > 0 && [[FN text] length] > 0 && [[SQ2 text] length] > 0 && [[AN2 text] length] > 0 && [[IDType text] length] > 0 && [[ID text] length] > 0) {
            [next setEnabled:YES];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [next setEnabled:NO];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        
        if (newLength > 0) {
            [AN1Label setHidden:NO];
            [self removeValidationIcon:AN1 withColor:nil];
        } else {
            [AN1Label setHidden:YES];
        }
        return newLength <= 20;
    } else if([textField tag] == 4) {
        //Field SQ2
        if (newLength > 0 && [[FN text] length] > 0 && [[LN text] length] > 0 && [[AN1 text] length] > 0 && [[SQ1 text] length] > 0 && [[AN2 text] length] > 0 && [[IDType text] length] > 0 && [[ID text] length] > 0) {
            [next setEnabled:YES];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [next setEnabled:NO];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
    } else if([textField tag] == 5) {
        //Field AN2
        if (newLength > 0 && [[LN text] length] > 0 && [[SQ1 text] length] > 0 && [[AN1 text] length] > 0 && [[SQ2 text] length] > 0 && [[FN text] length] > 0 && [[IDType text] length] > 0 && [[ID text] length] > 0) {
            [next setEnabled:YES];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [next setEnabled:NO];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        
        if (newLength > 0) {
            [AN2Label setHidden:NO];
            [self removeValidationIcon:AN2 withColor:nil];
        } else {
            [AN2Label setHidden:YES];
        }
        return newLength <= 20;
    } else if([textField tag] == 6) {
        //Field IDType
        if (newLength > 0 && [[LN text] length] > 0 && [[SQ1 text] length] > 0 && [[AN1 text] length] > 0 && [[AN2 text] length] > 0 && [[SQ2 text] length] > 0 && [[FN text] length] > 0 && [[ID text] length] > 0) {
            [next setEnabled:YES];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [next setEnabled:NO];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        
        if (newLength > 0) {
            [IDTypeLabel setHidden:NO];
            [self removeValidationIcon:IDType withColor:nil];
        } else {
            [IDTypeLabel setHidden:YES];
        }
    } else if([textField tag] == 7) {
        //Field ID
        if (newLength > 0 && [[LN text] length] > 0 && [[SQ1 text] length] > 0 && [[AN1 text] length] > 0 && [[AN2 text] length] > 0 && [[SQ2 text] length] > 0 && [[FN text] length] > 0 && [[IDType text] length] > 0) {
            [next setEnabled:YES];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:1.0]];
        } else {
            [next setEnabled:NO];
            [next setBackgroundColor:[self colorFromHexString:Color3 withAlpha:0.5]];
        }
        
        if (newLength > 0) {
            [IDLabel setHidden:NO];
            [self removeValidationIcon:ID withColor:nil];
        } else {
            [IDLabel setHidden:YES];
        }
        return newLength <= 20;
    }
    return YES;
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissViewControllerAnimated:NO completion:nil];
}

#pragma Request API
//-(void)RequestAPIValidateMobileNoECash {
//    [[self view] endEditing:YES];
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"ValidateMobileNoECash" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[PCFingerPrint checkTouchIdSupport] ? @"Y": @"N", @"isTouchID", nil]];
////        NSLog(@"Validate E-Cash = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                GlobalVariable *GV = [GlobalVariable sharedInstance];
//                GV.haveEcash = [[response objectForKey:@"params"] objectForKey:@"haveECash"];
//                if ([[[response objectForKey:@"params"] objectForKey:@"haveECash"] isEqualToString:@"N"]) {
//                    [self RequestAPIRequestOTP];
//                }
//                else {
//                    [self performSegueWithIdentifier:@"VerifyEcashPIN" sender:self];
//                }
//            }
//            else
//            {
//                [maskView removeFromSuperview];
//                if ([[response objectForKey:@"message"] isEqualToString:@"MW - 02X"]) {
//                    [view setHidden:NO];
////                    [self showAlert2:L(@"popUpDownloadEcash") title:L(@"popUpDownloadEcashTitle") btn1:L(@"cancel") btn2:L(@"downloadEcash") tag:2 delegate:self];
//                }
//                else if ([[response objectForKey:@"message"] containsString:@"||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:0 delegate:self];
//                } else {
//                    [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                }
//            }
//        });
//    });
//}

//-(void)RequestAPIRequestOTP {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"RequestOTP" withParams:[NSDictionary dictionaryWithObjectsAndKeys:DEVICETOKEN, @"deviceToken", [[response objectForKey:@"params"] objectForKey:@"haveECash"], @"haveECash", @"N", @"resendFlag", @"register", @"view", nil]];
////        NSLog(@"Request OTP = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self performSegueWithIdentifier:@"Verification" sender:self];
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

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
}

-(IBAction)prepareForUnwindToRegister:(UIStoryboardSegue *)segue {
}

@end
