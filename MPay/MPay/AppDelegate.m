//
//  AppDelegate.m
//  MPay
//
//  Created by Admin on 7/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "Register.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
{
    NSString *status;
    UIViewController *viewController;
    NSUserDefaults *defaults;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSDate date] forKey:@"TimeEnterBackground"];
    [defaults removeObjectForKey:@"Background"];
    [defaults removeObjectForKey:@"Register"];
    [defaults removeObjectForKey:@"ViewController"];
    [defaults removeObjectForKey:@"FromPush"];
    [defaults removeObjectForKey:@"PersonalInfo"];
//    [defaults removeObjectForKey:@"tnc"];
//    [defaults removeObjectForKey:@"FirstIn"];
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *each in cookieStorage.cookies) {
        [cookieStorage deleteCookie:each];
    }
    
//    [PCLib singleton];
    if (![defaults objectForKey:@"ApnsDeviceToken"]) {
        //Register Push Notification
        [defaults setObject:@"N" forKey:@"Fingerprint"];
    
        //Firebase Register Device Token
        [FIRApp configure];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kFIRInstanceIDTokenRefreshNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenRefreshNotification:) name:kFIRInstanceIDTokenRefreshNotification object:nil];
        
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max) {
            UIUserNotificationType allNotificationTypes =
            (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
            UIUserNotificationSettings *settings =
            [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        } else {
            // iOS 10 or later
#if defined(__IPHONE_10_0) && IPHONE_OS_VERSION_MAX_ALLOWED >= IPHONE_10_0
            UNAuthorizationOptions authOptions =
            UNAuthorizationOptionAlert
            | UNAuthorizationOptionSound
            | UNAuthorizationOptionBadge;
            [[UNUserNotificationCenter currentNotificationCenter]
             requestAuthorizationWithOptions:authOptions
             completionHandler:^(BOOL granted, NSError * _Nullable error) {
             }
             ];
            
            // For iOS 10 display notification (sent via APNS)
            [UNUserNotificationCenter currentNotificationCenter].delegate = self;
            // For iOS 10 data message (sent via FCM)
            [FIRMessaging messaging].remoteMessageDelegate = self;
#endif
        }
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
//    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//    [application registerForRemoteNotifications];
    
        if ([[defaults objectForKey:@"StatusLogin"] isEqualToString:@"Y"]) {
            if ([[[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey] objectForKey:@"action"] isEqualToString:@"pushTrx"])
            {
                NSLog(@"PUSHKILL");
                [defaults setObject:[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey] forKey:@"UserInfo"];
                [self GotoPage:self withIdentifier:@"PaymentID"];
            }
            else if ([[[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey] objectForKey:@"action"] isEqualToString:@"resetPassword"])
            {
                NSLog(@"PUSHKILL");
                [defaults setObject:[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey] forKey:@"UserInfo"];
                [self GotoPage:self withIdentifier:@"ResetNotif"];
            }
            else {
                [defaults setObject:@"Terminated" forKey:@"ViewController"];
                [self GotoPage:self withIdentifier:@"PushPassword"];
            }
        }
        else if ([[defaults objectForKey:@"StatusLogin"] isEqualToString:@"N"]) {
            if ([[[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey] objectForKey:@"action"] isEqualToString:@"pushTrx"])
            {
                [defaults setObject:[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey] forKey:@"UserInfo"];
                [defaults setObject:@"PushNoLogin" forKey:@"ViewController"];
                [self GotoPage:self withIdentifier:@"RootLogin"];
            }
            else if ([[[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey] objectForKey:@"action"] isEqualToString:@"resetPassword"])
            {
                [defaults setObject:[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey] forKey:@"UserInfo"];
                [self GotoPage:self withIdentifier:@"ResetNotif"];
            }
            else {
                [self GotoPage:self withIdentifier:@"RootLogin"];
            }
        }
    
//    [self GotoPage:self withIdentifier:@"RootHome"];
//    [self GotoPage:self withIdentifier:@"BTEST"];
    
//    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(ViewNotif:) userInfo:nil repeats:NO];
    
    return YES;
}

//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
//    NSString *urlParameter = [[url host] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"URL");
//    [self GotoPage:self withIdentifier:@"ResetNotif"];
    
//    return FALSE;
//}

- (void)tokenRefreshNotification:(NSNotification *)notification {
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
    
    NSString *didRegisterForRemoteNotificationsWithDeviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"didRegisterForRemoteNotificationsWithDeviceToken"];
    
    if(didRegisterForRemoteNotificationsWithDeviceToken && refreshedToken) {
        // allow to continue
        [defaults setObject:refreshedToken forKey:@"ApnsDeviceToken"];
        [defaults synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:@"ok" forKey:@"getTokenRefreshNotification"];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kFIRInstanceIDTokenRefreshNotification object:nil];
    }
    // Connect to FCM since connection may have failed when attempted before having a token.
    
    // TODO: If necessary send token to application server.
}

-(void)ViewNotif:(NSDictionary*)userInfo {
//    self.notification = [CWStatusBarNotification new];
//    [self.notification setClickedDelegate:self];
//    self.notification.notificationAnimationInStyle = CWNotificationAnimationStyleTop;
//    self.notification.notificationAnimationOutStyle = CWNotificationAnimationStyleTop;
//    self.notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
//    self.notification.notificationLabelBackgroundColor = [UIColor clearColor];
//
//    UIView *view = [[UIView alloc] init];
//    unsigned rgbValue = 0;
//    NSScanner *scanner = [NSScanner scannerWithString:@"#E2DAD8"];
//    [scanner setScanLocation:1]; // bypass '#' character
//    [scanner scanHexInt:&rgbValue];
//    [view setBackgroundColor:[UIColor lightGrayColor]];
////    [view setBackgroundColor:[UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0]];
//    [[view layer] setCornerRadius:10];
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, self.window.frame.size.width-40, 25)];
//    [title setText:@"Mandiri Pay"];
//    [title setTextAlignment:NSTextAlignmentLeft];
//    [title setFont:[UIFont systemFontOfSize:14]];
//    [view addSubview:title];
//    UIImageView *logo = [[UIImageView alloc] init];
//    logo.frame = CGRectMake(10, 10, 40, 40);
//    logo.image = [UIImage imageNamed:@"icon.png"];
//    [[logo layer] setCornerRadius:10];
//    [logo setClipsToBounds:YES];
//    [view addSubview:logo];
//    UILabel *msglabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 20, self.window.frame.size.width-100, 30)];
//    [msglabel setText:[[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"body"]];
//    [msglabel setFont:[UIFont systemFontOfSize:12]];
//    [msglabel setNumberOfLines:0];
//    [msglabel setLineBreakMode:NSLineBreakByWordWrapping];
//    [view addSubview:msglabel];
//    [self.notification displayNotificationWithView:view forDuration:30];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //set variable saat enter background
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeClick" object:nil];
    [defaults setObject:[NSDate date] forKey:@"TimeEnterBackground"];
    
    if ([[defaults objectForKey:@"StatusLogin"] isEqualToString:@"Y"]) {
        if (![[defaults objectForKey:@"Background"] isEqualToString:@"Password"]) {
            status = @"Background";
            [defaults setObject:@"Password" forKey:@"Background"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            PushPassword *myVC = (PushPassword *)[storyboard instantiateViewControllerWithIdentifier:@"PushPassword"];
            [[self topViewController] presentViewController:myVC animated:NO completion:nil];
        }
    }
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSDate* enteringBackground = [defaults objectForKey:@"TimeEnterBackground"];
    int timeInBackground = [[NSDate date] timeIntervalSince1970] - [enteringBackground timeIntervalSince1970];
    
    [defaults setObject:[NSString stringWithFormat:@"%i", timeInBackground] forKey:@"TimeEnterBackground"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetTimer" object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%@", [defaults objectForKey:@"StatusLogin"]);
    status = @"";
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)GotoPage:(id)sender withIdentifier:(NSString*)Identifier {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    viewController = [storyboard instantiateViewControllerWithIdentifier:Identifier];
    
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];
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

- (void)onNotificationTap {
    [[self notification] dismissNotification];
    
    if ([[defaults objectForKey:@"StatusLogin"] isEqualToString:@"Y"]) {
        if ([[[defaults objectForKey:@"UserInfo"] objectForKey:@"action"] isEqualToString:@"resetPassword"]) {
            [self GotoPage:self withIdentifier:@"ResetNotif"];
        } else if([[[defaults objectForKey:@"UserInfo"] objectForKey:@"action"] isEqualToString:@"pushTrx"]) {
            [self GotoPage:self withIdentifier:@"PaymentID"];
        }
    }
    else if ([[defaults objectForKey:@"StatusLogin"] isEqualToString:@"N"]) {
        if ([[[defaults objectForKey:@"UserInfo"] objectForKey:@"action"] isEqualToString:@"resetPassword"]) {
            [self GotoPage:self withIdentifier:@"ResetNotif"];
        } else if([[[defaults objectForKey:@"UserInfo"] objectForKey:@"action"] isEqualToString:@"pushTrx"]) {
            [defaults setObject:@"PushNoLogin" forKey:@"ViewController"];
            [self GotoPage:self withIdentifier:@"RootLogin"];
        }
    }
}

-(void)applicationReceivedRemoteMessage:(FIRMessagingRemoteMessage *)remoteMessage {
//    NSLog(@"RemoteMessage %@", remoteMessage);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [defaults setObject:userInfo forKey:@"UserInfo"];
    [defaults synchronize];
    if ([[defaults objectForKey:@"StatusLogin"] isEqualToString:@"Y"]) {
        if ([[[defaults objectForKey:@"UserInfo"] objectForKey:@"action"] isEqualToString:@"resetPassword"]) {
            [self GotoPage:self withIdentifier:@"ResetNotif"];
        } else if([[[defaults objectForKey:@"UserInfo"] objectForKey:@"action"] isEqualToString:@"pushTrx"]) {
            [self GotoPage:self withIdentifier:@"PaymentID"];
        }
    } else {
        if ([[[defaults objectForKey:@"UserInfo"] objectForKey:@"action"] isEqualToString:@"resetPassword"]) {
            [self GotoPage:self withIdentifier:@"ResetNotif"];
        } else if([[[defaults objectForKey:@"UserInfo"] objectForKey:@"action"] isEqualToString:@"pushTrx"]) {
            [defaults setObject:@"PushNoLogin" forKey:@"ViewController"];
            [self GotoPage:self withIdentifier:@"RootLogin"];
        }
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[FIRInstanceID instanceID] setAPNSToken:deviceToken type:FIRInstanceIDAPNSTokenTypeProd];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"ok" forKey:@"didRegisterForRemoteNotificationsWithDeviceToken"];

    NSLog(@"DID REGISTER = %@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

@end
