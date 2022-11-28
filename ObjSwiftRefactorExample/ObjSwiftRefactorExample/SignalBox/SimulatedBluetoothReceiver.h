//
//  SimulatedBluetoothReceiver.h
//  ObjSwiftRefactorExample
//
//  Created by Jason Terhorst on 11/28/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SimulatedBluetoothReceiverDelegate <NSObject>
- (void)didReceiveDataPacket:(NSData *)data;
@end

@interface SimulatedBluetoothReceiver : NSObject
@property (nonatomic, strong) id<SimulatedBluetoothReceiverDelegate> delegate;
- (void)start;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
