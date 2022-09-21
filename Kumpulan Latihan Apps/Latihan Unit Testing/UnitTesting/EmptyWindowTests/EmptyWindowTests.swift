//
//  EmptyWindowTests.swift
//  EmptyWindowTests
//
//  Created by Patricia Fiona on 21/09/22.
//

import XCTest

@testable import UnitTesting //Nama App nya
class EmptyWindowTestTests: XCTestCase {
 
    var viewController = ViewController()
    
    func testDicodingSwift() {
        let input = "swift"
        let output = "dicoding"
        XCTAssertEqual(output, self.viewController.dicodingSwift(input), "Failed to produce \(output) from \(input)")
    }
}
