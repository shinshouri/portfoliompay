//
//  Settings.m
//  MPay
//
//  Created by Admin on 7/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "Settings.h"
#import "Login.h"
#import "SourceofFund.h"
#import "PersonalInformation.h"
#import "AccountAndSecurity.h"

@implementation Settings
{
    NSArray *list;
    NSDictionary *data;
    UIImageView *img;
    UIView *bgview;
}
@synthesize table;

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![defaults objectForKey:@"Change"]) {
        if ([defaults objectForKey:@"PersonalInfo"]) {
            data = [defaults objectForKey:@"PersonalInfo"];
            [self UI];
        } else {
//            [self RequestAPIGetPersonalInformation];
            [self UI];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [self navigationController].navigationBar.barStyle = UIBarStyleDefault;
    [bgimage setImage:[UIImage imageNamed:@"bgwhite.png"]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[self colorFromHexString:Color1 withAlpha:1.0]}];
    [[[self navigationController] navigationBar] setTintColor:[self colorFromHexString:Color1 withAlpha:1.0]];
    
    list = [[NSArray alloc] initWithObjects:@"sourceOfFund", @"personalInformation", @"accountAndSecurity", @"language", @"help", @"termsAndConditions", @"logout", nil];
    [table reloadData];
    if ([defaults objectForKey:@"Change"]) {
        [defaults removeObjectForKey:@"Change"];
//        [self RequestAPIGetPersonalInformation];
        [self UI];
    }
    [[self tabBarController] setTitle:@"settings"];
    [[[self tabBarController] tabBar] setBackgroundColor:[self colorFromHexString:Color0 withAlpha:1.0]];
    [[[[self tabBarController] tabBar] layer] setBorderWidth:1.0];
    [[[[self tabBarController] tabBar] layer] setBorderColor:[self colorFromHexString:Color4 withAlpha:0.5].CGColor];
    [[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:@"wallet"];
    UIImage *icon1 = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"wallet.png"]];
//    icon1 = [icon1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[self.tabBarController.tabBar.items objectAtIndex:0] setImage:icon1];
    [[self.tabBarController.tabBar.items objectAtIndex:1] setTitle:@"scanQr"];
    UIImage *icon2 = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"scan.png"]];
//    icon2 = [icon2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[self.tabBarController.tabBar.items objectAtIndex:1] setImage:icon2];
    [[self.tabBarController.tabBar.items objectAtIndex:2] setTitle:@"settings"];
    UIImage *icon3 = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"setting.png"]];
//    icon3 = [icon3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[self.tabBarController.tabBar.items objectAtIndex:2] setImage:icon3];
    [[[self tabBarController] tabBar] setTintColor:[self colorFromHexString:Color10 withAlpha:1.0]];
    
    UIBarButtonItem * addButton = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:nil];
    [self tabBarController].navigationItem.rightBarButtonItem = addButton;
}

- (void)UI {
    img = [self UIImage:self withFrame:CGRectMake(([self view].frame.size.width/2)-(([self view].frame.size.width/5)/2), 80, [self view].frame.size.width/5, [self view].frame.size.width/5) withImageName:@"default.png"];
    [img setClipsToBounds:YES];
    [img setContentMode:UIViewContentModeScaleAspectFill];
    [[img layer] setCornerRadius:([self view].frame.size.width/5)/2];
    [[img layer] setBorderWidth:2.0f];
    [[img layer] setBorderColor:[UIColor whiteColor].CGColor];
    NSURL *url = [NSURL URLWithString:[data objectForKey:@"imageProfile"]];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    if (imageData) {
        [img setImage:[UIImage imageWithData:imageData]];
    } else {
        [img setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"default.png"]]];
    }
    [[self view] addSubview:img];
    
    [[self view] addSubview:[self UILabel:self withFrame:CGRectMake(20, ([self view].frame.size.width/4)+90, [self view].frame.size.width-40, 20) withText:[data objectForKey:@"customerName"] withTextSize:14 withAlignment:1 withLines:0]];
    
    bgview = [self UIView:self withFrame:CGRectMake(0, ([self view].frame.size.width/4)+140, self.view.frame.size.width, [self view].frame.size.height-(([self view].frame.size.width/4)+140))];
    [bgview setClipsToBounds:YES];
    
    [bgview addSubview:[self UIView:self withFrame:CGRectMake(0, 0, self.view.frame.size.width, 1)]];
    
    table = [self UITableView:self withFrame:CGRectMake(0, 1, self.view.frame.size.width, bgview.frame.size.height-49) withStyle:0];
    [table setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    [bgview addSubview:table];
    
    [[self view] addSubview:bgview];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        
    }
}

#pragma mark - Segue Delegate
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SourceFund"]) {
        SourceofFund *NVC = [segue destinationViewController];
        NVC.CardList = [[[response objectForKey:@"params"] objectForKey:@"sourceOfFundList"] mutableCopy];
    }
    else
    if ([[segue identifier] isEqualToString:@"PersonalInfo"]) {
        PersonalInformation *NVC = [segue destinationViewController];
        NVC.data = [data mutableCopy];
    }
    else
    if ([[segue identifier] isEqualToString:@"AccAndSec"]) {
        AccountAndSecurity *NVC = [segue destinationViewController];
        NVC.data = [data mutableCopy];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [list objectAtIndex:[indexPath row]];
    cell.textLabel.textColor = [self colorFromHexString:@"#6E6E6E" withAlpha:1.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Tableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
//        [self RequestAPIGetSourceOfFundList];
        [self performSegueWithIdentifier:@"SourceFund" sender:self];
    }
    else
    if ([indexPath row] == 1) {
        self.tabBarController.title = @"";
        [self performSegueWithIdentifier:@"PersonalInfo" sender:self];
    }
    else
    if ([indexPath row] == 2) {
        self.tabBarController.title = @"";
        [self performSegueWithIdentifier:@"AccAndSec" sender:self];
    }
    else
    if ([indexPath row] == 3) {
        self.tabBarController.title = @"";
        [self performSegueWithIdentifier:@"Language" sender:self];
    }
    else
    if ([indexPath row] == 4) {
        self.tabBarController.title = @"";
        [self performSegueWithIdentifier:@"FAQ" sender:self];
    }
    else
    if ([indexPath row] == 5) {
        self.tabBarController.title = @"";
        [defaults setObject:@"Settings" forKey:@"ViewController"];
        [self performSegueWithIdentifier:@"Terms" sender:self];
    }
    else
    if ([indexPath row] == 6) {
        [self showAlert2:@"confirmLogout" title:@"logout" btn1:@"cancel" btn2:@"logout" tag:0 delegate:self];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self view].frame.size.height/10;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 0) {
        if(buttonIndex == 1)
        {
//            [self RequestAPILogout];
            [defaults setObject:@"N" forKey:@"StatusLogin"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
            [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            [[self navigationController] presentViewController:myVC animated:NO completion:nil];
        }
    } else if ([alertView tag] == 1) {
        if(buttonIndex == 0)
        {
            if ([[defaults objectForKey:@"StatusLogin"] isEqualToString:@"Y"]) {
//                [self RequestAPIGetPersonalInformation];
            }
        }
    }
}

//-(void)RequestAPIGetSourceOfFundList {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"GetSourceOfFundList" withParams:nil];
////        NSLog(@"Source Fund = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                self.tabBarController.title = @"";
//                [self performSegueWithIdentifier:@"SourceFund" sender:self];
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

//-(void)RequestAPIGetPersonalInformation {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetPersonalInformation" withParams:nil];
////        NSLog(@"Personal Info = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"tryAgain") tag:1 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults setObject:[response objectForKey:@"params"] forKey:@"PersonalInfo"];
//                data = [response objectForKey:@"params"];
//                GlobalVariable *GV = [GlobalVariable sharedInstance];
//                GV.ImageBase64 = [data objectForKey:@"imageProfile"];
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
//                [self UI];
//                if ([[response objectForKey:@"message"] containsString:@"||||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:1 delegate:self];
//                } else if ([[response objectForKey:@"message"] containsString:@"||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:1 delegate:self];
//                } else {
//                    [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"tryAgain") tag:1 delegate:self];
//                }
//
//            }
//        });
//    });
//}

//-(void)RequestAPILogout {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
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
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
//                [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//                [[self navigationController] presentViewController:myVC animated:NO completion:nil];
//            }
//            else if([[response objectForKey:@"logout"] intValue] == 1)
//            {
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

@end
