//
//  SimulatedBluetoothReceiver.h
//  ObjSwiftRefactorExample
//
//  Created by Jason Terhorst on 11/28/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SimulatedBluetoothReceiverDataPacket: NSObject <NSCoding>
@property (nonatomic, retain) NSUUID * uuid;
@property (nonatomic) double engineSpeed;
@property (nonatomic) double wheelSpeed;
@property (nonatomic) int seedRate;
- (NSString *)debugDescription;
@end

@protocol SimulatedBluetoothReceiverDelegate <NSObject>
@required
- (void)didReceiveDataPacket:(NSData *)data;
- (void)bluetoothDidConnect;
- (void)bluetoothDidDisconnect;
@end

@interface SimulatedBluetoothReceiver: NSObject
@property (nonatomic, weak) id<SimulatedBluetoothReceiverDelegate> delegate;
- (void)setUpdateInterval:(NSTimeInterval)interval;
- (void)start;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
