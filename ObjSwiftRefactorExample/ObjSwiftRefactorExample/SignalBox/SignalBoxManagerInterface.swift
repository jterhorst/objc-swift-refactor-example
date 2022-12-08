//
//  SignalBoxManagerInterface.swift
//  ObjSwiftRefactorExample
//
//  Created by Jason Terhorst on 12/8/22.
//

import Foundation

@objc protocol SignalBoxManagerInterface {
    static func sharedManager() -> SignalBoxManagerInterface
    func setSignalInterval(_ interval: TimeInterval)
    func start()
    func stop()
}
