//
//  TagParser.swift
//  GOK
//
//  Created by Daniel Rambo on 23/11/20.
//

import UIKit

struct TagParser {

    // MARK: - Init

    init(string: String, font: UIFont = UIFont.boldSystemFont(ofSize: 20.0), color: UIColor = .black) {
        self.string = string
        self.font = font
        self.color = color
    }

    // MARK: - Property

    let string: String
    let font: UIFont
    let color: UIColor

    var attributedString: NSAttributedString {
        let str = string.replacingOccurrences(
                   of: "<br>", with: "\n", options: .regularExpression, range: nil)
        let convertedDescription = str.replacingOccurrences(
           of: "<[^>]+>", with: "", options: .regularExpression, range: nil) as NSString

        let mutableAttributedString = NSMutableAttributedString(
            string: convertedDescription as String,
            attributes: [
                .font: font,
                .foregroundColor: color
            ]
        )
        
        let blueRegex = "<blue>(.*?)</blue>"
        let blueAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hexString: "#005779"),
            .font: font
        ]
        parse(tagRegex: blueRegex, with: blueAttributes, in: mutableAttributedString)

        return mutableAttributedString
    }

    private func parse(tagRegex: String,
                       with attributes: [NSAttributedString.Key: Any],
                       in mutableAttributedString: NSMutableAttributedString) {
        let regex = try! NSRegularExpression(pattern: tagRegex, options: [])
        let substringList = substrings(string: string, for: regex)

        mutableAttributedString.apply(attributes: attributes, in: substringList)
    }
    
    func substrings(string: String, for regex: NSRegularExpression) -> [String] {
        var substrings: [String] = []
        let nsString = string as NSString

        regex.enumerateMatches(
            in: string,
            options: [.reportCompletion],
            range: NSMakeRange(0, string.count)
        ) { result, flags, stop in
            if let range = result?.range(at: 1) {
                substrings.append(nsString.substring(with: range))
            }
        }

        return substrings
    }
}
