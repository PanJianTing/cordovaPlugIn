//
//  AppDelegate+Notification.m
//  Test
//
//  Created by panjianting on 2017/10/27.
//  Copyright © 2017年 Digiwin. All rights reserved.
//

#import "AppDelegate+Notification.h"
#import "AppStorePlugin.h"

@implementation AppDelegate (Notification)

+ (void)load
{
    Method original, swizzled;
    
    original = class_getInstanceMethod(self, @selector(application:didFinishLaunchingWithOptions:));
    swizzled = class_getInstanceMethod(self, @selector(application:customDidFinishLaunchingWithOptions:));
    method_exchangeImplementations(original, swizzled);
}

//- (AppDelegate *)swizzled_init
//{
//    // 增加一個當app啟動時會呼叫的observer以取得推播資訊
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createNotificationChecker:) name:@"UIApplicationDidFinishLaunchingNotification" object:nil];
//
//    return [self swizzled_init];
//}

- (void)createNotificationChecker:(NSNotification *)notification
{
    if (notification)
    {
        NSDictionary *userInfo = [notification userInfo];
        if (userInfo)
        {
            NSDictionary *notif = [userInfo objectForKey: @"UIApplicationLaunchOptionsRemoteNotificationKey"];
            AppStorePlugin *appStorePlugin = [self.viewController getCommandInstance:@"AppStore"];
            appStorePlugin.notificationMessage = notif[@"data"];
        }
    }
}

- (BOOL)application:(UIApplication *)application customDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self application:application customDidFinishLaunchingWithOptions:launchOptions];
    
    [Device setUUIDInKeychain];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createNotificationChecker:) name:@"UIApplicationDidFinishLaunchingNotification" object:nil];
    
    return YES;
}

- (void) application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSLog(@"App Delegate : Received Device Token");
    
    NSString *tokenStr = [[[[deviceToken description]
                            stringByReplacingOccurrencesOfString:@"<" withString:@""]
                           stringByReplacingOccurrencesOfString:@">" withString:@""]
                          stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[NSUserDefaults standardUserDefaults] setObject:tokenStr forKey:@"TOKEN"];
    NSLog(@"%@" , tokenStr);
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    NSLog(@"Receive Notification Application State : %ld", (long)[[UIApplication sharedApplication] applicationState]);
    NSLog(@"didReceiveRemoteNotification : %@", userInfo);
    
    if([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive){
        AppStorePlugin *appStorePlugin = [self.viewController getCommandInstance:@"AppStore"];
        appStorePlugin.notificationMessage = userInfo[@"data"];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"AppDelegate : App become active");
}

-(void)applicationDidEnterBackground:(UIApplication *)application{
    
    NSLog(@"AppDelegate : App become background");
}

@end
