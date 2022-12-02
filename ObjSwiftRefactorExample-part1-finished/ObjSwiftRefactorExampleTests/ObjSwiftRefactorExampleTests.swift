//
//  ObjSwiftRefactorExampleTests.swift
//  ObjSwiftRefactorExampleTests
//
//  Created by Jason Terhorst on 12/2/22.
//

import XCTest
@testable import ObjSwiftRefactorExample

final class SignalBoxLegacyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignalBoxInvoke() throws {
        SignalBox.sharedManager().start()
    }

}
