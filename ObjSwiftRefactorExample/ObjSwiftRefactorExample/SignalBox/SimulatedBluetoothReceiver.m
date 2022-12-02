//
//  SimulatedBluetoothReceiver.m
//  ObjSwiftRefactorExample
//
//  Created by Jason Terhorst on 11/28/22.
//

#import "SimulatedBluetoothReceiver.h"

@implementation SimulatedBluetoothReceiverDataPacket

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.uuid = [coder decodeObjectForKey:@"uuid"];
        self.engineSpeed = [coder decodeIntForKey:@"engineSpeed"];
        self.wheelSpeed = [coder decodeIntForKey:@"wheelSpeed"];
        self.seedRate = [coder decodeIntForKey:@"seedRate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_uuid forKey:@"uuid"];
    [coder encodeInt:_engineSpeed forKey:@"engineSpeed"];
    [coder encodeInt:_wheelSpeed forKey:@"wheelSpeed"];
    [coder encodeInt:_seedRate forKey:@"seedRate"];
}

@end

@interface SimulatedBluetoothReceiver ()
@property (nonatomic, assign) int updateInterval;
@property (nonatomic, strong) NSTimer * internalTimer;
- (void)_internalStart;
- (void)_internalStop;
@end

@implementation SimulatedBluetoothReceiver

- (void)setUpdateInterval:(int)interval {
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
    _internalTimer = [NSTimer timerWithTimeInterval:_updateInterval target:self selector:@selector(_internalTimerFired:) userInfo:nil repeats:YES];
}

- (void)_internalStop {
    [_internalTimer invalidate];
    _internalTimer = nil;
}

- (void)_internalTimerFired:(NSTimer *)timer {
    
    [_delegate didReceiveDataPacket:nil];
}

@end
