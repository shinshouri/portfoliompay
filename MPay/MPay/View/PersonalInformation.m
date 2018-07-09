//
//  PersonalInformation.m
//  MPay
//
//  Created by Admin on 7/20/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "PersonalInformation.h"
#import "Login.h"
#import <Photos/Photos.h>

@implementation PersonalInformation
{
    UIView *CPView;
    NSArray *list;
    UIImageView *img;
    BOOL flag;
    NSString *imagebase64;
    NSData *imageData;
}
@synthesize table, data;

- (void)viewDidLoad {
    [super viewDidLoad];
    list = [[NSArray alloc] initWithObjects:@"name", @"mobileNumber", @"dayOfBirth", nil];
    [self UI];
}

-(void)viewWillAppear:(BOOL)animated {
//    [[self navigationItem] setTitle:L(@"personalInformation")];
}

- (void)UI {
    flag = TRUE;
    img = [self UIImage:self withFrame:CGRectMake(([self view].frame.size.width/2)-40, 80, 80, 80) withImageName:@"default.png"];
    [img setClipsToBounds:YES];
    [img setContentMode:UIViewContentModeScaleAspectFill];
    [[img layer] setCornerRadius:40];
    [[img layer] setBorderWidth:2.0f];
    [[img layer] setBorderColor:[UIColor whiteColor].CGColor];
    NSURL *url = [NSURL URLWithString:[data objectForKey:@"imageProfile"]];
    imageData = [NSData dataWithContentsOfURL:url];
    if (imageData) {
        [img setImage:[UIImage imageWithData:imageData]];
    } else {
        [img setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"default.png"]]];
    }
    [[self view] addSubview:img];
    
    UILabel *lbl = [self UILabel:self withFrame:CGRectMake(([self view].frame.size.width/2)-([self view].frame.size.width/4), 160, [self view].frame.size.width/2, 50) withText:@"changePhoto" withTextSize:textsize16 withAlignment:1 withLines:0];
    [lbl setTextColor:[self colorFromHexString:Color1 withAlpha:1.0]];
    [[self view] addSubview:lbl];
    [[self view] addSubview:[self UIButton:self withFrame:CGRectMake(([self view].frame.size.width/2)-([self view].frame.size.width/4), 70, [self view].frame.size.width/2, 140) withTitle:@"" withTag:0]];
    
    UIView *line = [self UIView:self withFrame:CGRectMake(0, 210, [self view].frame.size.width, 1)];
    [line setBackgroundColor:[self colorFromHexString:@"#E7E7E7" withAlpha:1.0]];
    [[self view] addSubview:line];
    
    table = [self UITableView:self withFrame:CGRectMake(0, 211, self.view.frame.size.width, self.view.frame.size.height-211) withStyle:0];
    [table setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    [[table layer] setCornerRadius:10];
    table.allowsSelection = NO;
    [[self view] addSubview:table];
    //Popup Change Photo
    CPView = [self UIView:self withFrame:CGRectMake(0, 0, [self view].frame.size.width, [self view].frame.size.height)];
    [CPView setBackgroundColor:[self transparentBlack]];
    
    UIView *pop = [self UIView:self withFrame:CGRectMake(0, CPView.frame.size.height-100, CPView.frame.size.width, 100)];
    [pop setBackgroundColor:[UIColor whiteColor]];
    [[pop layer] setCornerRadius:10];
    
    UIButton *Camera = [self UIButton:self withFrame:CGRectMake(0, pop.frame.size.height-100, pop.frame.size.width, 50) withTitle:@"camera" withTag:1];
    [Camera setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[Camera layer] setBorderWidth:0.5];
    [[Camera layer] setBorderColor:[UIColor blackColor].CGColor];
    [pop addSubview:Camera];
    UIButton *Galery = [self UIButton:self withFrame:CGRectMake(0, pop.frame.size.height-50, pop.frame.size.width, 50) withTitle:@"gallery" withTag:2];
    [Galery setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[Galery layer] setBorderWidth:0.5];
    [[Galery layer] setBorderColor:[UIColor blackColor].CGColor];
    [pop addSubview:Galery];
    
    [CPView addSubview:pop];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Opt)];
    [CPView addGestureRecognizer:tap];
    
    [CPView setHidden:YES];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
//        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//            switch (status) {
//                case PHAuthorizationStatusAuthorized:
//                {
//                    [[self navigationController].view addSubview:[self showmask]];
//
//                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                        [PCUtils openGallery:self andCallback:^(NSString *base64, NSString *path) {
//                            if ([base64 length] > 0) {
//                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                                    NSURL *url = [NSURL URLWithString:base64];
//                                    imageData = [NSData dataWithContentsOfURL:url];
//                                    dispatch_async(dispatch_get_main_queue(), ^{
//                                        [maskView removeFromSuperview];
//                                        imagebase64 = base64;
//                                        [self RequestAPIChangePhoto];
//                                    });
//                                });
//                            } else {
//                                [maskView removeFromSuperview];
//                            }
//                        }];
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                        });
//                    });
//                }
//                    break;
//
//                case PHAuthorizationStatusDenied:
//                {
//                    [self showAlert:L(@"pleaseAllowPermission") title:L(@"message") btn:L(@"ok") tag:0 delegate:self];
//                }
//                    break;
//
//                case PHAuthorizationStatusRestricted:
//                {
//                    NSLog(@"Restricted");
//                }
//                    break;
//
//                case PHAuthorizationStatusNotDetermined:
//                {
//                    NSLog(@"NOT Determined");
//                }
//                    break;
//
//                default:
//                    break;
//            }
//        }];
    }
    else if([sender tag] == 1)
    {
        //Camera
        [self Opt];
    }
    else if([sender tag] == 2)
    {
        //Galery
//        [[self navigationController].view addSubview:[self showmask]];
//        [self Opt];
//        [PCUtils openGallery:self andCallback:^(NSString *base64, NSString *path) {
//            if ([base64 length] > 0) {
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    NSURL *url = [NSURL URLWithString:base64];
//                    imageData = [NSData dataWithContentsOfURL:url];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [maskView removeFromSuperview];
//                        imagebase64 = base64;
//                        [self RequestAPIChangePhoto];
//                    });
//                });
//            } else {
//                [maskView removeFromSuperview];
//            }
//        }];
    }
}

-(void)Opt {
    if(!flag) {
        [CPView setHidden:YES];
        flag = TRUE;
    }
    else
    {
        [CPView setHidden:NO];
        flag = FALSE;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if ([indexPath row] == 0) {
        cell.textLabel.text = [list objectAtIndex:[indexPath row]];
        cell.detailTextLabel.text = [data objectForKey:@"customerName"];
    }
    else if ([indexPath row] == 1) {
        cell.textLabel.text = [list objectAtIndex:[indexPath row]];
        cell.detailTextLabel.text = [data objectForKey:@"customerMobileNo"];
    }
    else if ([indexPath row] == 2) {
        cell.textLabel.text = [list objectAtIndex:[indexPath row]];
        cell.detailTextLabel.text = [data objectForKey:@"dateOfBirth"];
    }
    
    cell.textLabel.textColor = [self colorFromHexString:@"#6E6E6E" withAlpha:1.0];
    cell.detailTextLabel.textColor = [self colorFromHexString:@"#6E6E6E" withAlpha:1.0];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:[self view].frame.size.height > 568 ? 18 : 16];
    
    return cell;
}

#pragma mark - Tableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self view].frame.size.height/8;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 0) {
        if(buttonIndex == 1)
        {
            
        }
    }
}

//-(void)RequestAPIChangePhoto {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"ChangePhoto" withParams:[NSDictionary dictionaryWithObjectsAndKeys:imagebase64,@"image", nil]];
////        NSLog(@"Change Photo = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [img setImage:[UIImage imageWithData:imageData]];
//                [defaults setObject:@"ChangePhoto" forKey:@"Change"];
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

@end
