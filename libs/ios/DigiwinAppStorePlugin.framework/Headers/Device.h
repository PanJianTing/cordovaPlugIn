//
//  Device.h
//  DigiwinAppStorePlugin
//
//  Created by panjianting on 2017/10/25.
//  Copyright © 2017年 panjianting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>
#import <Security/Security.h>


@interface Device : NSObject


+ (void) setBadgeNumber:(NSUInteger) badgeNumber;
+ (NSArray *) checkAppOnDevice:(NSMutableArray *) appInfoArray;
+ (void) registerDevice;

// Key Chain Handle

+ (void) setUUIDInKeychain;
+ (NSString *) getUUIDInKeychain;
+ (BOOL) deleteUUIDInKeychain;

@end
