//
//  UILabel+Extension.swift
//  Breather
//
//  Created by Alexandros Baramilis on 11/04/2019.
//  Copyright © 2019 Alexandros Baramilis. All rights reserved.
//

import UIKit

extension UILabel {
    /// Sets the attributedText property of UILabel with an attributed string
    /// that displays the characters of the text at the given indices in subscript.
    func setAttributedTextWithSubscripts(text: String, indicesOfSubscripts: [Int]) {
        let font = self.font!
        let subscriptFont = font.withSize(font.pointSize * 0.7)
        let subscriptOffset = -font.pointSize * 0.3
        let attributedString = NSMutableAttributedString(string: text,
                                                         attributes: [.font : font])
        for index in indicesOfSubscripts {
            let range = NSRange(location: index, length: 1)
            attributedString.setAttributes([.font: subscriptFont,
                                            .baselineOffset: subscriptOffset],
                                           range: range)
        }
        self.attributedText = attributedString
    }
}
