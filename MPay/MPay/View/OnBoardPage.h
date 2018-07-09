//
//  OnBoardPage.h
//  MPay
//
//  Created by Admin on 7/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParentViewController.h"
#import <QuartzCore/QuartzCore.h>

// 10.243.130.237:8080 SIT
// 10.243.130.240:8080 VIT
// 10.243.130.248:8080 UAT
// 10.254.109.77:8443 UAT https

@interface OnBoardPage : ParentViewController <UIScrollViewDelegate, CAAnimationDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl * pageControl;

@end
