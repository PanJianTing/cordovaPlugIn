//
//  AppStorePlugin.h
//  testCordova
//
//  Created by panjianting on 2017/10/25.
//

#import <Cordova/CDVPlugin.h>
#import <DigiwinAppStorePlugin/Device.h>

@interface AppStorePlugin : CDVPlugin

@property (strong, nonatomic) NSString *notificationMessage;
@property (strong, nonatomic) NSString *token;
//@property (copy, nonatomic) NSString *callBackID;

-(void) checkAppOnDevice:(CDVInvokedUrlCommand *)command;
-(void) getAppUUIDOnDevice:(CDVInvokedUrlCommand *)command;
-(void) setAppBadge:(CDVInvokedUrlCommand *)command;

-(void) registerDevice:(CDVInvokedUrlCommand *) command;
-(void) isNotificationOpen:(CDVInvokedUrlCommand *) command;
-(void) openSetting:(CDVInvokedUrlCommand *) command ;
-(void) receiveNotification:(CDVInvokedUrlCommand *)command;
    
//-(void) getDeviceToken:(NSString *)deviceToken;



@end
