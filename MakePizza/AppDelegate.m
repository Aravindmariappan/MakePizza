//
//  AppDelegate.m
//  MakePizza
//
//  Created by Aravind on 02/03/2018.
//  Copyright © 2018 Aravind. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[DatabaseManager sharedInstance] saveContext];
}

@end
