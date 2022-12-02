//
//  SimulatedBluetoothReceiver.h
//  ObjSwiftRefactorExample
//
//  Created by Jason Terhorst on 11/28/22.
//

#import <Foundation/Foundation.h>

@protocol SignalBoxDataProvider;
@protocol SignalBoxDataProviderDelegate;

@interface SimulatedBluetoothReceiverDataPacket: NSObject <NSCoding>
@property (nonatomic, retain) NSUUID * _Nullable uuid;
@property (nonatomic) double engineSpeed;
@property (nonatomic) double wheelSpeed;
@property (nonatomic) int seedRate;
- (NSString * _Nonnull)debugDescription;
@end

@interface SimulatedBluetoothReceiver: NSObject <SignalBoxDataProvider>
@property (nonatomic, weak) id<SignalBoxDataProviderDelegate> _Nullable delegate;
@end
