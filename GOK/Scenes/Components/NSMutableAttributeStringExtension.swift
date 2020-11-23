//
//  NSMutableAttributeStringExtension.swift
//  GOK
//
//  Created by Daniel Rambo on 23/11/20.
//

import Foundation

public extension NSMutableAttributedString {
    func apply(attributes: [NSAttributedString.Key: Any], in refSubstrings: [String]) {
        guard refSubstrings.isEmpty == false else { return }
        let nsString = string as NSString

        for refSubstring in refSubstrings {
            addAttributes(attributes, range: nsString.range(of: refSubstring))
        }
    }
}
