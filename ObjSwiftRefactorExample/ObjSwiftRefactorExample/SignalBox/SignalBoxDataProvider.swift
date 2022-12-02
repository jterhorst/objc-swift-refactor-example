//
//  SignalBoxDataProvider.swift
//  ObjSwiftRefactorExample
//
//  Created by Jason Terhorst on 12/2/22.
//

import Foundation

@objc public protocol SignalBoxDataProviderDelegate: AnyObject {
    func didReceiveDataPacket(_ data: Data)
    func bluetoothDidConnect()
    func bluetoothDidDisconnect()
}

@objc public protocol SignalBoxDataProvider {
    weak var delegate: SignalBoxDataProviderDelegate? { get set }
    func start()
    func stop()
    func setUpdateInterval(_ timeInterval: TimeInterval)
}
