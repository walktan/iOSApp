//
//  AppDelegate.h
//  ChukyoBus
//
//  Created by 旦 on 2014/02/16.
//  Copyright (c) 2014年 walktan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIWindow *window;
    UINavigationController *navController;
    WebViewController *webViewController;
    // Declare one as an instance variable
}

@property (nonatomic, retain) UIWindow *window;

@property (nonatomic, retain) UINavigationController *navController;

@property (nonatomic, retain) WebViewController *webViewController;

@end
