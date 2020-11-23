//
//  UIViewExtension.swift
//  GOK
//
//  Created by Daniel Rambo on 23/11/20.
//

import UIKit

public extension UIView {
    func embed(newView: UIView, padding: UIEdgeInsets = .zero, ignore: [UIRectEdge] = []) {
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addSubview(newView)
        
        if ignore.contains(.all) {
            return
        }
        
        if ignore.contains(.top) == false {
            let constraint = newView.topAnchor.constraint(equalTo: topAnchor, constant: padding.top)
            constraint.identifier = "topAnchor.constraint"
            constraint.isActive = true
        }
        
        if ignore.contains(.right) == false {
            let constraint = newView.rightAnchor.constraint(equalTo: rightAnchor,
                                                            constant: padding.right * -1.0)
            constraint.identifier = "rightAnchor.constraint"
            constraint.isActive = true
        }
        
        if ignore.contains(.bottom) == false {
            let constraint = newView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                             constant: padding.bottom * -1.0)
            constraint.identifier = "bottomAnchor.constraint"
            constraint.isActive = true
        }
        
        if ignore.contains(.left) == false {
            let constraint = newView.leftAnchor.constraint(equalTo: leftAnchor, constant: padding.left)
            constraint.identifier = "leftAnchor.constraint"
            constraint.isActive = true
        }
    }
}
