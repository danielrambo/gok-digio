//
//  UIEdgeInsetsExtension.swift
//  GOK
//
//  Created by Daniel Rambo on 23/11/20.
//

import UIKit

public extension UIEdgeInsets {
    static let all16 = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    static let h16 = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
    static let v32h16 = UIEdgeInsets(top: 32.0, left: 16.0, bottom: 32.0, right: 16.0)
    
    static let top16h16 = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 0.0, right: 16.0)
    static let left32Right16 = UIEdgeInsets(top: 0.0, left: 32.0, bottom: 0.0, right: 16.0)
    static let bottom64 = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 64.0, right: 0.0)
}
