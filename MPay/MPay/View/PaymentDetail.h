//
//  PaymentDetail.h
//  MPay
//
//  Created by Admin on 7/22/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ParentViewController.h"

@interface PaymentDetail : ParentViewController <UIScrollViewDelegate, CAAnimationDelegate>

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableDictionary *data;
@property (nonatomic, retain) NSMutableArray *CardList;

@end
