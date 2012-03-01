//
//  AppDelegate.h
//  HLCooldownButtonTest
//
//  Created by HaiLong Guo on 12-2-29.
//  Copyright HaiLong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
