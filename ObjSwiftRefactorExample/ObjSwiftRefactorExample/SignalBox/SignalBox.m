//
//  SignalBox.m
//  ObjSwiftRefactorExample
//
//  Created by Jason Terhorst on 11/28/22.
//

#import "SignalBox.h"
#import "SimulatedBluetoothReceiver.h"


static NSTimeInterval defaultUpdateInterval = 0.2;

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

- (void)setSignalInterval:(NSTimeInterval)interval {
    [_simReceiver setUpdateInterval:interval];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _simReceiver = [[SimulatedBluetoothReceiver alloc] init];
        _simReceiver.delegate = self;
        [_simReceiver setUpdateInterval:defaultUpdateInterval];
    }
    return self;
}

- (void)start {
    [_simReceiver start];
}

- (void)stop {
    [_simReceiver stop];
}

- (void)bluetoothDidConnect {
    [[NSNotificationCenter defaultCenter] postNotificationName:signalBoxConnectedNotificationName object:nil];
}

- (void)bluetoothDidDisconnect {
    [[NSNotificationCenter defaultCenter] postNotificationName:signalBoxDisconnectedNotificationName object:nil];
}

- (void)didReceiveDataPacket:(nonnull NSData *)data {
    SimulatedBluetoothReceiverDataPacket * packetDecoded = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (packetDecoded) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:signalBoxTelemetryReceivedNotificationName object:packetDecoded];
        });
    }
}

@end
