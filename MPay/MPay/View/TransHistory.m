//
//  TransHistory.m
//  MPay
//
//  Created by Admin on 7/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "TransHistory.h"
#import "DetailCell.h"
#import "DetailTransaction.h"
#import "Login.h"

@implementation TransHistory
{
//    NSArray *Data;
    UIButton *del, *setdefault, *cancel;
    NSString *TransId, *CardFinance;
    NSInteger cardflag;
    UIView *view, *test, *pop, *layerbg, *empty;
    BOOL flag, smask;
    int limit, lebarkartu, tinggikartu;
}
@synthesize scrollView, pageControl, table, CardList, CardListTrans, Response, CardSelect;

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = TRUE;
    smask = TRUE;
    
    limit = 10;
    lebarkartu = (self.view.frame.size.width/2);
    tinggikartu = 0;
    
    cardflag = [CardSelect intValue];
    [self UI];
    
    [scrollView setScrollEnabled:NO];
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"position.y"];
    theAnimation.duration=0.4;
    theAnimation.fromValue=@((self.view.frame.size.height/100)*50);
    theAnimation.toValue= [self view].frame.size.height > 568 ? @(lebarkartu-25) : @(lebarkartu);
    theAnimation.removedOnCompletion = NO;
    [theAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    theAnimation.delegate=self;
    [[scrollView layer] addAnimation:theAnimation forKey:@"position.y"];
}

-(void)viewWillAppear:(BOOL)animated {
    [redAlert removeFromSuperview];
//    [self navigationController].navigationBar.barStyle = UIBarStyleBlackOpaque;
    [bgimage setImage:[UIImage imageNamed:@"bgwhite.png"]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[self colorFromHexString:Color1 withAlpha:1.0]}];
    [[[self navigationController] navigationBar] setTintColor:[self colorFromHexString:Color1 withAlpha:1.0]];
    
    UIBarButtonItem * addButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"sidemenu.png"]] style:UIBarButtonItemStylePlain target:self action:@selector(Opt)];
    self.navigationItem.rightBarButtonItem = addButton ;
    [scrollView setHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated {
    [scrollView setHidden:YES];
//    [self navigationController].navigationBar.barStyle = UIBarStyleDefault;
}

- (void)UI {
    [[self navigationItem] setTitle:@"transactionHistory"];
    
    //Table List
    [[self view] addSubview:[self UIView:self withFrame:CGRectMake(0, [self view].frame.size.height-50, [self view].frame.size.width, 50)]];
    table = [self UITableView:self withFrame:CGRectMake(0, (lebarkartu)+120, [self view].frame.size.width, [self view].frame.size.height-((lebarkartu)+120)) withStyle:0];
    [table setTag:10];
    [table setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    [[self view] addSubview:table];
    
    empty = [self UIView:self withFrame:CGRectMake(0, (lebarkartu)+120, [self view].frame.size.width, [self view].frame.size.height-((lebarkartu)+120))];
    [empty setBackgroundColor:[UIColor whiteColor]];
    UIImageView *img = [self UIImage:self withFrame:CGRectMake((empty.frame.size.width/2)-((empty.frame.size.width/4.5)/2), (empty.frame.size.height/2)-((empty.frame.size.height/4)/2)-20, empty.frame.size.width/4.5, empty.frame.size.height/4) withImageName:@"invoice.png"];
    [empty addSubview:img];
    [empty addSubview:[self UILabel:self withFrame:CGRectMake(0, img.frame.origin.y+img.frame.size.height+20, empty.frame.size.width, 30) withText:@"transactionEmptyMessage1" withTextSize:14 withAlignment:1 withLines:0]];
    [empty addSubview:[self UILabel:self withFrame:CGRectMake(0, img.frame.origin.y+img.frame.size.height+40, empty.frame.size.width, 30) withText:@"transactionEmptyMessage2" withTextSize:14 withAlignment:1 withLines:0]];
    if ([[[CardListTrans objectAtIndex:cardflag] objectForKey:@"countListHistory"] intValue] > 0) {
        [empty setHidden:YES];
    } else {
        [empty setHidden:NO];
    }
    [[self view] addSubview:empty];
    
    //Scrollview Card
    CGFloat contentOffset = 0.0f;
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 80, self.view.frame.size.width-60, lebarkartu)];
    scrollView.contentSize = CGSizeMake(((self.view.frame.size.width)*[CardList count]), lebarkartu);
    scrollView.showsHorizontalScrollIndicator = NO;
    [scrollView setClipsToBounds:NO];
    [scrollView setPagingEnabled:YES];
    [scrollView setDelegate:self];
    [scrollView setTag:1];
    
    for (int i = 1; i <= [CardList count]; i++) {
        if ([[[CardList objectAtIndex:i-1] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
            [scrollView addSubview:[self ECardAssets:self withFrame:CGRectMake(contentOffset, 0, scrollView.frame.size.width-20, lebarkartu) withImage:[NSString stringWithFormat:@"%@.png",[[CardList objectAtIndex:i-1] objectForKey:@"cardType"]] withBalance:[[CardList objectAtIndex:i-1] objectForKey:@"cardBalance"] withCardNumber:[[CardList objectAtIndex:i-1] objectForKey:@"cardNumberMasking"] withCardType:[[CardList objectAtIndex:i-1] objectForKey:@"cardType"] withTag:i]];
        } else {
            [scrollView addSubview:[self CardAssets:self withFrame:CGRectMake(contentOffset, 0, scrollView.frame.size.width-20, lebarkartu) withImage:[NSString stringWithFormat:@"%@.png",[[CardList objectAtIndex:i-1] objectForKey:@"cardType"]] withBalance:[[CardList objectAtIndex:i-1] objectForKey:@"cardBalance"] withCardNumber:[[CardList objectAtIndex:i-1] objectForKey:@"cardNumberMasking"] withCardExp:[[CardList objectAtIndex:i-1] objectForKey:@"cardExp"] withCardType:[[CardList objectAtIndex:i-1] objectForKey:@"cardType"] withTag:i]];
        }

        contentOffset += scrollView.frame.size.width;
        scrollView.contentSize = CGSizeMake(contentOffset, lebarkartu);
    }
    [[self view] addSubview:scrollView];
    
    //Page Control
    pageControl = [[UIPageControl alloc] init]; //SET a property of UIPageControl
    pageControl.frame = CGRectMake(20,(lebarkartu)+95,self.view.frame.size.width-40,20);
    pageControl.numberOfPages = scrollView.contentSize.width/(scrollView.frame.size.width);
    pageControl.currentPage = cardflag;
    pageControl.enabled = NO;
    pageControl.transform = CGAffineTransformMakeScale(1.5, 1.5);
    [pageControl setCurrentPageIndicatorTintColor:[self colorFromHexString:Color3 withAlpha:1.0]];
    [pageControl setPageIndicatorTintColor:[self colorFromHexString:Color3 withAlpha:0.3]];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self changePage:self];
    [[self view] addSubview:pageControl];
    
    for(UIView *vw in scrollView.subviews)
    {
        if([vw viewWithTag:pageControl.currentPage+1])
        {
            if ([[[CardList objectAtIndex:pageControl.currentPage] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
                CABasicAnimation *theAnimation1;
                theAnimation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                theAnimation1.duration=0.5;
                theAnimation1.fillMode=kCAFillModeForwards;
                theAnimation1.fromValue=[NSNumber numberWithFloat:1.0f];
                theAnimation1.toValue=[NSNumber numberWithFloat:1.08f];
                theAnimation1.removedOnCompletion = NO;
                [theAnimation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                theAnimation1.delegate=self;
                [[[vw viewWithTag:pageControl.currentPage+1] layer] addAnimation:theAnimation1 forKey:@"transform.scale"];
            } else {
                CABasicAnimation *theAnimation1;
                theAnimation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                theAnimation1.duration=0.5;
                theAnimation1.fillMode=kCAFillModeForwards;
                theAnimation1.fromValue=[NSNumber numberWithFloat:1.0f];
                theAnimation1.toValue=[NSNumber numberWithFloat:1.08f];
                theAnimation1.removedOnCompletion = NO;
                [theAnimation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                theAnimation1.delegate=self;
                [[[vw viewWithTag:pageControl.currentPage+1] layer] addAnimation:theAnimation1 forKey:@"transform.scale"];
            }
            
            //here do your work
        }
        
        for(UIImageView *iv in scrollView.subviews)
        {
            for (int i = 1; i <= [CardList count]; i++) {
                if([iv tag] == i)
                {
                    [iv setAlpha:0.5];
                }
            }
            if([iv tag] == pageControl.currentPage+1)
            {
                [iv setAlpha:1.0];
            }
        }
    }
    
    //Sub Menu kanan atas
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self view].frame.size.width, [self view].frame.size.height)];
    [view setBackgroundColor:[self transparentBlack]];
    
    layerbg = [self UIView:self withFrame:CGRectMake(10, [self view].frame.size.height-170, [self view].frame.size.width-20, 110)];
    [[layerbg layer] setCornerRadius:5];
    [view addSubview:layerbg];
    
    setdefault = [self UIButton:self withFrame:CGRectMake(0, layerbg.frame.size.height-110, [self view].frame.size.width-20, 50) withTitle:@"setAsDefault" withTag:0];
    [setdefault setBackgroundColor:[UIColor whiteColor]];
    [setdefault setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [layerbg addSubview:setdefault];
    
//    UIView *line = [self UIView:self withFrame:CGRectMake(0, layerbg.frame.size.height-50, layerbg.frame.size.width, 1)];
//    [line setBackgroundColor:[self colorFromHexString:@"#000000" withAlpha:0.5]];
//    [layerbg addSubview:line];
    
    del = [self UIButton:self withFrame:CGRectMake(0, layerbg.frame.size.height-50, [self view].frame.size.width-20, 50) withTitle:@"deleteCard" withTag:15];
    [del setBackgroundColor:[UIColor whiteColor]];
    [del setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [layerbg addSubview:del];
    
    cancel = [self UIButton:self withFrame:CGRectMake(10, [self view].frame.size.height-55, [self view].frame.size.width-20, 50) withTitle:@"cancel" withTag:18];
    [cancel setBackgroundColor:[UIColor whiteColor]];
    [cancel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [view addSubview:cancel];
    
    [[self navigationController].view addSubview:view];
    [view setHidden:YES];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        cardflag = [pageControl currentPage];
        [self Opt];
//        [self RequestAPISetDefaultCard];
        [defaults setObject:@"delete" forKey:@"Deleted"];
    }
    else if([sender tag] == 15)
    {
        [self PopUpDelete];
    }
    else if([sender tag] == 16)
    {
        [pop removeFromSuperview];
    }
    else if([sender tag] == 17)
    {
        if ([CardList count] == 1) {
            [self Opt];
        }
        else {
            [self Opt];
//            [self RequestAPIDeleteRegisterCard];
        }
    }
    else if([sender tag] == 18)
    {
        [self Opt];
    }
}

-(void)PopUpDelete {
    pop = [self UIView:self withFrame:CGRectMake(0, 0, view.frame.size.width-40, 180)];
    [pop setBackgroundColor:[UIColor whiteColor]];
    [pop setCenter:[view center]];
    [[pop layer] setCornerRadius:10];
    
    [pop addSubview:[self UIImageServer:self withFrame:CGRectMake((pop.frame.size.width/2)-40, 10, 80, 50) withImageName:[NSString stringWithFormat:@"%@.png",[[CardList objectAtIndex:[pageControl currentPage]] objectForKey:@"cardType"]]]];
    
    [pop addSubview:[self UILabel:self withFrame:CGRectMake(0, 65, pop.frame.size.width, 50) withText:[NSString stringWithFormat:@"confirmDeleteCard", [[CardList objectAtIndex:[self pageControl].currentPage] objectForKey:@"cardNumberMasking"]] withTextSize:14 withAlignment:1 withLines:0]];
    
    UIButton *Cancel = [self UIButton:self withFrame:CGRectMake(0, pop.frame.size.height-50, pop.frame.size.width/2, 50) withTitle:@"cancel" withTag:16];
    [Cancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [[Cancel layer] setCornerRadius:0];
    [[Cancel layer] setBorderWidth:0.5];
    [[Cancel layer] setBorderColor:[UIColor grayColor].CGColor];
    [pop addSubview:Cancel];
    
    UIButton *Del = [self UIButton:self withFrame:CGRectMake(pop.frame.size.width/2, pop.frame.size.height-50, pop.frame.size.width/2, 50) withTitle:@"deleteCard" withTag:17];
    [Del setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [[Del layer] setCornerRadius:0];
    [[Del layer] setBorderWidth:0.5];
    [[Del layer] setBorderColor:[UIColor grayColor].CGColor];
    [pop addSubview:Del];
    
    [view addSubview:pop];
}

-(void)Opt {
    if(!flag) {
        [view setHidden:YES];
        [pop removeFromSuperview];
        flag = TRUE;
    }
    else
    {
        [view setHidden:NO];
        if ([[[CardList objectAtIndex:[pageControl currentPage]] objectForKey:@"cardType"] isEqualToString:@"ecash"])
        {
            [layerbg setFrame:CGRectMake(10, view.frame.size.height-110, view.frame.size.width-20, 50)];
            [setdefault setFrame:CGRectMake(0, layerbg.frame.size.height-50, layerbg.frame.size.width, 50)];
            [del setHidden:YES];
        } else {
            [layerbg setFrame:CGRectMake(10, view.frame.size.height-170, view.frame.size.width-20, 110)];
            [setdefault setFrame:CGRectMake(0, layerbg.frame.size.height-105, layerbg.frame.size.width, 50)];
            [del setHidden:NO];
        }
        flag = FALSE;
    }
}

-(void)Reload {
//    [self RequestAPIGetListTransactionHistory];
}

-(void)Refresh {
    [table reloadData];
    smask = TRUE;
    flag = TRUE;
}

- (void)changePage:(id)sender {
    CGFloat x = pageControl.currentPage * (scrollView.frame.size.width);
    [scrollView setContentOffset:CGPointMake(x, 0) animated:NO];
    cardflag = pageControl.currentPage;
    
//    [bgimage setImage:[PCUtils getImageFromFolder:@"img" andFilename:[NSString stringWithFormat:@"%@bg.png", [[CardList objectAtIndex:[pageControl currentPage]] objectForKey:@"cardType"]]]];
    
//    [self Reload];
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scView {
    //Scroll View Scroll
    if ([scView tag] == 1) {
        
        CGFloat pageWidth = scView.frame.size.width;
        float fractionalPage = scView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        if (self.pageControl.currentPage == page) {
            smask = TRUE;
        }
        self.pageControl.currentPage = page;
        
//        [bgimage setImage:[PCUtils getImageFromFolder:@"img" andFilename:[NSString stringWithFormat:@"%@bg.png", [[CardList objectAtIndex:[pageControl currentPage]] objectForKey:@"cardType"]]]];
//        
//        if (page == (fractionalPage - fmodf(fractionalPage, 1))) {
//            if (1-(ABS(fmodf(fractionalPage, 1))) <= 0.5) {
//                [bgimage setAlpha:0.5];
//            } else {
//                [bgimage setAlpha:1-(ABS(fmodf(fractionalPage, 1)))];
//            }
//        } else {
//            if (fmodf(fractionalPage, 1) <= 0.5) {
//                [bgimage setAlpha:0.5];
//            } else {
//                [bgimage setAlpha:fmodf(fractionalPage, 1)];
//            }
//        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scView {
    if ([scView tag] == 1) {
        for(UIView *vw in scView.subviews)
        {
            if([vw viewWithTag:pageControl.currentPage+1])
            {
                if ([[[CardList objectAtIndex:pageControl.currentPage] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
                    CABasicAnimation *theAnimation1;
                    theAnimation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                    theAnimation1.duration=0;
                    theAnimation1.fillMode=kCAFillModeForwards;
                    theAnimation1.fromValue=[NSNumber numberWithFloat:1.0f];
                    theAnimation1.toValue=[NSNumber numberWithFloat:0.98f];
                    theAnimation1.removedOnCompletion = NO;
                    [theAnimation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                    theAnimation1.delegate=self;
                    [[[vw viewWithTag:pageControl.currentPage+1] layer] addAnimation:theAnimation1 forKey:@"transform.scale"];
                } else {
                    CABasicAnimation *theAnimation1;
                    theAnimation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                    theAnimation1.duration=0;
                    theAnimation1.fillMode=kCAFillModeForwards;
                    theAnimation1.fromValue=[NSNumber numberWithFloat:1.0f];
                    theAnimation1.toValue=[NSNumber numberWithFloat:0.98f];
                    theAnimation1.removedOnCompletion = NO;
                    [theAnimation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                    theAnimation1.delegate=self;
                    [[[vw viewWithTag:pageControl.currentPage+1] layer] addAnimation:theAnimation1 forKey:@"transform.scale"];
                }
                //here do your work
            }
        }
 
        for(UIImageView *iv in scrollView.subviews)
        {
            for (int i = 1; i <= [CardList count]; i++) {
                if([iv tag] == i)
                {
                    [iv setAlpha:1.0];
                }
            }
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scView {
    if ([scView tag] == 1) {
        if (smask) {
            smask = FALSE;
            for(UIView *vw in scView.subviews)
            {
                if([vw viewWithTag:pageControl.currentPage+1])
                {
                    if ([[[CardList objectAtIndex:pageControl.currentPage] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
                        CABasicAnimation *theAnimation1;
                        theAnimation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                        theAnimation1.duration=0.4;
                        theAnimation1.fillMode=kCAFillModeForwards;
                        theAnimation1.fromValue=[NSNumber numberWithFloat:1.0f];
                        theAnimation1.toValue=[NSNumber numberWithFloat:1.08f];
                        theAnimation1.removedOnCompletion = NO;
                        [theAnimation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                        theAnimation1.delegate=self;
                        [[[vw viewWithTag:pageControl.currentPage+1] layer] addAnimation:theAnimation1 forKey:@"scale"];
                    } else {
                        CABasicAnimation *theAnimation1;
                        theAnimation1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
                        theAnimation1.duration=0.4;
                        theAnimation1.fillMode=kCAFillModeForwards;
                        theAnimation1.fromValue=[NSNumber numberWithFloat:1.0f];
                        theAnimation1.toValue=[NSNumber numberWithFloat:1.08f];
                        theAnimation1.removedOnCompletion = NO;
                        [theAnimation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                        theAnimation1.delegate=self;
                        [[[vw viewWithTag:pageControl.currentPage+1] layer] addAnimation:theAnimation1 forKey:@"scale"];
                    }
                    //here do your work
                }
            }
            
            for(UIImageView *iv in scrollView.subviews)
            {
                for (int i = 1; i <= [CardList count]; i++) {
                    if([iv tag] == i)
                    {
                        [iv setAlpha:0.5];
                    }
                }
                if([iv tag] == pageControl.currentPage+1)
                {
                    [iv setAlpha:1.0];
                }
            }
            
            if ([[[CardListTrans objectAtIndex:[pageControl currentPage]] objectForKey:@"countListHistory"] intValue] < limit){
                limit = 10;
            }
//          [self Reload];
            if ([[[CardListTrans objectAtIndex:[pageControl currentPage]] objectForKey:@"countListHistory"] intValue] > 0) {
                [empty setHidden:YES];
            } else {
                [empty setHidden:NO];
            }
            [table reloadData];
        }
    }
    
    if ([scView tag] == 10) {
        NSInteger currentOffset = scView.contentOffset.y;
        NSInteger maximumOffset = scView.contentSize.height - scView.frame.size.height;
        
        // Hit Bottom?
        if (((currentOffset > 0) && (maximumOffset - currentOffset) <= limit) && (limit < [[[CardListTrans objectAtIndex:[pageControl currentPage]] objectForKey:@"countListHistory"] intValue])) {
            if (smask) {
                smask = FALSE;
                [[self navigationController].view addSubview:[self showmask]];
                [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(removeMask) userInfo:nil repeats:NO];
            }
        }
    }
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scView {
    if ([scView tag] == 1) {
//        [[self navigationController].view addSubview:[self showmask]];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[[CardListTrans objectAtIndex:[pageControl currentPage]] objectForKey:@"countListHistory"] intValue] < limit){
        return [[[CardListTrans objectAtIndex:[pageControl currentPage]] objectForKey:@"countListHistory"] intValue];
    }
    return limit;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.mainLabel.text = [[[[CardListTrans objectAtIndex:[pageControl currentPage]] objectForKey:@"listTransactionHistory"] objectAtIndex:[indexPath row]] objectForKey:@"merchantName"];
    cell.descriptionLabel.text = [NSString stringWithFormat:@"%@ - %@", [[[[CardListTrans objectAtIndex:[pageControl currentPage]] objectForKey:@"listTransactionHistory"] objectAtIndex:[indexPath row]] objectForKey:@"transactionType"], [[[[CardListTrans objectAtIndex:[pageControl currentPage]] objectForKey:@"listTransactionHistory"] objectAtIndex:[indexPath row]] objectForKey:@"dateTime"]];
    cell.voidLabel.text = @"void";
    
    cell.rightLabel.frame = CGRectMake(20, 5, [self view].frame.size.width-40, 40);
    cell.rightLabel.text =[NSString stringWithFormat:@"%@%@", [[defaults objectForKey:@"language"] isEqualToString:@"id"] ? @"Rp" : @"IDR", [self FormatNumber:self from:[[[[CardListTrans objectAtIndex:[pageControl currentPage]] objectForKey:@"listTransactionHistory"] objectAtIndex:[indexPath row]] objectForKey:@"amountTrx"]]];
    
    if ([[[[[CardListTrans objectAtIndex:[pageControl currentPage]] objectForKey:@"listTransactionHistory"] objectAtIndex:[indexPath row]] objectForKey:@"isVoid"] isEqualToString:@"Y"]) {
        cell.voidLabel.frame = CGRectMake(cell.rightLabel.frame.origin.x, cell.rightLabel.frame.origin.y, cell.rightLabel.frame.size.width, 10);
        cell.voidLabel.text = @"void";
        cell.voidLabel.textColor = [UIColor redColor];
        NSMutableAttributedString *attributeline = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", [[defaults objectForKey:@"language"] isEqualToString:@"id"] ? @"Rp" : @"IDR", [self FormatNumber:self from:[[[[CardListTrans objectAtIndex:[pageControl currentPage]] objectForKey:@"listTransactionHistory"] objectAtIndex:[indexPath row]] objectForKey:@"amountTrx"]]]];
        [attributeline addAttribute:NSStrikethroughStyleAttributeName value:@1 range:NSMakeRange(0, [attributeline length])];
        [attributeline addAttribute:NSStrikethroughColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [attributeline length])];
        cell.rightLabel.attributedText = attributeline;
    } else {
        cell.voidLabel.text = @"";
    }
    
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", [[defaults objectForKey:@"language"] isEqualToString:@"id"] ? @"Rp" : @"IDR", [self FormatNumber:self from:[[[[CardListTrans objectAtIndex:[pageControl currentPage]] objectForKey:@"listTransactionHistory"] objectAtIndex:[indexPath row]] objectForKey:@"amountTrx"]]];
//    cell.detailTextLabel.textColor = [UIColor blackColor];
    
    return cell;
}

#pragma mark - Tableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TransId = [[[[CardListTrans objectAtIndex:[pageControl currentPage]] objectForKey:@"listTransactionHistory"] objectAtIndex:[indexPath row]] objectForKey:@"transactionId"];
//    [self RequestAPIGetDetailTransactionHistory];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - Segue Delegate
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"TransDetail"]) {
        DetailTransaction *NVC = [segue destinationViewController];
        NVC.Response = [[response objectForKey:@"params"] mutableCopy];
        NVC.RefNo = [[response objectForKey:@"params"] objectForKey:@"retrievalReferenceNoTrx"];
        NVC.CardSelect = [CardList objectAtIndex:[pageControl currentPage]];
        NVC.CardNumberTrx = [[response objectForKey:@"params"] objectForKey:@"cardNumberTrx"];
        NVC.AmtTrx = [[response objectForKey:@"params"] objectForKey:@"totalAmountTrx"];
    }
}

-(void)removeMask{
    limit += 10;
    [maskView removeFromSuperview];
    [self Refresh];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) {
        if(buttonIndex == 1)
        {
            if ([CardList count] == 1) {
                [self Opt];
                
            }
            else {
//                [self RequestAPIDeleteRegisterCard];
            }
        }
    } else if ([alertView tag] == 2) {
        if(buttonIndex == 0)
        {
            if ([[defaults objectForKey:@"StatusLogin"] isEqualToString:@"Y"]) {
//                [self Reload];
                if ([[[CardListTrans objectAtIndex:[pageControl currentPage]] objectForKey:@"countListHistory"] intValue] > 0) {
                    [empty setHidden:YES];
                } else {
                    [empty setHidden:NO];
                }
                [table reloadData];
            }
        }
    }
}

#pragma mark - Animation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (tinggikartu > 0) {
        [scrollView setScrollEnabled:YES];
    }
    tinggikartu = 1;
}

//-(void)RequestAPIGetListTransactionHistory {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"GetListTransactionHistory" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[[CardList objectAtIndex:[pageControl currentPage]] objectForKey:@"cardId"],@"cardId", [[CardList objectAtIndex:pageControl.currentPage] objectForKey:@"cardType"], @"cardType", [[CardList objectAtIndex:pageControl.currentPage] objectForKey:@"cardFinancial"], @"cardFinancial", nil]];
////        NSLog(@"ListTrans = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                Response = [response mutableCopy];
//                if ([[[Response objectForKey:@"params"] objectForKey:@"countListHistory"] intValue] > 0) {
//                    [empty setHidden:YES];
//                } else {
//                    [empty setHidden:NO];
//                }
//                [table reloadData];
//                smask = TRUE;
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

//-(void)RequestAPIGetDetailTransactionHistory {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"GetDetailTransactionHistory" withParams:[NSDictionary dictionaryWithObjectsAndKeys:TransId, @"transactionId", [[CardList objectAtIndex:[pageControl currentPage]] objectForKey:@"cardFinancial"] , @"cardFinancial", nil]];
////        NSLog(@"Detail Transaction History = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults setObject:@"TransHistory" forKey:@"ViewController"];
//                [self performSegueWithIdentifier:@"TransDetail" sender:self];
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

//-(void)RequestAPISetDefaultCard {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"SetDefaultCard" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[[CardList objectAtIndex:cardflag] objectForKey:@"cardId"],@"cardId", [[CardList objectAtIndex:cardflag] objectForKey:@"cardType"], @"cardType", [[CardList objectAtIndex:cardflag] objectForKey:@"cardFinancial"], @"cardFinancial", nil]];
////        NSLog(@"Set Default = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                [defaults setObject:@"delete" forKey:@"Deleted"];
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

//-(void)RequestAPIDeleteRegisterCard {
//    [[self navigationController].view addSubview:[self showmask]];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self RequestData:self withAction:@"DeleteRegisterCard" withParams:[NSDictionary dictionaryWithObjectsAndKeys:[[CardList objectAtIndex:pageControl.currentPage] objectForKey:@"cardId"],@"cardId", [[CardList objectAtIndex:pageControl.currentPage] objectForKey:@"cardType"], @"cardType", [[CardList objectAtIndex:pageControl.currentPage] objectForKey:@"cardFinancial"], @"cardFinancial", nil]];
////        NSLog(@"Delete Card = %@", response);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (response == nil) {
//                [maskView removeFromSuperview];
//                [self showAlert:MSGResponseNil title:L(@"warning") btn:L(@"ok") tag:0 delegate:self];
//            }
//            else if([[response objectForKey:@"ok"] intValue] == 1)
//            {
//                [maskView removeFromSuperview];
//                if ([[[CardList objectAtIndex:[pageControl currentPage]] objectForKey:@"isDefault"] isEqualToString:@"Y"]) {
//                    [CardList removeObjectAtIndex:[pageControl currentPage]];
//                    [CardListTrans removeObjectAtIndex:[pageControl currentPage]];
//                    for (int i = 0; i < [CardList count]; i++) {
//                        if ([[[CardList objectAtIndex:i] objectForKey:@"cardType"] isEqualToString:@"ecash"]) {
//                            cardflag = i;
//                        }
//                    }
//                    CGFloat x = cardflag * (scrollView.frame.size.width);
//                    [scrollView setContentOffset:CGPointMake(x, 0) animated:NO];
//                    [self RequestAPISetDefaultCard];
//                } else {
//                    [CardList removeObjectAtIndex:[pageControl currentPage]];
//                    [CardListTrans removeObjectAtIndex:[pageControl currentPage]];
//                    if ([pageControl currentPage] >= 1) {
//                        cardflag = [pageControl currentPage]-1;
//                    }
//                    else
//                    {
//                        cardflag = [pageControl currentPage];
//                    }
//                }
////                [self Reload];
//                [scrollView removeFromSuperview];
//                [pageControl removeFromSuperview];
//                [table removeFromSuperview];
//                [defaults setObject:@"delete" forKey:@"Deleted"];
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
