//
//  OnBoardPage.m
//  MPay
//
//  Created by Admin on 7/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "OnBoardPage.h"

@implementation OnBoardPage
{
    UIImageView *p1pop1, *p1pop2, *p1pop3;
    UIImageView *p2pop1, *p2pop2, *p2pop3;
    UIImageView *p3pop1, *p3pop2, *p3pop3;
    CABasicAnimation *theAnimation;
    NSString *counter;
    BOOL page1, page2, page3;
}
@synthesize scrollView, pageControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    page1 = TRUE;
    page2 = FALSE;
    page3 = FALSE;
    
    [bgimage setBackgroundColor:[self colorFromHexString:@"#FAFAFA" withAlpha:1.0]];
    
    [self UI];
    
//    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    theAnimation.duration=0.5;
//    theAnimation.fromValue=[NSNumber numberWithFloat:0.0f];
//    theAnimation.toValue=[NSNumber numberWithFloat:1.0f];
//    theAnimation.removedOnCompletion = NO;
//    [theAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//    theAnimation.delegate=self;
//    [[p1pop1 layer] addAnimation:theAnimation forKey:@"scale"];
//    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(animatep1pop2) userInfo:nil repeats:NO];
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(animatep1pop3) userInfo:nil repeats:NO];
}

-(void)viewWillAppear:(BOOL)animated {
    [bgimage setImage:[UIImage imageNamed:@"bgwhiteOnboard.png"]];
}

- (void)UI {
    [[self view] addSubview:[self UIImage:self withFrame:CGRectMake(([self view].frame.size.width/2)-75, [self view].frame.size.height/15, 150, 30) withImageName:@"logoob.png"]];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-120)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3, self.view.frame.size.height-120);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    int yimg = [self view].frame.size.width/7;
    int wimg = ([self view].frame.size.width/10)*8;
    UIImageView *image1 = [self UIImage:self withFrame:CGRectMake(([self view].frame.size.width/2)-(wimg/2), yimg, wimg, wimg) withImageName:@"Page1.png"];
    [scrollView addSubview:image1];
//    p1pop1 = [self UIImage:self withFrame:CGRectMake(image1.frame.origin.x, image1.frame.origin.y+((image1.frame.size.width/50)*8), image1.frame.size.width/5, image1.frame.size.width/8) withImageName:@"visalogo.png"];
//    [scrollView addSubview:p1pop1];
//    p1pop2 = [self UIImage:self withFrame:CGRectMake(image1.frame.origin.x+(image1.frame.size.width/2), image1.frame.origin.y, image1.frame.size.width/5, image1.frame.size.width/8) withImageName:@"ecashlogo.png"];
//    [p1pop2 setHidden:YES];
//    [scrollView addSubview:p1pop2];
//    p1pop3 = [self UIImage:self withFrame:CGRectMake(image1.frame.origin.x+(image1.frame.size.width-(image1.frame.size.width/6)), image1.frame.origin.y+(image1.frame.size.width/3), image1.frame.size.width/5, image1.frame.size.width/8) withImageName:@"mastercardlogo.png"];
//    [p1pop3 setHidden:YES];
//    [scrollView addSubview:p1pop3];
    [scrollView addSubview:[self UILabel:self withFrame:CGRectMake(0, image1.frame.origin.y+image1.frame.size.height, [self view].frame.size.width, 70) withText:@"saveMore" withTextSize:18 withAlignment:1 withLines:0]];
    [scrollView addSubview:[self UILabel:self withFrame:CGRectMake(20, image1.frame.origin.y+image1.frame.size.height+50, [self view].frame.size.width-40, 100) withText:@"onboardDetail1" withTextSize:15 withAlignment:1 withLines:5]];
    
    UIImageView *image2 = [self UIImage:self withFrame:CGRectMake([self view].frame.size.width+image1.frame.origin.x, yimg, wimg, wimg) withImageName:@"Page2.png"];
    [scrollView addSubview:image2];
//    p2pop1 = [self UIImage:self withFrame:CGRectMake(image2.frame.origin.x-10, image2.frame.origin.y+((image2.frame.size.width/50)*14), image2.frame.size.width/6, image2.frame.size.width/6) withImageName:@"merchantlogo.png"];
//    [p2pop1 setHidden:YES];
//    [scrollView addSubview:p2pop1];
//    p2pop2 = [self UIImage:self withFrame:CGRectMake((image2.frame.origin.x+((image2.frame.size.width/50)*19.5)), image2.frame.origin.y-10, image2.frame.size.width/6, image2.frame.size.width/6) withImageName:@"ecommercelogo.png"];
//    [p2pop2 setHidden:YES];
//    [scrollView addSubview:p2pop2];
//    p2pop3 = [self UIImage:self withFrame:CGRectMake((image2.frame.origin.x+((image2.frame.size.width/20)*17)), image2.frame.origin.y+((image2.frame.size.height/50)*31), image2.frame.size.width/6, image2.frame.size.width/6) withImageName:@"mposlogo.png"];
//    [p2pop3 setHidden:YES];
//    [scrollView addSubview:p2pop3];
    [scrollView addSubview:[self UILabel:self withFrame:CGRectMake([self view].frame.size.width, image2.frame.origin.y+image2.frame.size.height, [self view].frame.size.width, 70) withText:@"fastAndEasyPayment" withTextSize:18 withAlignment:1 withLines:5]];
    [scrollView addSubview:[self UILabel:self withFrame:CGRectMake([self view].frame.size.width+25, image2.frame.origin.y+image2.frame.size.height+50, [self view].frame.size.width-50, 100) withText:@"onboardDetail2" withTextSize:15 withAlignment:1 withLines:5]];
    
    UIImageView *image3 = [self UIImage:self withFrame:CGRectMake(([self view].frame.size.width*2)+image1.frame.origin.x, yimg, wimg, wimg) withImageName:@"Page3.png"];
    [scrollView addSubview:image3];
//    p3pop1 = [self UIImage:self withFrame:CGRectMake(image3.frame.origin.x, image3.frame.origin.y+((image3.frame.size.width/50)*14), image3.frame.size.width/6, image3.frame.size.width/6) withImageName:@"moneylogo.png"];
//    [p3pop1 setHidden:YES];
//    [scrollView addSubview:p3pop1];
//    p3pop2 = [self UIImage:self withFrame:CGRectMake((image3.frame.origin.x+((image3.frame.size.width/50)*37)), image3.frame.origin.y+((image3.frame.size.height/50)*4), image3.frame.size.width/6, image3.frame.size.width/6) withImageName:@"peoplelogo.png"];
//    [p3pop2 setHidden:YES];
//    [scrollView addSubview:p3pop2];
//    p3pop3 = [self UIImage:self withFrame:CGRectMake((image3.frame.origin.x+((image3.frame.size.width/20)*14)), image3.frame.origin.y+((image3.frame.size.height/20)*16), image3.frame.size.width/6, image3.frame.size.width/6) withImageName:@"securitylogo.png"];
//    [p3pop3 setHidden:YES];
//    [scrollView addSubview:p3pop3];
    [scrollView addSubview:[self UILabel:self withFrame:CGRectMake([self view].frame.size.width*2, image3.frame.origin.y+image3.frame.size.height, [self view].frame.size.width, 70) withText:@"scanQR" withTextSize:18 withAlignment:1 withLines:5]];
    [scrollView addSubview:[self UILabel:self withFrame:CGRectMake(([self view].frame.size.width*2)+25, image3.frame.origin.y+image3.frame.size.height+50, [self view].frame.size.width-50, 100) withText:@"onboardDetail3" withTextSize:15 withAlignment:1 withLines:5]];
    
    [[self view] addSubview:scrollView];
    
    pageControl = [[UIPageControl alloc] init]; //SET a property of UIPageControl
    pageControl.frame = CGRectMake(0, self.view.frame.size.height-([self view].frame.size.height/6),self.view.frame.size.width,40);
    pageControl.numberOfPages = scrollView.contentSize.width/scrollView.frame.size.width; //as we added 3 diff views
    pageControl.currentPage = 0;
    pageControl.enabled = NO;
    pageControl.transform = CGAffineTransformMakeScale(1.5, 1.5);
    [pageControl setCurrentPageIndicatorTintColor:[self colorFromHexString:Color3 withAlpha:1.0]];
    [pageControl setPageIndicatorTintColor:[self colorFromHexString:Color3 withAlpha:0.3]];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [[self view] addSubview:pageControl];
    
    UIButton *skip = [self UIButton:self withFrame:CGRectMake(([self view].frame.size.width/2)-(([self view].frame.size.width/3)/2), [self view].frame.size.height-([self view].frame.size.height/9), [self view].frame.size.width/3, 40) withTitle:[@"getStarted" uppercaseString] withTag:0];
    [[skip titleLabel] setFont:[UIFont boldSystemFontOfSize:14]];
    [skip setBackgroundColor:[self colorFromHexString:Color0 withAlpha:1.0]];
    [skip setTitleColor:[self colorFromHexString:Color3 withAlpha:1.0] forState:UIControlStateNormal];
    [[skip layer] setBorderWidth:1];
    [[skip layer] setBorderColor:[self colorFromHexString:Color3 withAlpha:1.0].CGColor];
    [[self view] addSubview:skip];
}

-(void)Act:(id)sender {
    if([sender tag] == 0)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    if ([sender tag] == 1)
    {
//        if (self.pageControl.currentPage == 2) {
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//        else
//        {
//            self.pageControl.currentPage = self.pageControl.currentPage + 1;
//            [self changePage:self];
//        }
    }
}

-(void)animatep1pop2 {
    [p1pop2 setHidden:NO];
    [[p1pop2 layer] addAnimation:theAnimation forKey:@"scale"];
}
-(void)animatep1pop3 {
    [p1pop3 setHidden:NO];
    [[p1pop3 layer] addAnimation:theAnimation forKey:@"scale"];
}
-(void)animatep2pop2 {
    [p2pop2 setHidden:NO];
    [[p2pop2 layer] addAnimation:theAnimation forKey:@"scale"];
}
-(void)animatep2pop3 {
    [p2pop3 setHidden:NO];
    [[p2pop3 layer] addAnimation:theAnimation forKey:@"scale"];
}
-(void)animatep3pop2 {
    [p3pop2 setHidden:NO];
    [[p3pop2 layer] addAnimation:theAnimation forKey:@"scale"];
}
-(void)animatep3pop3 {
    [p3pop3 setHidden:NO];
    [[p3pop3 layer] addAnimation:theAnimation forKey:@"scale"];
}

-(void)OnChange {
    if ([pageControl currentPage] == 0) {
        if (!page1) {
            page1 = TRUE;
            [p1pop1 setHidden:NO];
            [[p1pop1 layer] addAnimation:theAnimation forKey:@"scale"];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(animatep1pop2) userInfo:nil repeats:NO];
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(animatep1pop3) userInfo:nil repeats:NO];
        }
    } else if ([pageControl currentPage] == 1) {
        if (!page2) {
            page2 = TRUE;
            [p2pop1 setHidden:NO];
            [[p2pop1 layer] addAnimation:theAnimation forKey:@"scale"];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(animatep2pop2) userInfo:nil repeats:NO];
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(animatep2pop3) userInfo:nil repeats:NO];
        }
    } else if ([pageControl currentPage] == 2) {
        if (!page3) {
            page3 = TRUE;
            [p3pop1 setHidden:NO];
            [[p3pop1 layer] addAnimation:theAnimation forKey:@"scale"];
            [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(animatep3pop2) userInfo:nil repeats:NO];
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(animatep3pop3) userInfo:nil repeats:NO];
        }
    }
}

- (void)changePage:(id)sender {
    CGFloat x = pageControl.currentPage * scrollView.frame.size.width;
    [scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
//    [self OnChange];
}

#pragma mark - UIScrollview Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scView {
    CGFloat pageWidth = scView.frame.size.width;
    float fractionalPage = scView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pageControl.currentPage = page;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scView {
//    [self OnChange];
}

#pragma mark - Animation Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}

@end
