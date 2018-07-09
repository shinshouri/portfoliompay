//
//  ViewController.m
//
//  Created by MC on 6/19/15.
//

#import "ParentViewController.h"
#import "PushPassword.h"
#import "Login.h"
#include <sys/stat.h>

@interface ParentViewController ()

@end

@implementation ParentViewController
{
    UIPickerView *picker;
    UIAlertView *alert;
    UIViewController *viewController;
    int sc;
}
@synthesize window;

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
    //background image
    [bgimage removeFromSuperview];
    bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [self view].frame.size.width, [self view].frame.size.height)];
//    [bgimage setImage:[UIImage imageNamed:@"bgwhite.png"]];
    [bgimage setBackgroundColor:[self colorFromHexString:Color0 withAlpha:1.0]];
    [[self view] addSubview:bgimage];
    
    //Gradient background
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height-20);
//    gradientLayer.colors = [NSArray arrayWithObjects:
//                            (id)[self colorFromHexString:@"#30D2AC" withAlpha:1.0].CGColor,
//                            (id)[self colorFromHexString:@"#3273FA" withAlpha:1.0].CGColor,
//                            nil];
//    gradientLayer.locations = [NSArray arrayWithObjects:
//                               [NSNumber numberWithFloat:0.0f],
//                               [NSNumber numberWithFloat:1.0f],
//                               nil];
//    gradientLayer.cornerRadius = self.view.layer.cornerRadius;
//    [self.view.layer addSublayer:gradientLayer];
    
    //Gesture hide keyboard
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondToTapGesture)];
    
    //Navigation Property
//    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
//    [[[self navigationController] navigationBar] setBarTintColor:[self colorFromHexString:Color1 withAlpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[self colorFromHexString:Color1 withAlpha:1.0]}];
    [[[self navigationController] navigationBar] setTintColor:[self colorFromHexString:Color1 withAlpha:1.0]];
    
    //Hilangkan Back string
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self navigationController].navigationBar.barStyle = UIBarStyleDefault;
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //disable back when swipe
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    //dismis alertview when enter background
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification* notification){
        [alert dismissWithClickedButtonIndex:0 animated:NO];
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [[self view] endEditing:YES];
}

-(void)viewDidDisappear:(BOOL)animated {
    [[self view] endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)ECardAssets:(id)sender withFrame:(CGRect)frame withImage:(NSString*)name withBalance:(NSString*)balance withCardNumber:(NSString*)cardnumber withCardType:(NSString*)cardtype withTag:(int)i {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.layer.cornerRadius = 10;
    [view setClipsToBounds:YES];
    [view setTag:i];
    
    UIImageView *imgview = [self UIImageServer:sender withFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) withImageName:name];
//    [imgview setAlpha:0.6];
    [imgview setTag:i];
    [view addSubview:imgview];
    
    [view addSubview:[self UILabelwithWhiteText:self withFrame:CGRectMake(20, 10, view.frame.size.width, 20) withText:@"myBalance" withTextSize:textsize12 withAlignment:0 withLines:0]];
    
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([balance rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        // newString consists only of the digits 0 through 9
        [view addSubview:[self UILabelwithWhiteText:self withFrame:CGRectMake(20, 25, view.frame.size.width, 40) withText:[NSString stringWithFormat:@"%@ %@", [[defaults objectForKey:@"language"] isEqualToString:@"id"] ? @"Rp" : @"IDR", [self FormatNumber:self from:balance]] withTextSize:textsize16 withAlignment:0 withLines:0]];
    } else {
        [view addSubview:[self UILabelwithWhiteText:self withFrame:CGRectMake(20, 25, view.frame.size.width, 40) withText:balance withTextSize:textsize16 withAlignment:0 withLines:0]];
    }
    
    [view addSubview:[self UIImage:self withFrame:CGRectMake(20, view.frame.size.height-45, 8, 8) withImageName:@"dot.png"]];
    [view addSubview:[self UIImage:self withFrame:CGRectMake(31, view.frame.size.height-45, 8, 8) withImageName:@"dot.png"]];
    [view addSubview:[self UIImage:self withFrame:CGRectMake(41, view.frame.size.height-45, 8, 8) withImageName:@"dot.png"]];
    [view addSubview:[self UIImage:self withFrame:CGRectMake(51, view.frame.size.height-45, 8, 8) withImageName:@"dot.png"]];
    [view addSubview:[self UILabelwithWhiteText:self withFrame:CGRectMake(62, view.frame.size.height-50, view.frame.size.width, 20) withText:cardnumber withTextSize:14 withAlignment:0 withLines:0]];
    
    [view addSubview:[self UIButton:self withFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) withTitle:@"" withTag:i]];
    
    return view;
}

-(UIView *)CardAssets:(id)sender withFrame:(CGRect)frame withImage:(NSString*)name withBalance:(NSString*)balance withCardNumber:(NSString*)cardnumber withCardExp:(NSString*)cardexp withCardType:(NSString*)cardtype withTag:(int)i {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.layer.cornerRadius = 10;
    [view setClipsToBounds:YES];
    [view setTag:i];
    
    UIImageView *imgview = [self UIImageServer:sender withFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) withImageName:name];
    [view addSubview:imgview];
    
    [view addSubview:[self UIImage:self withFrame:CGRectMake(20, view.frame.size.height-45, 8, 8) withImageName:@"dot.png"]];
    [view addSubview:[self UIImage:self withFrame:CGRectMake(31, view.frame.size.height-45, 8, 8) withImageName:@"dot.png"]];
    [view addSubview:[self UIImage:self withFrame:CGRectMake(41, view.frame.size.height-45, 8, 8) withImageName:@"dot.png"]];
    [view addSubview:[self UIImage:self withFrame:CGRectMake(51, view.frame.size.height-45, 8, 8) withImageName:@"dot.png"]];
    [view addSubview:[self UILabelwithWhiteText:self withFrame:CGRectMake(62, view.frame.size.height-50, view.frame.size.width, 20) withText:cardnumber withTextSize:14 withAlignment:0 withLines:0]];
    [view addSubview:[self UILabelwithWhiteText:self withFrame:CGRectMake(20, view.frame.size.height-30, view.frame.size.width, 20) withText:[NSString stringWithFormat:@"%@ %@", @"EXP", cardexp] withTextSize:14 withAlignment:0 withLines:0]];
    
    [view addSubview:[self UIButton:self withFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) withTitle:@"" withTag:i]];
    
    return view;
}

-(UIView*)UIView:(id)sender withFrame:(CGRect)frame {
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view setBackgroundColor:[UIColor clearColor]];
//    view.backgroundColor = [self colorFromHexString:@"#FAFAFA" withAlpha:1.0];
    return view;
}

-(UIImageView*)UIImageServer:(id)sender withFrame:(CGRect)frame withImageName:(NSString *)name  {
    UIImageView *img = [[UIImageView alloc] init];
    img.frame = frame;
//    img.image = [PCUtils getImageFromFolder:@"img" andFilename:name];
    img.backgroundColor = [UIColor clearColor];
    return img;
}

-(UIImageView*)UIImage:(id)sender withFrame:(CGRect)frame withImageName:(NSString *)name  {
    UIImageView *img = [[UIImageView alloc] init];
    img.frame = frame;
    img.image = [[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], name]];
    img.backgroundColor = [UIColor clearColor];
    return img;
}

-(UIImageView*)UIImageGIF:(id)sender withFrame:(CGRect)frame withImageName:(NSString*)name {
    UIImageView* animatedimg = [[UIImageView alloc] initWithFrame:frame];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:name withExtension:@"gif"];
    
    animatedimg.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    
    return animatedimg;
}

-(UILabel*)UILabel:(id)sender withFrame:(CGRect)frame withText:(NSString *)text withTextSize:(int)size withAlignment:(int)Align withLines:(int)line {
    UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
    lbl.text = text;
    lbl.textColor = [self colorFromHexString:Color2 withAlpha:1.0];
    lbl.font = [UIFont systemFontOfSize:size];
    lbl.textAlignment = Align == 0 ? NSTextAlignmentLeft : Align == 1 ? NSTextAlignmentCenter : NSTextAlignmentRight;
    lbl.lineBreakMode = NSLineBreakByWordWrapping;
    lbl.numberOfLines = line;
    return lbl;
}

-(UILabel*)UILabelwithWhiteText:(id)sender withFrame:(CGRect)frame withText:(NSString *)text withTextSize:(int)size withAlignment:(int)Align withLines:(int)line {
    UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
    lbl.text = text;
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont boldSystemFontOfSize:size];
    lbl.textAlignment = Align == 0 ? NSTextAlignmentLeft : Align == 1 ? NSTextAlignmentCenter : NSTextAlignmentRight;
    lbl.lineBreakMode = NSLineBreakByWordWrapping;
    lbl.numberOfLines = line;
    return lbl;
}

-(UILabel*)UILabelwithBlackText:(id)sender withFrame:(CGRect)frame withText:(NSString *)text withTextSize:(int)size withAlignment:(int)Align withLines:(int)line {
    UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
    lbl.text = text;
    lbl.textColor = [UIColor blackColor];
    lbl.font = [UIFont boldSystemFontOfSize:size];
    lbl.textAlignment = Align == 0 ? NSTextAlignmentLeft : Align == 1 ? NSTextAlignmentCenter : NSTextAlignmentRight;
    lbl.lineBreakMode = NSLineBreakByWordWrapping;
    lbl.numberOfLines = line;
    return lbl;
}

-(UITextField*)UITextField:(id)sender withFrame:(CGRect)frame withText:(NSString *)text withSize:(int)size withInputType:(UIKeyboardType)input withSecure:(int)sec {
    UITextField *txt = [[UITextField alloc] initWithFrame:frame];
    txt.attributedPlaceholder = [[NSAttributedString alloc]
                                 initWithString:text
                                 attributes:@{NSForegroundColorAttributeName:[self colorFromHexString:Color8 withAlpha:1.0]}];
    txt.textColor = [self colorFromHexString:Color7 withAlpha:1.0];
    txt.font = [UIFont systemFontOfSize:size];
    txt.keyboardType = input;
    txt.secureTextEntry = sec == 1 ? YES : NO;
    txt.backgroundColor = [UIColor clearColor];
    txt.delegate = sender;
    return txt;
}

-(UIButton*)UIButton:(id)sender withFrame:(CGRect)frame withTitle:(NSString*)title withTag:(int)tag {
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[self colorFromHexString:Color0 withAlpha:1.0] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(Act:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTag:tag];
    [[btn titleLabel] setFont:[UIFont boldSystemFontOfSize:16]];
    [[btn layer] setCornerRadius:22];
//    [[btn layer] setShadowOffset:CGSizeMake(3, 3)];
//    [[btn layer] setShadowColor:[UIColor blackColor].CGColor];
//    [[btn layer] setShadowRadius:3];
//    [[btn layer] setShadowOpacity:0.5];
    return btn;
}

-(UITableView*)UITableView:(id)sender withFrame:(CGRect)frame withStyle:(int)tablestyle {
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:tablestyle == 0 ? UITableViewStylePlain : UITableViewStyleGrouped];
    [tableView setDelegate:sender];
    [tableView setDataSource:sender];
    [tableView setBackgroundColor:[UIColor whiteColor]];
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    return tableView;
}

-(UIPickerView *)UIPickerView:(id)sender withFrame:(CGRect)frame withTag:(NSInteger)tag {
    picker = [[UIPickerView alloc] initWithFrame:frame];
    [picker setShowsSelectionIndicator:YES];
    [picker setDataSource:sender];
    [picker setDelegate:sender];
    [picker setTag:tag];
    [picker setBackgroundColor:[UIColor whiteColor]];
    
    return picker;
}

-(UISwitch *)UISwitch:(id)sender withFrame:(CGRect)frame {
    UISwitch *switcher = [[UISwitch alloc] initWithFrame:frame];
    [switcher setOn:YES];
    [switcher setTag:99];
    [switcher addTarget:self
                      action:@selector(Act:)
            forControlEvents:UIControlEventValueChanged];
    return switcher;
}

-(UIScrollView *) ScrollViewWithButton:(int)btn kolom:(int)column baris:(int)row buttonsize:(int)size withx:(int)x withy:(int)y withwidth:(int)lebar withheight:(int)tinggi withimg:(NSArray*)img withlabel:(NSArray*)label {
    int page = 0;
    int currpage = 0;
    int currrow = 1;
    int nextpadleft = (lebar-(size*column))/(column+1);
    int nextpadtop = (tinggi-(size*row))/(row+1);
    if (btn % (column * row) == 0) {
        page = btn/(column*row);
    }
    else
    {
        page = (btn/(column*row))+1;
    }
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, lebar, tinggi)];
    scrollview.pagingEnabled = YES;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.backgroundColor = [UIColor clearColor];
    scrollview.contentSize = CGSizeMake(lebar*page, tinggi);
    
    for (int i = 1; i <= btn; i++) {
        UIButton *t = [[UIButton alloc] initWithFrame:CGRectMake(nextpadleft, nextpadtop, size, size)];
        [t setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], [img objectAtIndex:i-1]]] forState:UIControlStateNormal];
        [t addTarget:self action:@selector(Act:) forControlEvents:UIControlEventTouchUpInside];
        [t setBackgroundColor:[UIColor clearColor]];
        [t setTag:i];
        [scrollview addSubview:t];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(nextpadleft, nextpadtop+size, size, 30)];
        [label1 setTextColor:[UIColor whiteColor]];
        [label1 setBackgroundColor:[UIColor clearColor]];
        [label1 setTextAlignment:NSTextAlignmentCenter];
        [label1 setText:[label objectAtIndex:i-1]];
        [label1 setFont:[UIFont boldSystemFontOfSize:12]];
        label1.numberOfLines = 0;
        [label1 sizeToFit];
        [scrollview addSubview:label1];
        
        if (i % (column*row) == 0) {
            currpage = currpage + 1;
            nextpadtop = (tinggi-(size*row))/(row+1);
            nextpadleft = (lebar-(size*column))/(column+1)+(lebar*currpage);
            currrow = 1;
        }
        else if(i % column == 0) {
            currrow = currrow + 1;
            nextpadtop = (((tinggi-(size*row))/(row+1))*currrow)+(size*(currrow-1));
            nextpadleft = (lebar-(size*column))/(column+1)+(lebar*currpage);
        }
        else
        {
            nextpadleft = nextpadleft + (lebar-(size*column))/(column+1) + size;
        }
    }
    
    return scrollview;
}

-(UIScrollView *) ScrollViewWithImage:(NSArray*)img withx:(int)x withy:(int)y withwidth:(int)lebar withheight:(int)tinggi {
    if (img == nil) {
        return 0;
    }
    int currpage = 0;
    int nextpadleft = 0;
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(x, y, lebar, tinggi)];
    scrollview.pagingEnabled = YES;
    scrollview.backgroundColor = [UIColor clearColor];
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.contentSize = CGSizeMake(lebar*[img count], tinggi);
    
    for (int i = 0; i < [img count]; i++) {
        UIImageView *promoimage = [[UIImageView alloc] init];
        promoimage.frame = CGRectMake(nextpadleft, 0, lebar, tinggi);
        promoimage.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:[[img objectAtIndex:i] objectForKey:@"imageData"] options:0]];
        promoimage.backgroundColor = [UIColor clearColor];
        [scrollview addSubview:promoimage];
        
        currpage = currpage + 1;
        nextpadleft = lebar*currpage;
    }
    
    return scrollview;
}

- (void)Act:(id)sender {
    
}

- (UIColor *)transparentBlack {
    return [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
}

-(UIColor *)colorFromHexString:(NSString *)hexString withAlpha:(CGFloat)alpha {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}

- (UIView *)showmask {
    maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self view].bounds.size.width, [self view].bounds.size.height)];
    [maskView setBackgroundColor:[self transparentBlack]];
    
//    UIImageView* animatedImageView = [[UIImageView alloc] initWithFrame:CGRectMake((([self view].bounds.size.width/2)-25), ([self view].bounds.size.height/2)-25, 50, 50)];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"gif"];
//    animatedImageView.image = [UIImage animatedImageWithAnimatedGIFURL:url];
    
//    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
//    indicator.center = maskView.center;
//    [indicator startAnimating];
    DGActivityIndicatorView *indicator = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallGridPulse tintColor:[self colorFromHexString:Color1 withAlpha:1.0] size:50.0f];
    indicator.frame = CGRectMake(0.0f, 0.0f, 50.0f, 50.0f);
    indicator.center = maskView.center;
    [indicator startAnimating];
    [maskView addSubview: indicator];
    
//    [maskView addSubview:[self UILabelwithWhiteText:self withFrame:CGRectMake(0, (maskView.frame.size.height/2)+20, maskView.frame.size.width, 20) withText:L(@"Loading") withTextSize:textsize16 withAlignment:1 withLines:0]];
    
    return maskView;
}

-(UIView *)showProgressbar {
    maskProgressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self view].bounds.size.width, [self view].bounds.size.height)];
    [maskProgressView addSubview:[self UIImage:self withFrame:CGRectMake(0, 0, [self view].bounds.size.width, [self view].bounds.size.height) withImageName:@"splashscreen.png"]];
    [maskProgressView addSubview:[self UIImage:self withFrame:CGRectMake(maskProgressView.frame.size.width/4, (maskProgressView.frame.size.height/2)-([self view].frame.size.height/5), maskProgressView.frame.size.width/2, [self view].frame.size.height/10) withImageName:@"helo.png"]];
    
    progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.center = maskProgressView.center;
    progressView.transform = CGAffineTransformMakeScale(1.0f, 5.0f);
    [[progressView layer] setCornerRadius:10];
    [progressView setTintColor:[UIColor whiteColor]];
    
    [maskProgressView addSubview:[self UILabelwithWhiteText:self withFrame:CGRectMake(0, (maskProgressView.frame.size.height/2)+20, maskProgressView.frame.size.width, 20) withText:@"updating" withTextSize:textsize16 withAlignment:1 withLines:0]];
    
    [maskProgressView addSubview:progressView];
    
    return maskProgressView;
}

-(NSString*)FormatNumber:(id)sender from:(NSString*)value {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    if ([[defaults objectForKey:@"language"] isEqualToString:@"id"]) {
        [formatter setGroupingSeparator:@"."];
        [formatter setDecimalSeparator:@","];
    }
    return [formatter stringFromNumber:@([value intValue])];
}

-(NSString*)FormatDate:(id)sender from:(NSDate*)date withFormat:(NSString*)format {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:date];
}

-(NSString*)L:(NSString*)str {
    return str;
}

-(void)UILine:(id)sender :(CGRect)frame {
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = [self colorFromHexString:@"#6E6E6E" withAlpha:1.0];
    [[self view] addSubview:line];
}

-(void)SendSMS:(id)sender withText:(NSString*)text withPhoneNumber:(NSString*)phonenumber {
//    [PCUtils sendSMS:text withRecipients:phonenumber andViewController:self];
}

- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

-(void)GotoPage:(id)sender withIdentifier:(NSString*)Identifier {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    viewController = [storyboard instantiateViewControllerWithIdentifier:Identifier];
    
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
}

-(BOOL)IsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

#pragma mark - Alert
- (void)showAlert:(NSString*)alertMessage title:(NSString*)title btn:(NSString*)btn tag:(int)tag delegate:(id)delegate {
    dispatch_async(dispatch_get_main_queue(), ^{
        alert = [[UIAlertView alloc]initWithTitle:title
                                                       message:alertMessage
                                                      delegate:delegate
                                             cancelButtonTitle:btn
                                             otherButtonTitles:nil];
        
        if (tag > 0) [alert setTag:tag];
        [alert show];
    });
}

- (void)showAlert2:(NSString*)alertMessage title:(NSString*)title btn1:(NSString*)btn1 btn2:(NSString*)btn2 tag:(int)tag delegate:(id)delegate {
    dispatch_async(dispatch_get_main_queue(), ^{
        alert = [[UIAlertView alloc]initWithTitle:title
                                                        message:alertMessage
                                                    delegate:delegate
                                            cancelButtonTitle:btn1
                                            otherButtonTitles:btn2, nil];
        if (tag > 0) [alert setTag:tag];
        [alert show];
    });
}

-(void)showRedAlert:(NSString*)alertMessage title:(NSString*)title {
    redAlert = [self UIView:self withFrame:CGRectMake(0, 70, [self view].frame.size.width, 50)];
    [redAlert setBackgroundColor:[UIColor redColor]];
    [redAlert addSubview:[self UILabelwithWhiteText:self withFrame:CGRectMake(20, 0, redAlert.frame.size.width-40, redAlert.frame.size.height) withText:alertMessage withTextSize:textsize12 withAlignment:0 withLines:0]];
    [redAlert addSubview:[self UIImage:self withFrame:CGRectMake(redAlert.frame.size.width-20, 20, 10, 10) withImageName:@"Close.png"]];
    UIButton *x = [self UIButton:self withFrame:CGRectMake(redAlert.frame.size.width-20, 10, 20, 20) withTitle:@"" withTag:123];
    [x addTarget:self action:@selector(closeview) forControlEvents:UIControlEventTouchUpInside];
//    [x setImage:[UIImage imageNamed:@"Close.png"] forState:UIControlStateNormal];
    [redAlert addSubview:x];
    [[self view] addSubview:redAlert];
}

-(void)closeview {
    [redAlert removeFromSuperview];
}

-(void)respondToTapGesture {
    [[self view] endEditing:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)copyright:(id)delegate :(NSString*)A :(NSString*)B {
    if ([A isEqualToString:@"MC"] && [B isEqualToString:@"MC"]) {
        if (sc == 28) {
            sc = 0;
            [self showAlert:@"Cr8 By MCarolius" title:@"" btn:@"OK" tag:0 delegate:self];
        } else {
            sc = sc + 1;
        }
    }
    
}

#pragma mark - Segue Delegate
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self respondToTapGesture];
}

#pragma mark - Networking
-(void)RequestData:(id)sender withAction:(NSString*)action withParams:(NSDictionary*)params {
    @try {
        if(params == nil) {
            params = [NSDictionary dictionary];
        }
        
        response = nil;
        if ([action isEqualToString:@"Login"] || [action isEqualToString:@"mobileBankingStatus"] || [action isEqualToString:@"AuthenticationPassword"]) {
//            response = (NSDictionary*) [PCNetworking doSynchronousSendToServerWithAction:action andData:params andDownloadModules:YES];
        } else {
//            response = (NSDictionary*) [PCNetworking doSynchronousSendToServerWithAction:action andData:params];
        }
        
        if ([[response objectForKey:@"ok"] intValue] == 0) {
            if ([[response objectForKey:@"message"] containsString:@"||||"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [defaults setObject:@"N" forKey:@"StatusLogin"];
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    Login *myVC = (Login *)[storyboard instantiateViewControllerWithIdentifier:@"RootLogin"];
                    [myVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                    [[self topViewController] presentViewController:myVC animated:NO completion:nil];
                });
            }
        }
        
    } @catch (NSException *exception) {
//        NSLog(@"exception %@", exception);
//        [self showAlert:[NSString stringWithFormat:@"%@", exception] title:@"Warning!" tag:0 delegate:self];
    }
}

-(NSString*)encryptHSM:(NSString*)values withRNumber:(NSString*)rnmbr withVal:(NSString*)val withExpo:(NSString*)expo {
    NSString *EncryptMin = [[NSString alloc] initWithData:nil encoding:NSASCIIStringEncoding];
    NSString *obm = [[NSString alloc] initWithData:nil encoding:NSASCIIStringEncoding];
    NSString *EO = [EncryptMin stringByAppendingString:obm];
    
    JSContext *context = [JSContext new];
    [context evaluateScript:EO];
    
    [context setExceptionHandler:^(JSContext *con, JSValue *val) {
//        NSLog(@"%@", [val toString]);
    }];
    
    JSValue *jsFunction = context[@"do_encrypt"];
    JSValue *value = [jsFunction callWithArguments:@[values, rnmbr, @"SHA2-256",  val, expo]];
    
    NSDictionary *resultdic = [value toDictionary];
    NSString *result = [NSString stringWithFormat:@"%@|%@", [[resultdic objectForKey:@"params"] objectForKey:@"encryptedPassword"], [[resultdic objectForKey:@"params"] objectForKey:@"encodingParameter"]];
    return result;
    
}

-(NSString*)encryptHSMPIN:(NSString*)value1 :(NSString*)value2 withRNumber:(NSString*)rnmbr withVal:(NSString*)val withExpo:(NSString*)expo {
    NSString *EncryptMin = [[NSString alloc] initWithData:nil encoding:NSASCIIStringEncoding];
    NSString *obm = [[NSString alloc] initWithData:nil encoding:NSASCIIStringEncoding];
    NSString *EO = [EncryptMin stringByAppendingString:obm];
    
    JSContext *context = [JSContext new];
    [context evaluateScript:EO];
    
    [context setExceptionHandler:^(JSContext *con, JSValue *val) {
        //        NSLog(@"%@", [val toString]);
    }];
    
    JSValue *jsFunction = context[@"do_encrypt_change_PIN"];
    JSValue *value = [jsFunction callWithArguments:@[value1, value2, rnmbr, @"SHA2-256",  val, expo]];
    
    NSDictionary *resultdic = [value toDictionary];
    NSString *result = [NSString stringWithFormat:@"%@|%@", [[resultdic objectForKey:@"params"] objectForKey:@"encryptedPassword"], [[resultdic objectForKey:@"params"] objectForKey:@"encodingParameter"]];
    return result;
    
}

/*========================================EDITING========================================*/

- (UITextField *)CustomTextField:(CGRect)frame withStrPlcHolder:(NSString *)strPlcHolder withAttrColor:(NSString *)attrColor keyboardType:(UIKeyboardType)type withTextColor:(NSString *)textColor withFontSize:(CGFloat)fontSize withTag:(int)tag withDelegate:(id)sender{
    UIColor *color = [self colorFromHexString:Color8 withAlpha:1.0];
    UIColor *txtColor = [self colorFromHexString:Color7 withAlpha:1.0];
    if(attrColor != nil){
        color = [self colorFromHexString:attrColor withAlpha:1.0];
    }
    
    if(textColor != nil){
        txtColor = [self colorFromHexString:textColor withAlpha:1.0];
    }
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:strPlcHolder attributes:@{NSForegroundColorAttributeName: color}];
    [textField setTextColor:txtColor];
    [textField setKeyboardType:type];
    
    [textField setFont:[UIFont systemFontOfSize:fontSize]];
    [textField setSpellCheckingType:UITextSpellCheckingTypeNo];
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textField setTag:tag];
    [textField setDelegate:sender];
    
    CALayer *newLayer = [CALayer layer];
    
    CGFloat flHeight = textField.frame.size.height;
    CGFloat flWidth = textField.frame.size.width;
    newLayer.frame = CGRectMake(0, flHeight-10, flWidth, 1);
    newLayer.backgroundColor = [[self colorFromHexString:Color4 withAlpha:0.2] CGColor];
    newLayer.name = @"bottomLayer";
    
    [[textField layer] addSublayer:newLayer];
    
    return textField;
}

- (UITextField *)PasswordTextField:(CGRect)frame withStrPlcHolder:(NSString *)strPlcHolder withAttrColor:(NSString *)attrColor keyboardType:(UIKeyboardType)type withTextColor:(NSString *)textColor withFontSize:(CGFloat)fontSize withTag:(int)tag withDelegate:(id)sender{
    UIColor *color = [self colorFromHexString:Color8 withAlpha:1.0];
    UIColor *txtColor = [self colorFromHexString:Color7 withAlpha:1.0];
    if(attrColor != nil){
        color = [self colorFromHexString:attrColor withAlpha:1.0];
    }
    
    if(textColor != nil){
        txtColor = [self colorFromHexString:textColor withAlpha:1.0];
    }
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:strPlcHolder attributes:@{NSForegroundColorAttributeName: color}];
    [textField setTextColor:txtColor];
    [textField setKeyboardType:type];
    
    [textField setFont:[UIFont systemFontOfSize:fontSize]];
    [textField setSpellCheckingType:UITextSpellCheckingTypeNo];
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textField setTag:tag];
    [textField setDelegate:sender];
    
    [textField setSecureTextEntry:true];
    
    
    CALayer *newLayer = [CALayer layer];
    
    CGFloat flHeight = textField.frame.size.height;
    CGFloat flWidth = textField.frame.size.width;
    newLayer.frame = CGRectMake(0, flHeight - 10, flWidth, 1);
    newLayer.backgroundColor = [[self colorFromHexString:Color4 withAlpha:0.2] CGColor];
    if(attrColor != nil){
        newLayer.backgroundColor = [[self colorFromHexString:Color4 withAlpha:0.2] CGColor];
    }
    newLayer.name = @"bottomLayer";
    
    [[textField layer] addSublayer:newLayer];
    return textField;
}

- (void)required:(id)sender withMsg:(NSString *)msg{
    if([[[[[sender layer] sublayers] objectAtIndex:0] name] isEqualToString:@"bottomLayer"]){
        [self removeValidationIcon:sender withColor:nil];
        CALayer *newLayer = [CALayer layer];
        
        CGFloat flHeight = [sender frame].size.height;
        CGFloat flWidth = [sender frame].size.width;
        newLayer.frame = CGRectMake(0, flHeight - 10, flWidth, 1);
        newLayer.backgroundColor = [UIColor redColor].CGColor;
        newLayer.name = @"bottomLayer";
        
        [[sender layer] replaceSublayer:[[[sender layer] sublayers] objectAtIndex:0] with:newLayer];
        if(msg != nil){
            [self advValidation:sender withText:[NSString stringWithFormat:msg, [sender placeholder]]];
        }else{
            [self advValidation:sender withText:[NSString stringWithFormat:@"%@ %@", [sender placeholder], @"isRequired"]];
        }
    }
}

- (void)requiredPassword:(id)sender withMsg:(NSString *)msg{
    if([[[[[sender layer] sublayers] objectAtIndex:0] name] isEqualToString:@"bottomLayer"]){
        [self removeValidationIconPassword:sender withColor:nil];
        CALayer *newLayer = [CALayer layer];
        
        CGFloat flHeight = [sender frame].size.height;
        CGFloat flWidth = [sender frame].size.width;
        newLayer.frame = CGRectMake(0, flHeight - 10, flWidth, 1);
        newLayer.backgroundColor = [UIColor redColor].CGColor;
        newLayer.name = @"bottomLayer";
        
        [[sender layer] replaceSublayer:[[[sender layer] sublayers] objectAtIndex:0] with:newLayer];
        
        [[sender layer] replaceSublayer:[[[sender layer] sublayers] objectAtIndex:0] with:newLayer];
        if(msg != nil){
            [self advValidation:sender withText:[NSString stringWithFormat:msg, [sender placeholder]]];
        }else{
            [self advValidation:sender withText:[NSString stringWithFormat:@"%@ %@", [sender placeholder], @"isRequired"]];
        }
    }
}

- (void)removeValidationIcon:(id)sender withColor:(NSString *)color{
    if([[[[[sender layer] sublayers] objectAtIndex:0] name] isEqualToString:@"bottomLayer"]){
        for (UITextView *v in [sender subviews]) {
            if(v.tag == 202020){
                [v removeFromSuperview];
            }
        }
        
        UIColor *attrColor = [self colorFromHexString:@"#9B9B9B" withAlpha:0.2];
        
        if(color != nil){
            attrColor = [self colorFromHexString:color withAlpha:0.2];
        }
        
        CALayer *newLayer = [CALayer layer];
        
        CGFloat flHeight = [sender frame].size.height;
        CGFloat flWidth = [sender frame].size.width;
        newLayer.frame = CGRectMake(0, flHeight - 10, flWidth, 1);
        newLayer.backgroundColor = [attrColor CGColor];
        newLayer.name = @"bottomLayer";
        
        [[sender layer] replaceSublayer:[[[sender layer] sublayers] objectAtIndex:0] with:newLayer];
    }
}
- (void)removeValidationIconPassword:(id)sender withColor:(NSString *)color{
    if([[[[[sender layer] sublayers] objectAtIndex:0] name] isEqualToString:@"bottomLayer"]){
        for (UITextView *v in [sender subviews]) {
            if(v.tag == 202020){
                [v removeFromSuperview];
            }
        }
        UIColor *attrColor = [self colorFromHexString:@"#9B9B9B" withAlpha:0.2];
        
        if(color != nil){
            attrColor = [self colorFromHexString:color withAlpha:0.2];
        }
        
        CALayer *newLayer = [CALayer layer];
        
        CGFloat flHeight = [sender frame].size.height;
        CGFloat flWidth = [sender frame].size.width;
        newLayer.frame = CGRectMake(0, flHeight - 10, flWidth, 1);
        newLayer.backgroundColor = [attrColor CGColor];
        newLayer.name = @"bottomLayer";
        
        [[sender layer] replaceSublayer:[[[sender layer] sublayers] objectAtIndex:0] with:newLayer];
    }
}

- (void)advValidation:(UITextField*)sender withText:(NSString*)text{
    if([[[[[sender layer] sublayers] objectAtIndex:0] name] isEqualToString:@"bottomLayer"]){
        UILabel *adv = [[UILabel alloc] initWithFrame:CGRectMake(0, sender.frame.size.height - 10, sender.frame.size.width, 10)];
        [adv setText:text];
        [adv setTextColor:[UIColor redColor]];
        [adv setFont:[UIFont systemFontOfSize:9]];
        [adv setBackgroundColor:[UIColor clearColor]];
        [adv setTag:202020];
        [sender addSubview:adv];
    }
}

- (UIButton *)btnPasswordImage:(CGRect)frame withTag:(int)tag{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn addTarget:self action:@selector(Act:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[[UIImage alloc] initWithContentsOfFile:[[NSString alloc] initWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], @"passopen.png"]] forState:UIControlStateNormal];
    [btn setTag:tag];
    
    return btn;
}

- (UITextField *)TextFieldWithButton:(CGRect)frame withPaddingWidth:(CGFloat)flWidth withStrPlcHolder:(NSString *)strPlcHolder withAttrColor:(NSString *)attrColor keyboardType:(UIKeyboardType)type withTextColor:(NSString *)textColor withFontSize:(CGFloat)fontSize withTag:(int)tag withDelegate:(id)sender{
    UIColor *color = [self colorFromHexString:Color8 withAlpha:1.0];
    UIColor *txtColor = [self colorFromHexString:Color7 withAlpha:1.0];
    if(attrColor != nil){
        color = [self colorFromHexString:attrColor withAlpha:1.0];
    }
    
    if(textColor != nil){
        txtColor = [self colorFromHexString:textColor withAlpha:1.0];
    }
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:strPlcHolder attributes:@{NSForegroundColorAttributeName: color}];
    [textField setTextColor:txtColor];
    [textField setKeyboardType:type];
    
    [textField setFont:[UIFont systemFontOfSize:fontSize]];
    [textField setSpellCheckingType:UITextSpellCheckingTypeNo];
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textField setTag:tag];
    [textField setDelegate:sender];
    
    CALayer *newLayer = [CALayer layer];
    
    CGFloat flHeight = textField.frame.size.height;
    newLayer.frame = CGRectMake(0, flHeight - 10, flWidth, 1);
    newLayer.backgroundColor = [[self colorFromHexString:@"#9B9B9B" withAlpha:0.2] CGColor];
    newLayer.name = @"bottomLayer";
    
    [[textField layer] addSublayer:newLayer];
    return textField;
}

- (UIButton *)btnText:(CGRect)frame withTag:(int)tag withTitle:(NSString *)title withFontSize:(int)fontSize withColor:(NSString *)color{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    [btn addTarget:self action:@selector(Act:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:tag];
    [btn setTitle:title forState:UIControlStateNormal];
    
    UIColor *clr = [self colorFromHexString:@"#14CD9A" withAlpha:1.0];
    if(color != nil){
        clr = [self colorFromHexString:color withAlpha:1.0];
    }
    
    [btn setTitleColor:clr forState:UIControlStateNormal];
    [[btn titleLabel] setFont:[UIFont systemFontOfSize:fontSize]];
    
    return btn;
}

- (void)requiredTextFieldWithButton:(id)sender withMsg:(NSString *)msg withPaddingWidth:(int)flWidth{
    if([[[[[sender layer] sublayers] objectAtIndex:0] name] isEqualToString:@"bottomLayer"]){
        [self removeValidationTextFieldWithButton:sender withColor:nil withPaddingWidth:flWidth];
        CALayer *newLayer = [CALayer layer];
        
        CGFloat flHeight = [sender frame].size.height;
        newLayer.frame = CGRectMake(0, flHeight -10, flWidth, 1);
        newLayer.backgroundColor = [UIColor redColor].CGColor;
        newLayer.name = @"bottomLayer";
        
        [[sender layer] replaceSublayer:[[[sender layer] sublayers] objectAtIndex:0] with:newLayer];
        
        [[sender layer] replaceSublayer:[[[sender layer] sublayers] objectAtIndex:0] with:newLayer];
        if(msg != nil){
            [self advValidation:sender withText:[NSString stringWithFormat:msg, [sender placeholder]]];
        }else{
            [self advValidation:sender withText:[NSString stringWithFormat:@"%@ %@", [sender placeholder], @"isRequired"]];
        }
    }
}

- (void)removeValidationTextFieldWithButton:(id)sender withColor:(NSString *)color withPaddingWidth:(int)flWidth{
    if([[[[[sender layer] sublayers] objectAtIndex:0] name] isEqualToString:@"bottomLayer"]){
        for (UITextView *v in [sender subviews]) {
            if(v.tag == 202020){
                [v removeFromSuperview];
            }
        }
        UIColor *attrColor = [self colorFromHexString:@"#6E6E6E" withAlpha:1.0];
        
        if(color != nil){
            attrColor = [self colorFromHexString:color withAlpha:1.0];
        }
        
        CALayer *newLayer = [CALayer layer];
        
        CGFloat flHeight = [sender frame].size.height;
        newLayer.frame = CGRectMake(0, flHeight -10, flWidth, 1);
        newLayer.backgroundColor = [[self colorFromHexString:@"#9B9B9B" withAlpha:0.2] CGColor];
        newLayer.name = @"bottomLayer";
        
        [[sender layer] replaceSublayer:[[[sender layer] sublayers] objectAtIndex:0] with:newLayer];
    }
}

-(NSString*)RandomNumber:(int)digit {
    NSString *a=@"";
    for (int i=0; i<digit ; i++) {
        a = [NSString stringWithFormat:@"%@%i", a, arc4random()%9];
    }
    return a;
}

-(NSString*)OjdfAjidfmsdpaA:(NSString*)ext :(NSString*)rn {
//    return [NSString stringWithFormat:@"%@%@%@", [rn substringToIndex:3], [PCUtils sha1:[NSString stringWithFormat:@"%@%@%@", [rn substringToIndex:3], [PCUtils sha1:[PCUtils md5:ext]], [rn substringFromIndex:3]]], [rn substringFromIndex:3]];
    return @"";
}

-(NSString*)QsCFtGbHyUJSdaWE {
        
    #if !TARGET_IPHONE_SIMULATOR
        
        //Apps and System check list
        BOOL isDirectory;
        if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Cyd", @"ia.a", @"pp"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"bla", @"ckra1n.a", @"pp"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Fake", @"Carrier.a", @"pp"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Ic", @"y.a", @"pp"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Inte", @"lliScreen.a", @"pp"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"MxT", @"ube.a", @"pp"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Roc", @"kApp.a", @"pp"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"SBSet", @"ttings.a", @"pp"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Wint", @"erBoard.a", @"pp"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/a", @"pt/"] isDirectory:&isDirectory]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/l", @"ib/c", @"ydia/"] isDirectory:&isDirectory]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/mobile", @"Library/SBSettings", @"Themes/"] isDirectory:&isDirectory]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/t", @"mp/cyd", @"ia.log"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"pr", @"iva",@"te/v", @"ar/s", @"tash/"] isDirectory:&isDirectory]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia/"] isDirectory:&isDirectory]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us", @"r/b",@"in", @"s", @"shd"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us", @"r/sb",@"in", @"s", @"shd"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/cy", @"dia/"] isDirectory:&isDirectory]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@", @"us", @"r/l",@"ibe", @"xe", @"c/sftp-", @"server"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@",@"Syste",@"tem/Lib",@"rary/Lau",@"nchDae",@"mons/com.ike",@"y.bbot.plist"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@%@",@"Sy",@"stem/Lib",@"rary/Laun",@"chDae",@"mons/com.saur",@"ik.Cy",@"@dia.Star",@"tup.plist"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"Libr",@"ary/Mo",@"bileSubstra",@"te/MobileSubs",@"trate.dylib"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"va",@"r/c",@"ach",@"e/a",@"pt/"] isDirectory:&isDirectory]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"va",@"r/l",@"ib",@"/apt/"] isDirectory:&isDirectory]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"va",@"r/l",@"ib/c",@"ydia/"] isDirectory:&isDirectory]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"va",@"r/l",@"og/s",@"yslog"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"private/va",@"r/c",@"ach",@"e/a",@"pt/"] isDirectory:&isDirectory]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"private/va",@"r/l",@"ib",@"/apt/"] isDirectory:&isDirectory]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"private/va",@"r/l",@"ib/c",@"ydia/"] isDirectory:&isDirectory]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@", @"private/va",@"r/l",@"og/s",@"yslog"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"bi",@"n/b",@"ash"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"b",@"in/",@"sh"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"private/et",@"c/a",@"pt/"]isDirectory:&isDirectory]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"et",@"c/a",@"pt/"]isDirectory:&isDirectory]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"private/etc/s",@"sh/s",@"shd_config"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"etc/s",@"sh/s",@"shd_config"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@", @"us",@"r/li",@"bexe",@"c/ssh-k",@"eysign"]]
            || [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.masbog.com"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"App", @"lic",@"ati", @"ons/", @"Snoop-it", @" Config.a", @"pp"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@%@%@%@%@", @"Library/MobileS", @"ubstrate/Dy",@"nami", @"cLi", @"braries/", @" xCon.", @"dylib"]]
            || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"/%@%@%@", @"priv",@"ate/etc/dpkg/",@"origins/debian"]])
            
        {
            return @"File";
        }
        
        // SandBox Integrity Check
        int pid = fork();
        if(!pid){
            exit(0);
        }
        if(pid>=0)
        {
            return @"SB";
        }
        
        //Symbolic link verification
        struct stat s;
        if(lstat("/Applications", &s) || lstat("/var/stash/Library/Ringtones", &s) || lstat("/var/stash/Library/Wallpaper", &s)
           || lstat("/var/stash/usr/include", &s) || lstat("/var/stash/usr/libexec", &s)  || lstat("/var/stash/usr/share", &s) || lstat("/var/stash/usr/arm-apple-darwin9", &s))
        {
            if(s.st_mode & S_IFLNK){
                return @"Link";
            }
        }
        
        //Try to write file in private
        NSError *error;
        
        FILE *f = NULL ;
        if ((f = fopen("/bin/bash", "r")) ||
            (f = fopen("/bin/sh", "r")) ||
            (f = fopen("/Applications/Cydia.app", "r")) ||
            (f = fopen("/Library/MobileSubstrate/MobileSubstrate.dylib", "r")) ||
            (f = fopen("/usr/sbin/sshd", "r")) ||
            (f = fopen("/etc/apt", "r")))  {
            fclose(f);
            return @"Write";
        }
        fclose(f);
        
        NSString *stringToBeWritten = @"Hello, MasBog Here!!!";
        [stringToBeWritten writeToFile:@"/private/masbog.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
        [[NSFileManager defaultManager] removeItemAtPath:@"/private/masbog.txt" error:nil];
        if(error == nil)
        {
            return @"Written";
        }
#endif
        return @"X1UaSDpOwQe0nf4";
    }
    
    NSString* isAppStore() {
        
#if TARGET_IPHONE_SIMULATOR
        return NO;
#else
        NSString *provisionPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
        
        if (nil == provisionPath || 0 == provisionPath.length) {
            
            return @"Path";
        }
        
        return @"X1UaSDpOwQe0nf4";
#endif
    }
    
    NSString* isCracked() {
#if !TARGET_IPHONE_SIMULATOR
        
        NSBundle *bundle = [NSBundle mainBundle];
        NSString* bundlePath = [bundle bundlePath];
        NSFileManager *manager = [NSFileManager defaultManager];
        static NSString *str;
        BOOL fileExists;
        
        //Check to see if the app is running on root
        int root = getgid();
        if (root <= 10) {
            return @"Root";
        }
        
        //Checking for identity signature
        char symCipher[] = { '(', 'H', 'Z', '[', '9', '{', '+', 'k', ',', 'o', 'g', 'U', ':', 'D', 'L', '#', 'S', ')', '!', 'F', '^', 'T', 'u', 'd', 'a', '-', 'A', 'f', 'z', ';', 'b', '\'', 'v', 'm', 'B', '0', 'J', 'c', 'W', 't', '*', '|', 'O', '\\', '7', 'E', '@', 'x', '"', 'X', 'V', 'r', 'n', 'Q', 'y', '>', ']', '$', '%', '_', '/', 'P', 'R', 'K', '}', '?', 'I', '8', 'Y', '=', 'N', '3', '.', 's', '<', 'l', '4', 'w', 'j', 'G', '`', '2', 'i', 'C', '6', 'q', 'M', 'p', '1', '5', '&', 'e', 'h' };
        char csignid[] = "V.NwY2*8YwC.C1";
        for(int i=0;i<strlen(csignid);i++)
        {
            for(int j=0;j<sizeof(symCipher);j++)
            {
                if(csignid[i] == symCipher[j])
                {
                    csignid[i] = j+0x21;
                    break;
                }
            }
        }
        NSString* signIdentity = [[NSString alloc] initWithCString:csignid encoding:NSUTF8StringEncoding];
        
        NSDictionary *info = [bundle infoDictionary];
        if ([info objectForKey:signIdentity] != nil)
        {
            return @"Siden";
        }
        
        // Check if the below .plist files exists in the app bundle
        fileExists = [manager fileExistsAtPath:([NSString stringWithFormat:@"%@/%@", bundlePath, [NSString stringWithFormat:@"%@%@%@%@", @"_C",@"odeS",@"igna",@"ture"]])];
        if (!fileExists) {
            return @"Plist";
        }
        
        
        fileExists = [manager fileExistsAtPath:([NSString stringWithFormat:@"%@/%@", bundlePath, [NSString stringWithFormat:@"%@%@%@%@", @"Re",@"sour",@"ceRules.p",@"list"]])];
        if (!fileExists) {
            return @"Siden";
        }
        
        
        fileExists = [manager fileExistsAtPath:([NSString stringWithFormat:@"%@/%@", bundlePath, [NSString stringWithFormat:@"%@%@%@%@", @"S",@"C_",@"In",@"fo"]])];
        if (!fileExists) {
            return @"Bundle";
        }
        
        
        //Check if the info.plist and exectable files have been modified
        str= [NSString stringWithFormat:@"%@%@%@%@", @"Pk",@"gI",@"nf",@"o"];
        NSDate* pkgInfoModifiedDate = [[manager attributesOfItemAtPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:str] error:nil] fileModificationDate];
        
        str= [NSString stringWithFormat:@"%@%@%@%@", @"In",@"fo.p",@"li",@"st"];
        NSString* infoPath = [NSString stringWithFormat:@"%@/%@", bundlePath,str];
        NSDate* infoModifiedDate = [[manager attributesOfItemAtPath:infoPath error:nil] fileModificationDate];
        if([infoModifiedDate timeIntervalSinceReferenceDate] > [pkgInfoModifiedDate timeIntervalSinceReferenceDate]) {
            return @"InfoPath";
        }
        
        str = [[bundle infoDictionary] objectForKey:@"CFBundleDisplayName"];
        NSString* appPathName = [NSString stringWithFormat:@"%@/%@", bundlePath,str];
        NSDate* appPathNameModifiedDate = [[manager attributesOfItemAtPath:appPathName error:nil]  fileModificationDate];
        if([appPathNameModifiedDate timeIntervalSinceReferenceDate] > [pkgInfoModifiedDate timeIntervalSinceReferenceDate]) {
            return @"Bundle";
        }
        
#endif
        return @"X1UaSDpOwQe0nf4";
}

@end
