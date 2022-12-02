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
@property (nonatomic) int engineSpeed;
@property (nonatomic) int wheelSpeed;
@property (nonatomic) int seedRate;
@end

@protocol SimulatedBluetoothReceiverDelegate <NSObject>
@required
- (void)didReceiveDataPacket:(NSData *)data;
- (void)bluetoothDidConnect;
- (void)bluetoothDidDisconnect;
@end

@interface SimulatedBluetoothReceiver: NSObject
@property (nonatomic, strong) id<SimulatedBluetoothReceiverDelegate> delegate;
- (void)setUpdateInterval:(int)interval;
- (void)start;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
