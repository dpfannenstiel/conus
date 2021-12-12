//
//  Bit.swift
//  Conus
//
//  Created by Dustin Pfannenstiel on 12/11/21.
//

import Foundation

/// A single bit of binary data.
enum Bit: UInt8 {
    /// The bit is off.
    case off = 0
    /// The bit is on
    case on  = 1

    /// Toggle the value of a bit
    func toggle() -> Bit {
        switch self {
        case .on:
            return .off
        case .off:
            return .on
        }
    }
}

/// An array of bits. `Bits` should always be Little Endian. This allows the index to be the power of the bit when
/// expanding to another base.
typealias Bits = [Bit]
