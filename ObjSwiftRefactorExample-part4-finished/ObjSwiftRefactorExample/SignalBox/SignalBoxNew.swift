//
//  SignalBoxNew.swift
//  ObjSwiftRefactorExample
//
//  Created by Jason Terhorst on 12/2/22.
//

import Foundation

@objc class SignalBoxNew: NSObject, SignalBoxDataProviderDelegate {

    private static let defaultUpdateInterval: TimeInterval = 0.2;
    private var simReceiver: SignalBoxDataProvider?

    // MARK: - Initializing

    private static var sharedManager: SignalBoxNew = {
        let manager = SignalBoxNew()
        return manager
    }()

    class func shared() -> SignalBoxNew {
        return sharedManager
    }

    init(provider: SignalBoxDataProvider? = SimulatedBluetoothReceiver()) {
        super.init()
        simReceiver = provider
        simReceiver?.delegate = self
        simReceiver?.setUpdateInterval(SignalBoxNew.defaultUpdateInterval)
    }

    // MARK: - Wrapper functions

    func setSignalInterval(_ timeInterval: TimeInterval) {
        simReceiver?.setUpdateInterval(timeInterval)
    }

    func start() {
        simReceiver?.start()
    }

    func stop() {
        simReceiver?.stop()
    }

    // MARK: - Delegate functions

    func bluetoothDidConnect() {
        NotificationCenter.default.post(name: Notification.Name(signalBoxConnectedNotificationName), object: nil)
    }

    func bluetoothDidDisconnect() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: signalBoxDisconnectedNotificationName), object: nil)
    }

    func didReceiveDataPacket(_ data: Data) {
        /**
         SimulatedBluetoothReceiverDataPacket * packetDecoded = [NSKeyedUnarchiver unarchiveObjectWithData:data];
         if (packetDecoded) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [[NSNotificationCenter defaultCenter] postNotificationName:signalBoxTelemetryReceivedNotificationName object:packetDecoded];
             });
         }
         */
        guard let packetDecoded = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? SimulatedBluetoothReceiverDataPacket else {
            return
        }
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Notification.Name(rawValue: signalBoxTelemetryReceivedNotificationName), object: packetDecoded)
        }
    }
}
