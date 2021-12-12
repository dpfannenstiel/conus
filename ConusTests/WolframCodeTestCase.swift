//
//  WolframCodeTestCase.swift
//  ConusTests
//
//  Created by Dustin Pfannenstiel on 12/11/21.
//

import XCTest
@testable import Conus

class WolframCodeTestCase: ConusTestCase {

    let rule30Array = [0, 0, 0, 1, 1, 1, 1, 0]

    func testBitValues() throws {
        var counter: UInt8 = 0
        try (0...1).forEach { seventh in
            try (0...1).forEach { sixth in
                try (0...1).forEach { fifth in
                    try (0...1).forEach { fourth in
                        try (0...1).forEach { third in
                            try (0...1).forEach { second in
                                try (0...1).forEach { first in
                                    try (0...1).forEach { zeroth in
                                        let bitArray = [seventh, sixth, fifth, fourth, third, second, first, zeroth]
                                            .compactMap { Bit(rawValue: UInt8($0)) }
                                        XCTAssertEqual(counter, try WolframCode(bitArray: bitArray).code)
                                        if counter < UInt8.max {
                                            counter += 1
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    func testWolframFromArray() {
        XCTAssertEqual(UInt8(30), try WolframCode(intArray: rule30Array).code)
        XCTAssertThrowsError(try WolframCode(intArray: [0, 0, 0, 1, 1, 1, 1, 0, 0])) { error in
            if case let WolframCode.Errors.invalidArraySize(size) = error {
                XCTAssertEqual(9, size)
            } else {
                XCTFail("Wrong error type \(error)")
            }
        }
        XCTAssertThrowsError(try WolframCode(intArray: [0, 0, 0, 1, 1, 1, 1])) { error in
            if case let WolframCode.Errors.invalidArraySize(size) = error {
                XCTAssertEqual(7, size)
            } else {
                XCTFail("Wrong error type \(error)")
            }
        }
        XCTAssertThrowsError(try WolframCode(intArray: [0, 0, 0, 1, 1, 1, 1, 1700])) { error in
            if case let WolframCode.Errors.invalidBitParse(value) = error {
                XCTAssertEqual(1700, value)
            } else {
                XCTFail("Wrong error type \(error)")
            }
        }
    }

    func testBitPattern() throws {
        let rule30 = try WolframCode(intArray: rule30Array)
        XCTAssertEqual(.off, rule30[[.off, .off, .off]])
        XCTAssertEqual(.on, rule30[[.on, .off, .off]])
        XCTAssertEqual(.on, rule30[[.off, .on, .off]])
        XCTAssertEqual(.on, rule30[[.on, .on, .off]])
        XCTAssertEqual(.on, rule30[[.off, .off, .on]])
        XCTAssertEqual(.off, rule30[[.on, .off, .on]])
        XCTAssertEqual(.off, rule30[[.off, .on, .on]])
        XCTAssertEqual(.off, rule30[[.on, .on, .on]])
        XCTAssertNil(rule30[[.on, .on, .on, .on]])
        XCTAssertNil(rule30[[.on]])
        XCTAssertNil(rule30[[.on, .on]])
    }

    func testBitToggle() {
        XCTAssertEqual(.on, Bit.off.toggle())
        XCTAssertEqual(.off, Bit.on.toggle())
        let source: Bits = [.off, .off, .off]
        XCTAssertEqual([.on, .off, .off], source.toggle(0))
        XCTAssertEqual([.off, .on, .off], source.toggle(1))
        XCTAssertEqual([.off, .off, .on], source.toggle(2))
        XCTAssertEqual([.off, .off, .off], source.toggle(3))
    }

    func testWolframToggle() throws {
        let rule30 = try WolframCode(intArray: rule30Array)
        XCTAssertEqual([.off, .on, .on, .on, .on, .off, .off, .off], rule30.bitArray)
        XCTAssertEqual(30, rule30.code)
        XCTAssertEqual([.on, .on, .on, .on, .on, .off, .off, .off], rule30.toggle(0).bitArray)
        XCTAssertEqual(31, rule30.toggle(0).code)
    }
}
