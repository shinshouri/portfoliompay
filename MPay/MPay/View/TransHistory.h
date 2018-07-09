//
//  TransHistory.h
//  MPay
//
//  Created by Admin on 7/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ParentViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TransHistory : ParentViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, CAAnimationDelegate> {
    
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSMutableArray *CardList, *CardListTrans;
@property (nonatomic, retain) NSMutableDictionary *Response;
@property (nonatomic, retain) NSString *CardSelect;

@end
