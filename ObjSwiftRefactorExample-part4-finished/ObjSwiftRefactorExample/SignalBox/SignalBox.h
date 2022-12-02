//
//  SignalBox.h
//  ObjSwiftRefactorExample
//
//  Created by Jason Terhorst on 11/28/22.
//

/**
 This SignalBox simulates what we'd often see with a Bluetooth communications impl.
 The intention is to simulate a 1kHz signal, as if from some kind of BT beacon or similar connected device.
 "This ObjC code is awful and gnarly!" you might say.
 "Yes, that's the idea", I reply.
 The purpose is to show you something with lots of tech debt, as a starting point for our refactor.
 */

#import <Foundation/Foundation.h>

@protocol SignalBoxDataProvider;
@protocol SignalBoxDataProviderDelegate;

@interface SignalBox : NSObject <SignalBoxDataProviderDelegate>
+ (instancetype _Nonnull)sharedManager;
- (instancetype _Nonnull)initWithProvider:(id<SignalBoxDataProvider>_Nonnull)provider;
- (void)setSignalInterval:(NSTimeInterval)interval;
- (void)start;
- (void)stop;
@end

static NSString * _Nonnull signalBoxConnectedNotificationName = @"SignalBoxConnected";
static NSString * _Nonnull signalBoxDisconnectedNotificationName = @"SignalBoxDisconnected";
static NSString * _Nonnull signalBoxTelemetryReceivedNotificationName = @"SignalBoxTelemetry";
