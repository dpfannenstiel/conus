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

    /// Toggle the element for the index
    /// - parameter index: Index of the element to toggle
    /// - returns: An array with a single element toggled, if the index is in the indices.
    func toggle(_ index: Int) -> [Bit] {
        enumerated().map { idx, element in
            idx == index ? element.toggle() : element
        }
    }
}
