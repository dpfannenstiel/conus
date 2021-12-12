//
//  Generation.swift
//  Conus
//
//  Created by Dustin Pfannenstiel on 12/12/21.
//

import Foundation

/// A generation of the cellular automata
typealias Generation = Array<Bit>

/// Errors thrown during operations on generations
enum GenerationError: Error {
    /// Thrown when creation of a new generation fails
    case iterationError
}

extension Generation {
    /// Parent bits for a Generation
    /// - precondition: The Generation must have at least 3 elements in the generation.
    /// Otherwise an empty array is returned.
    var parentBits: [Bits] {
        guard self.count > 2 else {
            return []
        }
        return self
            .enumerated()
            .map { index, value -> [Bit] in
                switch index {
                case 0:
                    return [.off] + Array(self[0...1])
                case self.count - 1:
                    return Array(self[(index-1)...]) + [.off]
                default:
                    return Array(self[(index-1)...(index+1)])
                }
            }
            .map { $0.reversed() }
    }

    /// Generate a descendent generation to the current.
    /// - parameters:
    ///     - code: The WolframCode to use to generate a new generation
    ///     - times: How many generations from the parent the descendent is, defaults to 1
    /// - returns: The descendent generation removed `times` generations. 1 is a direct child
    func generate(with code: WolframCode, times: Int = 1) throws -> Generation {
        try (0..<times).reduce(self) { partialResult, _ in
            try partialResult.parentBits.map {
                guard let bits = code[$0] else {
                    throw GenerationError.iterationError
                }
                return bits
            }
        }
    }

    /// Produce all the generations, inclusive to `self`.
    /// - parameters:
    ///     - times: How many times to produce a subsequent generation
    ///     - code: The `WolframCode` to use to produce a generation
    /// - returns: All the generations in a over the given time
    func generate(times: Int, with code: WolframCode) throws -> [Generation] {
        try (0..<times).reduce([self]) { partialResult, _ in
            guard let last = partialResult.last else {
                throw GenerationError.iterationError
            }
            return partialResult + [try last.generate(with: code)]
        }
    }
}

/// Produce an initial generation out of how many expected generations
///
/// Generations are expected to have a cell in the middle set to `Bit.on` with equal numbers of cells on each side.
/// - parameter max: The maximum number of requested generations
/// - returns: The initial `Generation`
func readyZerothGeneration(of max: Int) -> Generation {
    let cellCount = mid(maxCells(for: max))
    return Array(repeating: .off, count: cellCount) + [.on] + Array(repeating: .off, count: cellCount)
}

/// Calculate the max cells required for a generation
/// - parameter generation: The requested generation
/// - returns: The number of cells required to satisfy the generation buffer
func maxCells(for generation: Int) -> Int {
    generation * 2 + 1
}

/// Determine the mid point of generation index run
/// - parameter value: The number of cells in a generation
/// - returns: The the value to use as the middle
func mid(_ value: Int) -> Int {
    (value / 2)
}

enum GenerationDefaults {
    /// The default generation
    static let `default` = 30.0
    /// The minimum generation
    static let min = 20.0
    /// The maximum generation
    static let max = 50.0
}



