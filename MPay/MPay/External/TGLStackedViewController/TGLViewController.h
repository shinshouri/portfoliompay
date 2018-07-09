//
//  TGLViewController.h
//  TGLStackedViewExample
//
//  Created by Tim Gleue on 07.04.14.
//  Copyright (c) 2014 Tim Gleue ( http://gleue-interactive.com )
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <UIKit/UIKit.h>

#import "TGLStackedViewController.h"

@protocol TGLViewControllerDelegate <NSObject>

- (instancetype)initWithCoder:(NSCoder *)aDecoder;
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;

@end
@interface TGLViewController : TGLStackedViewController

@property (nonatomic,weak) id <TGLViewControllerDelegate> delegate;
@property (nonatomic, assign) BOOL showsBackgroundView;
@property (nonatomic, assign) BOOL showsVerticalScrollIndicator;

@property (nonatomic, assign) NSInteger cardCount;
@property (nonatomic, assign) CGSize cardSize;

@property (nonatomic, assign) UIEdgeInsets stackedLayoutMargin;
@property (nonatomic, assign) CGFloat stackedTopReveal;
@property (nonatomic, assign) CGFloat stackedBounceFactor;
@property (nonatomic, assign) BOOL stackedFillHeight;
@property (nonatomic, assign) BOOL stackedCenterSingleItem;
@property (nonatomic, assign) BOOL stackedAlwaysBounce;

@property (nonatomic, assign) BOOL doubleTapToClose;

@end
