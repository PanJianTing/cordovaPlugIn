//
//  AppStorePlugin.m
//  testCordova
//
//  Created by panjianting on 2017/10/25.
//

#import "AppStorePlugin.h"



@implementation AppStorePlugin

static NSString *notificationCallback = @"getReceiveMessage";


-(void) checkAppOnDevice:(CDVInvokedUrlCommand *)command{
    
    NSLog(@"AppPlugin : Check App Installed by AppID");
    
    [self.commandDelegate runInBackground:^{
        
        if (command.arguments != nil){
            NSArray *appInfoArray = [Device checkAppOnDevice:[command.arguments mutableCopy]];
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:appInfoArray];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
        
        }else{
            
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Fail to check, App Info Array is Null"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

-(void) getAppUUIDOnDevice:(CDVInvokedUrlCommand *)command{
    
    NSLog(@"AppPlugin : get UUID");
    
//    NSUInteger uuid = [Device getUUIDInKeychain];
    NSString *uuid = [Device getUUIDInKeychain];
    [self.commandDelegate runInBackground:^{
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:uuid];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

-(void) setAppBadge:(CDVInvokedUrlCommand *)command{
    
    NSLog(@"AppPlugin : set Badge");
    
    BOOL isSuccess = YES;
    
    if (command.arguments.count > 0) {
        if (command.arguments[0] != [NSNull null]){
            
            NSUInteger badgeNumber = [command.arguments[0] integerValue];
            [Device setBadgeNumber:badgeNumber];
        }else{
            isSuccess = NO;
        }
    }else{
         [Device setBadgeNumber:0];
    }
    
    [self.commandDelegate runInBackground:^{
        if (isSuccess) {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }else{
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Fail To setBadge"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

- (void) registerDevice:(CDVInvokedUrlCommand *) command{
    
    NSLog(@"AppPlugin : Register Notification");
    
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];

    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    
     [[UIApplication sharedApplication] registerForRemoteNotifications];

    
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
    
//    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
//
    
//    self.callBackID = command.callbackId;
    
}

-(void) getDeviceToken:(CDVInvokedUrlCommand *) command{
    
    NSLog(@"AppPlugin : Received Device Token Call Back");
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"];
    
    [self.commandDelegate runInBackground:^{
        if (token != nil) {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:token];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }else{
            //callback
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Get Device Token Fail"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
    
    
}

-(void) receiveNotification:(CDVInvokedUrlCommand *) command{
    
    NSLog(@"AppPlugin : Receive Message Call Back");
    
    if(self.notificationMessage != nil){
        
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:self.notificationMessage];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        self.notificationMessage = nil;
        NSLog(@"App Plugin : Message get.");
        
//        NSString * notifyJS = [NSString stringWithFormat:@"%@(%@);", notificationCallback, self.notificationMessage];
        
//        NSLog(@"stringByEvaluatingJavaScriptFromString %@", notifyJS);
//
//        if ([self.webView respondsToSelector:@selector(stringByEvaluatingJavaScriptFromString:)]) {
//            [(UIWebView *)self.webView stringByEvaluatingJavaScriptFromString:notifyJS];
//        } else {
//            [self.webViewEngine evaluateJavaScript:notifyJS completionHandler:nil];
//        }
    }else{
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Get Device Token Fail"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
    }
}

-(void) isNotificationOpen:(CDVInvokedUrlCommand *) command{
    
    NSLog(@"AppPlugin : Check user notification status");
    
    [self.commandDelegate runInBackground:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
            BOOL isOpen = setting.types != UIUserNotificationTypeNone;
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isOpen];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        });
    }];
}

-(void) openSetting:(CDVInvokedUrlCommand *) command{
    
    NSLog(@"AppPlugin : Jump to setting page");
    
    [self.commandDelegate runInBackground:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        });
    }];
}



@end

