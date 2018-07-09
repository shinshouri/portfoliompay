//
//  TGLViewController.m
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

#import "TGLViewController.h"
#import "TGLCollectionViewCell.h"
//#import "TGLBackgroundProxyView.h"

@interface UIColor (randomColor)

+ (UIColor *)randomColor;

@end

@implementation UIColor (randomColor)

+ (UIColor *)randomColor {
    
    CGFloat comps[3];
    
    for (int i = 0; i < 3; i++) {
        
        NSUInteger r = arc4random_uniform(256);
        comps[i] = (CGFloat)r/255.f;
    }
    
    return [UIColor colorWithRed:comps[0] green:comps[1] blue:comps[2] alpha:1.0];
}

@end

@interface TGLViewController ()

@property (nonatomic, weak) IBOutlet UIBarButtonItem *deselectItem;
@property (nonatomic, strong) IBOutlet UIView *collectionViewBackground;
@property (nonatomic, weak) IBOutlet UIButton *backgroundButton;

@property (nonatomic, strong, readonly) NSMutableArray *cards;

@property (nonatomic, strong) NSTimer *dismissTimer;

@end

@implementation TGLViewController
{
    NSUserDefaults *defaults;
}
@synthesize cards = _cards;

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        defaults = [NSUserDefaults standardUserDefaults];
        _cardCount = [[defaults objectForKey:@"CardList"] count];
        _cardSize = CGSizeMake(0, [[defaults objectForKey:@"CardHeight"] intValue]);
        
        _stackedLayoutMargin = UIEdgeInsetsMake(0.0, 10.0, _cardSize.height*1.5, 10.0);
        _stackedTopReveal = _cardSize.height/4;
        _stackedBounceFactor = 0.2;
        _stackedFillHeight = NO;
        _stackedCenterSingleItem = NO;
        _stackedAlwaysBounce = YES;
    }
    return self;
}

#pragma mark - View life cycle

- (void)viewDidLoad {

    [super viewDidLoad];

    defaults = [NSUserDefaults standardUserDefaults];
    // KLUDGE: Using the collection view's `-backgroundView`
    //         results in layout glitches when transitioning
    //         between stacked and exposed layouts.
    //         Therefore we add our background in between
    //         the collection view and the view controller's
    //         wrapper view.
    //
//    self.collectionViewBackground.hidden = !self.showsBackgroundView;
//    [self.view insertSubview:self.collectionViewBackground belowSubview:self.collectionView];

    // KLUDGE: Since our background is below the collection
    //         view it won't receive any touch events.
    //         Therefore we install an invisible/empty proxy
    //         view as the collection view's `-backgroundView`
    //         with the sole purpose to forward events to
    //         our background view.
    //
//    TGLBackgroundProxyView *backgroundProxy = [[TGLBackgroundProxyView alloc] init];
//    
//    backgroundProxy.targetView = self.collectionViewBackground;
//    backgroundProxy.hidden = self.collectionViewBackground.hidden;
//    
//    self.collectionView.backgroundView = backgroundProxy;
//    self.collectionView.showsVerticalScrollIndicator = self.showsVerticalScrollIndicator;

    self.exposedItemSize = self.cardSize;

    self.stackedLayout.itemSize = self.exposedItemSize;
    self.stackedLayout.layoutMargin = self.stackedLayoutMargin;
    self.stackedLayout.topReveal = self.stackedTopReveal;
    self.stackedLayout.bounceFactor = self.stackedBounceFactor;
    self.stackedLayout.fillHeight = self.stackedFillHeight;
    self.stackedLayout.centerSingleItem = self.stackedCenterSingleItem;
    self.stackedLayout.alwaysBounce = self.stackedAlwaysBounce;
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    if (!self.collectionViewBackground.hidden) {

        // KLUDGE: Make collection view transparent
        //         to let background view show through
        //
        // See also: -viewDidLoad
        //
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}

#pragma mark - Accessors

- (void)setCardCount:(NSInteger)cardCount {

    if (cardCount != _cardCount) {
        
        _cardCount = cardCount;
        
        _cards = nil;
        
        if (self.isViewLoaded) [self.collectionView reloadData];
    }
}

- (NSMutableArray *)cards {

    if (_cards == nil) {
        
        _cards = [NSMutableArray array];
        
        // Adjust the number of cards here
        //
        for (NSInteger i = 1; i <= self.cardCount; i++) {
            
            NSDictionary *card = @{ @"name" : [NSString stringWithFormat:@"Card #%d", (int)i], @"color" : [UIColor randomColor] };
            
            [_cards addObject:card];
        }
    }
    
    return _cards;
}

#pragma mark - Key-Value Coding

- (void)setValue:(id)value forKeyPath:(nonnull NSString *)keyPath {
    
    // Add key-value coding capabilities for some extra properties
    //
    if ([keyPath hasPrefix:@"cardSize."]) {
        
        CGSize cardSize = self.cardSize;
        
        if ([keyPath hasSuffix:@".width"]) {
            cardSize.width = [value doubleValue];
        } else if ([keyPath hasSuffix:@".height"]) {
            cardSize.height = [value doubleValue];
        }
        self.cardSize = cardSize;
        
    } else if ([keyPath containsString:@"edLayoutMargin."]) {
        NSString *layoutKey = [keyPath componentsSeparatedByString:@"."].firstObject;
        UIEdgeInsets layoutMargin = [layoutKey isEqualToString:@"stackedLayoutMargin"] ? self.stackedLayoutMargin : self.exposedLayoutMargin;
        
        if ([keyPath hasSuffix:@".top"]) {
            layoutMargin.top = [value doubleValue];
            
        } else if ([keyPath hasSuffix:@".left"]) {
            layoutMargin.left = [value doubleValue];
            
        } else if ([keyPath hasSuffix:@".right"]) {
            layoutMargin.right = [value doubleValue];
        }
        
        [self setValue:[NSValue valueWithUIEdgeInsets:layoutMargin] forKey:layoutKey];
        
    } else {
        
        [super setValue:value forKeyPath:keyPath];
    }
}

#pragma mark - UICollectionViewDataSource protocol
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.delegate collectionView:collectionView numberOfItemsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.delegate collectionView:collectionView cellForItemAtIndexPath:indexPath];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.delegate collectionView:collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

#pragma mark - UICollectionViewDragDelegate protocol

//- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(11) {
//    
//    NSArray<UIDragItem *> *dragItems = [super collectionView:collectionView itemsForBeginningDragSession:session atIndexPath:indexPath];
//    
//    // Attach custom drag previews preserving
//    // cards' rounded corners
//    //
//    for (UIDragItem *item in dragItems) {
//        
//        item.previewProvider = ^UIDragPreview * {
//            
//            UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//            
//            UIDragPreviewParameters *parameters = [[UIDragPreviewParameters alloc] init];
//            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:10.0];
//            
//            parameters.visiblePath = path;
//            
//            return [[UIDragPreview alloc] initWithView:cell parameters:parameters];
//        };
//    }
//    
//    return dragItems;
//}

- (UIDragPreviewParameters *)collectionView:(UICollectionView *)collectionView dragPreviewParametersForItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(11) {
    
    // This seems to be necessary, to preserve
    // cards' rounded corners during lift animation
    //
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    UIDragPreviewParameters *parameters = [[UIDragPreviewParameters alloc] init];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:10.0];
    
    parameters.visiblePath = path;
    
    return parameters;
}

#pragma mark - Helpers

- (void)stopDismissTimer {
    
    [self.dismissTimer invalidate];
    self.dismissTimer = nil;
}

@end
