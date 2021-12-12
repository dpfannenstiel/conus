//
//  WolframCode.swift
//  Conus
//
//  Created by Dustin Pfannenstiel on 12/11/21.
//

import Foundation

/// A Wolfram Code
/// See https://en.m.wikipedia.org/wiki/Wolfram_code
struct WolframCode: Hashable {
    /// Rule 30
    static var rule30 = try! WolframCode(intArray: [0, 0, 0, 1, 1, 1, 1, 0])
    /// Rule 86
    static var rule86 = try! WolframCode(intArray: [0, 1, 0, 1, 0, 1, 1, 0])
    /// Rule 135
    static var rule135 = try! WolframCode(intArray: [1, 0, 0, 0, 0, 1, 1, 1])
    /// Rule 149
    static var rule149 = try! WolframCode(intArray: [1, 0, 0, 1, 0, 1, 0, 1])

    enum RulesModels {
        /// A list of rule names
        static let ruleNames = [
            "Rule 30",
            "Rule 86",
            "Rule 135",
            "Rule 149"
        ]

        /// Rule names paired with rules
        static let rules = [
            "Rule 30": WolframCode.rule30,
            "Rule 86": WolframCode.rule86,
            "Rule 135": WolframCode.rule135,
            "Rule 149": WolframCode.rule149
        ]
    }

    enum Errors: Error {
        /// Thrown when the number of elements in the constructor parameter does not match requirements
        case invalidArraySize(Int)
        /// The pars of Bit by Integer failed
        case invalidBitParse(Int)
    }

    /// The bit array for the Wolfram Code.
    let bitArray: Bits

    /// The code value
    var code: UInt8 {
        bitArray.littleEndianUInt8! // WolframCode can only be created with bitArray of size 8
    }

    /// Construct a Wolfram Code
    /// - parameter bitArray: 
    init(bitArray: Bits) throws {
        guard bitArray.count == 8 else {
            throw Errors.invalidArraySize(bitArray.count)
        }
        self.bitArray = bitArray.reversed()
    }

    /// Construct a Wolfram Code
    /// - parameter intArray: The `intArray` will be converted to `Bits` before construction.
    /// - throws: `invalidBitParse` if a member of `intArray` fails to parse to a `Bit`
    init(intArray: [Int]) throws {
        try self.init(bitArray: intArray.compactMap { integer in
            guard (0...1).contains(integer) else {
                throw Errors.invalidBitParse(integer)
            }
            return Bit(rawValue: UInt8(integer))
        } )
    }

    /// Get the bit for the current code from a pattern of Bits
    /// - parameter pattern: To look up a `Bit`, must always have 3 values
    /// - returns: The `Bit` for the matching pattern.  `nil` may be returned if 3 `Bit` elements are not supplied.
    subscript(pattern: Bits) -> Bit? {
        guard let index = pattern.littleEndianUInt8, pattern.count == 3 else {
            return nil
        }
        return bitArray[Int(index)]
    }

    /// Create a new WolframCode after toggling a single bit
    /// - parameter index: Index of the bit to toggle
    /// - returns: A copy of the code with a new bit sequence
    func toggle(_ index: Int) -> WolframCode {
        // `bitArray` is guaranteed to have 8 elements by the constructor, so this is safe for now
        try! WolframCode(bitArray: bitArray.reversed().toggle(bitArray.endIndex - 1 - index))
    }
}
