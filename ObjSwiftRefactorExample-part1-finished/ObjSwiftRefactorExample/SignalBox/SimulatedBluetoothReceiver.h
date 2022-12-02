//
//  SimulatedBluetoothReceiver.h
//  ObjSwiftRefactorExample
//
//  Created by Jason Terhorst on 11/28/22.
//

#import <Foundation/Foundation.h>

@interface SimulatedBluetoothReceiverDataPacket: NSObject <NSCoding>
@property (nonatomic, retain) NSUUID * _Nullable uuid;
@property (nonatomic) double engineSpeed;
@property (nonatomic) double wheelSpeed;
@property (nonatomic) int seedRate;
- (NSString * _Nonnull)debugDescription;
@end

@protocol SimulatedBluetoothReceiverDelegate <NSObject>
@required
- (void)didReceiveDataPacket:(nonnull NSData *)data;
- (void)bluetoothDidConnect;
- (void)bluetoothDidDisconnect;
@end

@interface SimulatedBluetoothReceiver: NSObject
@property (nonatomic, weak) id<SimulatedBluetoothReceiverDelegate> _Nullable delegate;
- (void)setUpdateInterval:(NSTimeInterval)interval;
- (void)start;
- (void)stop;
@end
