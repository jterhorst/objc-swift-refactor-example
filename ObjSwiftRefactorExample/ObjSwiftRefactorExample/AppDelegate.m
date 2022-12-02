//
//  AppDelegate.m
//  ObjSwiftRefactorExample
//
//  Created by Jason Terhorst on 11/28/22.
//

#import "AppDelegate.h"
#import "SignalBox.h"
#import "ObjSwiftRefactorExample-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bluetoothConnected:) name:signalBoxConnectedNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bluetoothDisconnected:) name:signalBoxDisconnectedNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedData:) name:signalBoxTelemetryReceivedNotificationName object:nil];
    
    [[SignalBoxNew sharedManager] start];

    return YES;
}

#pragma mark - Bluetooth notifications

- (void)bluetoothConnected:(NSNotification *)notification {
    NSLog(@"Connected!");
}

- (void)bluetoothDisconnected:(NSNotification *)notification {
    NSLog(@"Disconnected!");
}

- (void)receivedData:(NSNotification *)notification {
    NSLog(@"received data: %@", [[notification object] debugDescription]);
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
