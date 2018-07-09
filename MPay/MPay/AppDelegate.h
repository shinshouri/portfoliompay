//
//  AppDelegate.h
//  MPay
//
//  Created by Admin on 7/4/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import "CWStatusBarNotification.h"
#import "OnBoardPage.h"
#import "PushPassword.h"
#import "Login.h"
#import "PaymentDetail.h"
#import "NewPassword.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CWStatusBarClickedDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CWStatusBarNotification *notification;

@end

