//
//  Array+Bit.swift
//  Conus
//
//  Created by Dustin Pfannenstiel on 12/11/21.
//

import Foundation

extension Array where Element == Bit {
    /// Produces an UInt8 number number, assuming little endian.
    /// Returns nil if more than 8 bits are present
    var littleEndianUInt8: UInt8? {
        guard self.count <= 8 else {
            return nil
        }
        return self.enumerated()
            .map { $1.rawValue << $0 }
            .reduce(into: UInt8(0)) { partialResult, value in
                partialResult = partialResult | value
            }
    }
}
