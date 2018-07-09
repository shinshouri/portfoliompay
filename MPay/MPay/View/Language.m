//
//  Language.m
//  MPay
//
//  Created by Admin on 11/25/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "Language.h"
#import "Login.h"

@implementation Language
{
    NSArray *list;
    UITableView *table;
    UILabel *lbl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
}

- (void)UI {
//    [[self navigationItem] setTitle:L(@"language")];
    list = [[NSArray alloc] initWithObjects:@"english", @"indonesian", nil];
    lbl =[self UILabel:self withFrame:CGRectMake(10, 65, self.view.frame.size.width-20, 30) withText:@"selectYourLanguage" withTextSize:textsize16 withAlignment:0 withLines:0];
    [lbl setFont:[UIFont boldSystemFontOfSize:textsize24]];
    [[self view] addSubview:lbl];
    
    UIView *line = [self UIView:self withFrame:CGRectMake(0, 110, [self view].frame.size.width, 1)];
    [line setBackgroundColor:[self colorFromHexString:@"#E7E7E7" withAlpha:1.0]];
    [[self view] addSubview:line];
    
    table = [self UITableView:self withFrame:CGRectMake(0, 111, self.view.frame.size.width, [self view].frame.size.height-111) withStyle:0];
    [table setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    [[table layer] setCornerRadius:10];
    [[self view] addSubview:table];
}

-(void)Act:(id)sender {
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
    
    if([[defaults objectForKey:@"language"] isEqualToString:@"en"])
    {
        if ([indexPath row] == 0) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.textLabel.textColor = [self colorFromHexString:Color3 withAlpha:1.0];
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.textColor = [self colorFromHexString:Color2 withAlpha:1.0];
        }
    }
    else
    {
        if ([indexPath row] == 1) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.textLabel.textColor = [self colorFromHexString:Color3 withAlpha:1.0];
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.textColor = [self colorFromHexString:Color2 withAlpha:1.0];
        }
    }
    
    return cell;
}

#pragma mark - Tableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([indexPath row] == 0) {
        [defaults setObject:@"en" forKey:@"language"];
    } else if ([indexPath row] == 1) {
        [defaults setObject:@"id" forKey:@"language"];
    }
    [lbl removeFromSuperview];
    [table removeFromSuperview];
    [self UI];
//    [self RequestAPIChangeLanguage];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self view].frame.size.height/10;
}

//-(void)RequestAPIChangeLanguage {
//    [[self navigationController].view addSubview:[self showmask]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"ChangeLanguage" withParams:nil];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
