//
//  Wallet.m
//  MPay
//
//  Created by Admin on 7/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "Wallet.h"
#import "AddCard.h"
#import "TransHistory.h"
#import "Login.h"
#import "PushPassword.h"
#import "TGLCollectionViewCell.h"
#import <AVFoundation/AVFoundation.h>

@implementation Wallet
{
    BOOL ST;
    NSString *CardId, *CardType, *CardSelect, *CardFinance;
    UIButton *btn;
    UIView *mask, *bgview;
    NSMutableArray *CL;
    NSMutableArray *CardList, *CardListTrans;
    int j;
}
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [defaults setObject:[NSString stringWithFormat:@"%f", [self view].frame.size.height/3] forKey:@"CardHeight"];
}

-(void)viewWillAppear:(BOOL)animated {
    [bgimage setImage:[UIImage imageNamed:@"bgwhite.png"]];
    
    [[self tabBarController] setTitle:@"cardList"];
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
    
    [self navigationController].navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[self colorFromHexString:Color1 withAlpha:1.0]}];
    [[[self navigationController] navigationBar] setTintColor:[self colorFromHexString:Color1 withAlpha:1.0]];
    
    UIBarButtonItem * addButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"Plus.png"]] style:UIBarButtonItemStylePlain target:self action:@selector(Add)];
    [self tabBarController].navigationItem.rightBarButtonItem = addButton;
}

-(void)viewDidAppear:(BOOL)animated {
//    [self RequestAPIGetAllCardList];
    CardList = [[NSMutableArray alloc] initWithObjects:@"credit.png", @"debit.png", @"ecash.png", @"master.png", @"visa.png", nil];
    [defaults setObject:CardList forKey:@"CardList"];
    [self UI];
}

-(void)dealloc {
    [UIImage dealloc];
    scrollView = nil;
}

- (void)UI {
    [bgview removeFromSuperview];
    bgview = [self UIView:self withFrame:CGRectMake(0, 70, self.view.frame.size.width, self.view.frame.size.height-70)];
    [bgview setBackgroundColor:[UIColor clearColor]];
    [[bgview layer] setCornerRadius:10];
    
    UIView *cardview = [self UIView:self withFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-70)];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *viewController = nil;
    
    viewController = [storyBoard instantiateViewControllerWithIdentifier:@"CardListView"];
    TGLViewController *vcb = (TGLViewController *) viewController;
    vcb.delegate = self;
    
    // lets add it to container view
//    [viewController willMoveToParentViewController:self];
    [self addChildViewController:viewController];
    [cardview addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    
    [bgview addSubview:cardview];
    [[self view] addSubview:bgview];
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
    
    }];
}

-(void)Act:(id)sender {
    if([sender tag] > 0)
    {
        
    }
}

-(void)Add {
    if ([CardList count] >= [@"11" intValue]) {
        [self showAlert:@"errorMaxAddCard" title:@"errorMaxAddCardTitle" btn:@"ok" tag:0 delegate:self];
    } else {
        self.tabBarController.title = @"";
        [self performSegueWithIdentifier:@"ScanCard" sender:self];
    }
}

-(void)linkTopUp {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://mandiriecash.co.id/home/gampang-isi-ecash/"]];
}

-(void)linkUSSD {
//    NSString *message = L(@"copyUSSD");
//
//    UILabel *toast = [[UILabel alloc] initWithFrame:CGRectMake([self view].frame.size.width/4, ([self view].frame.size.height/4)*3, [self view].frame.size.width/2, 40)];
//    [toast setText:message];
//    [toast setBackgroundColor:[self transparentBlack]];
//    [toast setTextColor:[UIColor whiteColor]];
//    [toast setTextAlignment:NSTextAlignmentCenter];
//    [toast layer].masksToBounds = YES;
//    [[toast layer] setCornerRadius:20];
//    [[self view] addSubview:toast];
//
//    int duration = 1; // duration in seconds
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
////        [toast dismissWithClickedButtonIndex:0 animated:YES];
//        [toast removeFromSuperview];
//    });
    
    [self showAlert2:@"ecashMenuDesc" title:@"ecashMenuTitle" btn1:@"cancel" btn2:@"copyUSSDNo" tag:2 delegate:self];
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
}

#pragma mark - Alertview Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) {
        if(buttonIndex == 0)
        {
            if ([[defaults objectForKey:@"StatusLogin"] isEqualToString:@"Y"]) {
//                [self RequestAPIGetAllCardList];
            }
        }
    } else if ([alertView tag] == 2) {
        if(buttonIndex == 1)
        {
            UIPasteboard *pb = [UIPasteboard generalPasteboard];
            [pb setString:[NSString stringWithFormat:@"%@%@", @"noUSSD", @"#"]];
        }
    }
}

#pragma mark - Animation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}

#pragma mark - Segue Delegate
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"TransHistory"]) {
        TransHistory *NVC = [segue destinationViewController];
        NVC.CardList = [CardList mutableCopy];
        NVC.Response = [response mutableCopy];
        NVC.CardSelect = CardSelect;
        NVC.CardListTrans =  CardListTrans;
    }
}

#pragma mark - UICollectionViewDataSource protocol
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [CardList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TGLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CardCell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:[[CardList objectAtIndex:[indexPath row]] objectForKey:@"cardType"]];
    [cell.imageView.layer setCornerRadius:10];
    [cell.imageView.layer setMasksToBounds:YES];
    
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([[[CardList objectAtIndex:[indexPath row]] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
        if ([[[CardList objectAtIndex:[indexPath row]] objectForKey:@"cardBalance"] rangeOfCharacterFromSet:notDigits].location == NSNotFound)
        {
            cell.nameLabel.text = @"myBalance";
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[cell.nameLabel text]];
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [[cell.nameLabel text] length])];
            [cell.nameLabel setAttributedText:attributedString];
            cell.Balance.text = [NSString stringWithFormat:@"%@%@", [[defaults objectForKey:@"language"] isEqualToString:@"id"] ? @"Rp" : @"IDR", [self FormatNumber:self from:[[CardList objectAtIndex:[indexPath row]] objectForKey:@"cardBalance"]]];
            
            [cell.linkbtn addTarget:self action:@selector(linkTopUp) forControlEvents:UIControlEventTouchUpInside];
        } else {
            cell.nameLabel.text = @"myBalance";
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[cell.nameLabel text]];
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [[cell.nameLabel text] length])];
            [cell.nameLabel setAttributedText:attributedString];
            cell.Balance.text = [[CardList objectAtIndex:[indexPath row]] objectForKey:@"cardBalance"];
        }
        
        if ([self view].frame.size.height <= 568) {
            [cell.USSD setFrame:CGRectMake(220, 20, 90, 30)];
        }
        [cell.USSD setTitle:@"titleUSSD" forState:UIControlStateNormal];
        [cell.USSD setTitleColor:[self colorFromHexString:Color11 withAlpha:1.0] forState:UIControlStateNormal];
        [cell.USSD setBackgroundColor:[UIColor whiteColor]];
        [[cell.USSD layer] setCornerRadius:[self view].frame.size.height > 568 ? 18 : 15];
        [cell.USSD addTarget:self action:@selector(linkUSSD) forControlEvents:UIControlEventTouchUpInside];
        
        cell.dot1.image = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"dot.png"]];
        cell.dot2.image = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"dot.png"]];
        cell.dot3.image = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"dot.png"]];
        cell.dot4.image = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"dot.png"]];
        cell.CardNumber.text = [[CardList objectAtIndex:[indexPath row]] objectForKey:@"cardNumberMasking"];
        
    } else {
        cell.dot1.image = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"dot.png"]];
        cell.dot2.image = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"dot.png"]];
        cell.dot3.image = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"dot.png"]];
        cell.dot4.image = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"dot.png"]];
        cell.CardNumber.text = [[CardList objectAtIndex:[indexPath row]] objectForKey:@"cardNumberMasking"];
        
        cell.ExpDate.text = [NSString stringWithFormat:@"%@ %@", @"EXP", [[CardList objectAtIndex:[indexPath row]] objectForKey:@"cardExp"]] ;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CardSelect = [NSString stringWithFormat:@"%li", (long)[indexPath row]];
    
    j = 0;
    CardListTrans = [[NSMutableArray alloc] init];
    [[self navigationController].view addSubview:[self showmask]];
    CardId = [[CardList objectAtIndex:j] objectForKey:@"cardId"];
    CardType = [[CardList objectAtIndex:j] objectForKey:@"cardType"];
    CardFinance = [[CardList objectAtIndex:j] objectForKey:@"cardFinancial"];
//    [self RequestAPIGetListTransactionHistory];
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // Update data source when moving cards around
    NSDictionary *card = CardList[sourceIndexPath.item];
    
    [CardList removeObjectAtIndex:sourceIndexPath.item];
    [CardList insertObject:card atIndex:destinationIndexPath.item];
    
    if ([sourceIndexPath row] == [CardList count]-1 || [destinationIndexPath row] == [CardList count]-1) {
//        [self RequestAPISetDefaultCard];
    } else {
        [self UI];
    }
}

//-(void)RequestAPIGetAllCardList {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"GetAllCardList" withParams:nil];
////        NSLog(@"CardList = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"tryAgain") tag:1 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                CardList = [[[response objectForKey:@"params"] objectForKey:@"listUserCard"] mutableCopy];
//                [defaults setObject:CardList forKey:@"CardList"];
//                [maskView removeFromSuperview];
//                [scrollView removeFromSuperview];
//                [self UI];
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
//            else if([[response objectForKey:@"ok"] intValue] == 0)
//            {
//                [maskView removeFromSuperview];
//                if ([[response objectForKey:@"message"] containsString:@"||||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:1 delegate:self];
//                } else if ([[response objectForKey:@"message"] containsString:@"||"]) {
//                    NSArray* foo = [[response objectForKey:@"message"] componentsSeparatedByString: @"||"];
//                    [self showAlert:[foo objectAtIndex:1] title:[foo objectAtIndex:0] btn:L(@"ok") tag:1 delegate:self];
//                } else {
//                    [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"tryAgain") tag:1 delegate:self];
//                }
//            }
//        });
//    });
//}

//-(void)RequestAPIGetListTransactionHistory {
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"GetListTransactionHistory" withParams:[NSDictionary dictionaryWithObjectsAndKeys:CardId,@"cardId", CardType, @"cardType", CardFinance, @"cardFinancial", nil]];
////        NSLog(@"ListTrans = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"tryAgain") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                if (j <= [CardList count]) {
//                    j = j+1;
//                }
//
//                [CardListTrans addObject:[response objectForKey:@"params"]];
//
//                if ([CardListTrans count] == [CardList count]) {
//                    [maskView removeFromSuperview];
//                    self.tabBarController.title = @"";
//                    [self performSegueWithIdentifier:@"TransHistory" sender:self];
//                } else {
//                    CardId = [[CardList objectAtIndex:j] objectForKey:@"cardId"];
//                    CardType = [[CardList objectAtIndex:j] objectForKey:@"cardType"];
//                    CardFinance = [[CardList objectAtIndex:j] objectForKey:@"cardFinancial"];
//                    [self RequestAPIGetListTransactionHistory];
//                }
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
//                    [self showAlert:[response objectForKey:@"message"] title:L(@"message") btn:L(@"tryAgain") tag:0 delegate:self];
//                }
//            }
//        });
//    });
//}

//-(void)RequestAPISetDefaultCard {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        response = nil;
//        [self RequestData:self withAction:@"SetDefaultCard" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[[CardList objectAtIndex:[CardList count]-1] objectForKey:@"cardId"],@"cardId", [[CardList objectAtIndex:[CardList count]-1] objectForKey:@"cardType"], @"cardType", [[CardList objectAtIndex:[CardList count]-1] objectForKey:@"cardFinancial"], @"cardFinancial", nil]];
////        NSLog(@"Set Default = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [self UI];
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
