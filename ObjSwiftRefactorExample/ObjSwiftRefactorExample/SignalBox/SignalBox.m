//
//  SignalBox.m
//  ObjSwiftRefactorExample
//
//  Created by Jason Terhorst on 11/28/22.
//

#import "SignalBox.h"
#import "SimulatedBluetoothReceiver.h"

@interface SignalBox () <SimulatedBluetoothReceiverDelegate>
@property (nonatomic, strong) SimulatedBluetoothReceiver * simReceiver;
@end

@implementation SignalBox

+ (instancetype)sharedManager {
    static SignalBox * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)setSignalInterval:(int)interval {
    [_simReceiver setUpdateInterval:interval];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _simReceiver = [[SimulatedBluetoothReceiver alloc] init];
        [_simReceiver setUpdateInterval:0.5];
    }
    return self;
}

- (void)bluetoothDidConnect {
    NSLog(@"Connected!");
}

- (void)bluetoothDidDisconnect {
    NSLog(@"Disconnected!");
}

- (void)didReceiveDataPacket:(nonnull NSData *)data {
    
}

@end
