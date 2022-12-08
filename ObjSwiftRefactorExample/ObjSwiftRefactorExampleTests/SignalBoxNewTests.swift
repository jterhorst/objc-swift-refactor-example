//
//  SignalBoxNewTests.swift
//  ObjSwiftRefactorExampleTests
//
//  Created by Jason Terhorst on 12/2/22.
//

import XCTest
@testable import ObjSwiftRefactorExample

final class SignalBoxNewTests: XCTestCase {

    // MARK: - Tests

    func testSignalBoxStart() throws {
        let result = systemUnderTest()
        let box = result.box
        let observer = MockSignalBoxObserver()
        observer.startedExpectation = expectation(description: "Did start BT connection")

        box.start()
        wait(for: [observer.startedExpectation!], timeout: 1)

        XCTAssertNil(observer.telemetryPacket)
    }

    func testSignalBoxStop() throws {
        let result = systemUnderTest()
        let box = result.box
        let observer = MockSignalBoxObserver()
        observer.stoppedExpectation = expectation(description: "Did stop BT connection")

        box.stop()
        wait(for: [observer.stoppedExpectation!], timeout: 1)
    }

    func testSignalTelemetryNotification() throws {
        let result = systemUnderTest()
        let provider = result.provider as! MockSignalBoxDataProvider
        let observer = MockSignalBoxObserver()
        observer.receivedTelemetryExpectation = expectation(description: "Did stop BT connection")

        provider.invokeTestDataDelegate()
        wait(for: [observer.receivedTelemetryExpectation!], timeout: 1)

        XCTAssertNotNil(observer.telemetryPacket?.uuid)
        XCTAssertEqual(observer.telemetryPacket?.engineSpeed, 5000)
        XCTAssertEqual(observer.telemetryPacket?.wheelSpeed, 12)
        XCTAssertEqual(observer.telemetryPacket?.seedRate, 35000)
    }

    func testSignalBoxSetInterval() throws {
        let result = systemUnderTest()
        let box = result.box
        let provider = result.provider as! MockSignalBoxDataProvider
        provider.setUpdateIntervalExpectation = expectation(description: "Did set interval")

        box.setSignalInterval(5.0)
        wait(for: [provider.setUpdateIntervalExpectation!], timeout: 1)
    }

    // MARK: - Support stuff for tests

    func systemUnderTest() -> (box: SignalBoxSwift, provider: SignalBoxDataProvider) {
        let provider = MockSignalBoxDataProvider()
        let box = SignalBoxSwift(provider: provider)
        provider.delegate = box
        return (box, provider)
    }

    private class MockSignalBoxObserver {
        var startedExpectation: XCTestExpectation?
        var stoppedExpectation: XCTestExpectation?
        var receivedTelemetryExpectation: XCTestExpectation?
        var telemetryPacket: SimulatedBluetoothReceiverDataPacket?

        init() {
            NotificationCenter.default.addObserver(self, selector: #selector(didStart), name: NSNotification.Name(signalBoxConnectedNotificationName), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(didStop), name: NSNotification.Name(signalBoxDisconnectedNotificationName), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(didReceiveTelemetry), name: NSNotification.Name(signalBoxTelemetryReceivedNotificationName), object: nil)
        }

        @objc func didStart() {
            startedExpectation?.fulfill()
        }

        @objc func didStop() {
            stoppedExpectation?.fulfill()
        }

        @objc func didReceiveTelemetry(_ notification: NSNotification) {
            receivedTelemetryExpectation?.fulfill()
            telemetryPacket = notification.object as? SimulatedBluetoothReceiverDataPacket
        }
    }

    private class MockSignalBoxDataProvider: SignalBoxDataProvider {
        var startedExpectation: XCTestExpectation?
        var stoppedExpectation: XCTestExpectation?
        var setUpdateIntervalExpectation: XCTestExpectation?

        var delegate: ObjSwiftRefactorExample.SignalBoxDataProviderDelegate?

        func start() {
            delegate?.bluetoothDidConnect()
        }

        func stop() {
            delegate?.bluetoothDidDisconnect()
        }

        func setUpdateInterval(_ timeInterval: TimeInterval) {
            internalUpdateInterval = timeInterval
            setUpdateIntervalExpectation?.fulfill()
        }
        var internalUpdateInterval: TimeInterval = 0.0

        func invokeTestDataDelegate() {
            let simPacket = SimulatedBluetoothReceiverDataPacket()
            simPacket.uuid = UUID()
            simPacket.engineSpeed = 5000
            simPacket.wheelSpeed = 12
            simPacket.seedRate = 35000
            let data = NSKeyedArchiver.archivedData(withRootObject: simPacket)
            delegate?.didReceiveDataPacket(data)
        }
    }
}
