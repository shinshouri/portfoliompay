//
//  Wallet.h
//  MPay
//
//  Created by Admin on 7/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ParentViewController.h"
#import "TGLViewController.h"

@interface Wallet : ParentViewController <UIScrollViewDelegate, UITextFieldDelegate, TGLViewControllerDelegate>

//@property (nonatomic,weak) id <TGLViewControllerDelegate> delegate;
@property (nonatomic, retain) UIScrollView *scrollView;

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue;

@end
