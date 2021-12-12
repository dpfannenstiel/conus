//
//  RuleGenerationTests.swift
//  ConusTests
//
//  Created by Dustin Pfannenstiel on 12/11/21.
//

import XCTest
@testable import Conus

class RuleGenerationTests: ConusTestCase {
    func testCountPerGeneration() {
        XCTAssertEqual(1, maxCells(for: 0))
        XCTAssertEqual(3, maxCells(for: 1))
        XCTAssertEqual(5, maxCells(for: 2))
        XCTAssertEqual(7, maxCells(for: 3))
        XCTAssertEqual(9, maxCells(for: 4))
        XCTAssertEqual(43, maxCells(for: 21))
        XCTAssertEqual(45, maxCells(for: 22))
    }

    func testMidValue() {
        XCTAssertEqual(0, mid(1))
        XCTAssertEqual(1, mid(3))
        XCTAssertEqual(2, mid(5))
        XCTAssertEqual(3, mid(7))
        XCTAssertEqual(21, mid(43))
        XCTAssertEqual(22, mid(45))
    }

    func testGenerationConstruction() {
        XCTAssertEqual([.on], readyZerothGeneration(of: 0))
        XCTAssertEqual([.off, .on, .off], readyZerothGeneration(of: 1))
        XCTAssertEqual([.off, .off, .on, .off, .off], readyZerothGeneration(of: 2))
        XCTAssertEqual([.off, .off, .off, .on, .off, .off, .off], readyZerothGeneration(of: 3))
    }

    func testParentBits() {
        let generation1 = readyZerothGeneration(of: 1)
        let parentBits1 = generation1.parentBits
        XCTAssertEqual([.on, .off, .off], parentBits1[0])
        XCTAssertEqual([.off, .on, .off], parentBits1[1])
        XCTAssertEqual([.off, .off, .on], parentBits1[2])
        let generation2 = readyZerothGeneration(of: 2)
        let parentBits2 = generation2.parentBits
        XCTAssertEqual([.off, .off, .off], parentBits2[0])
        XCTAssertEqual([.on, .off, .off], parentBits2[1])
        XCTAssertEqual([.off, .on, .off], parentBits2[2])
        XCTAssertEqual([.off, .off, .on], parentBits2[3])
        XCTAssertEqual([.off, .off, .off], parentBits2[4])
    }

    func testNextGeneration() throws {
        let rule30Array = [0, 0, 0, 1, 1, 1, 1, 0]
        let rule30 = try WolframCode(intArray: rule30Array)
        let generation3 = readyZerothGeneration(of: 3)
        XCTAssertEqual([.off, .off, .on, .on, .on, .off, .off], try generation3.generate(with: rule30))
        XCTAssertEqual([.off, .on, .on, .off, .off, .on, .off], try generation3.generate(with: rule30, times: 2))
        XCTAssertEqual([.on, .on, .off, .on, .on, .on, .on], try generation3.generate(with: rule30, times: 3))
    }

    func testGenerations() throws {
        let rule30Array = [0, 0, 0, 1, 1, 1, 1, 0]
        let rule30 = try WolframCode(intArray: rule30Array)
        let generation3 = readyZerothGeneration(of: 3)
        XCTAssertEqual(
            [
                [.off, .off, .off, .on, .off, .off, .off],
                [.off, .off, .on, .on, .on, .off, .off],
                [.off, .on, .on, .off, .off, .on, .off],
                [.on, .on, .off, .on, .on, .on, .on]
            ],
            try generation3.generate(times: 3, with: rule30)
        )
    }
}
