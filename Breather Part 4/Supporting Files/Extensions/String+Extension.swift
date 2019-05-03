//
//  String+Extension.swift
//  Breather
//
//  Created by Alexandros Baramilis on 11/04/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import Foundation

extension String {
    /// Returns the indices of all the numbers in the string.
    ///
    /// If a number is directly preceded by a dot/comma, the index of the dot/comma
    /// will also be returned.
    /// This accounts for potential numbers with decimal or thousands separators.
    var indicesOfNumbers: [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex
        while searchStartIndex < self.endIndex,
            let range = self.rangeOfCharacter(from: CharacterSet.decimalDigits,
                                              range: searchStartIndex..<self.endIndex),
            !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            if index > 0 {
                let previousIndex = self.index(self.startIndex, offsetBy: index - 1)
                if let previousCharacter = self[previousIndex].unicodeScalars.first,
                    (previousCharacter == "." || previousCharacter == ",")
                {
                    indices.append(index - 1)
                }
            }
            indices.append(index)
            searchStartIndex = range.upperBound
        }
        return indices
    }
}
