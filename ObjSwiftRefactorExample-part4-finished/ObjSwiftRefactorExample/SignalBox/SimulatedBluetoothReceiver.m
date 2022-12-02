//
//  SimulatedBluetoothReceiver.m
//  ObjSwiftRefactorExample
//
//  Created by Jason Terhorst on 11/28/22.
//

#import "SimulatedBluetoothReceiver.h"

#import "ObjSwiftRefactorExample-Swift.h"

@implementation SimulatedBluetoothReceiverDataPacket

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.uuid = [coder decodeObjectForKey:@"uuid"];
        self.engineSpeed = [coder decodeDoubleForKey:@"engineSpeed"];
        self.wheelSpeed = [coder decodeDoubleForKey:@"wheelSpeed"];
        self.seedRate = [coder decodeIntForKey:@"seedRate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_uuid forKey:@"uuid"];
    [coder encodeDouble:_engineSpeed forKey:@"engineSpeed"];
    [coder encodeDouble:_wheelSpeed forKey:@"wheelSpeed"];
    [coder encodeInt:_seedRate forKey:@"seedRate"];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"uuid: %@, engineSpeed: %f, wheelSpeed: %f, seedRate: %d", _uuid, _engineSpeed, _wheelSpeed, _seedRate];
}

@end

@interface SimulatedBluetoothReceiver ()
{
    dispatch_queue_t telemetryUpdateQueue;
}
@property (nonatomic, assign) NSTimeInterval updateInterval;
@property (nonatomic, strong) NSTimer * internalTimer;
- (void)_internalStart;
- (void)_internalStop;
@end

@implementation SimulatedBluetoothReceiver

- (instancetype)init {
    self = [super init];
    if (self) {
        telemetryUpdateQueue = dispatch_queue_create("SimulatedBluetoothReceiver.telemetryUpdateQueue", NULL);
    }
    return self;
}

- (void)setUpdateInterval:(NSTimeInterval)interval {
    BOOL timerExists = (_internalTimer != nil);
    if (timerExists) {
        [self _internalStop];
    }
    _updateInterval = interval;
    if (timerExists) {
        [self _internalStart];
    }
}

- (void)start {
    [self _internalStart];
}

- (void)stop {
    [self _internalStop];
}

- (void)_internalStart {
    [_internalTimer invalidate];
    __weak SimulatedBluetoothReceiver * weakSelf = self;
    dispatch_async(telemetryUpdateQueue, ^{
        SimulatedBluetoothReceiver * strongSelf = weakSelf;
        [strongSelf->delegate bluetoothDidConnect];
    });
    _internalTimer = [NSTimer scheduledTimerWithTimeInterval:_updateInterval target:self selector:@selector(_internalTimerFired:) userInfo:nil repeats:YES];
}

- (void)_internalStop {
    [_internalTimer invalidate];
    _internalTimer = nil;
    __weak SimulatedBluetoothReceiver * weakSelf = self;
    dispatch_async(telemetryUpdateQueue, ^{
        SimulatedBluetoothReceiver * strongSelf = weakSelf;
        [strongSelf->delegate bluetoothDidDisconnect];
    });
}

- (void)_internalTimerFired:(NSTimer *)timer {
    __weak SimulatedBluetoothReceiver * weakSelf = self;
    dispatch_async(telemetryUpdateQueue, ^{
        SimulatedBluetoothReceiver * strongSelf = weakSelf;
        SimulatedBluetoothReceiverDataPacket * packet = [[SimulatedBluetoothReceiverDataPacket alloc] init];
        packet.uuid = [NSUUID UUID];
        packet.engineSpeed = 1500 + arc4random() % (10000 - 1500);
        packet.wheelSpeed = 0 + arc4random() % (15 - 0);
        packet.seedRate = 10000 + arc4random() % (20000 - 10000);
        NSData * encodedPacket = [NSKeyedArchiver archivedDataWithRootObject:packet requiringSecureCoding:NO error:nil];
        if (encodedPacket) {
            [strongSelf->delegate didReceiveDataPacket:encodedPacket];
        }
    });
}

@synthesize delegate;

@end
