//
//  RemoteMethod.swift
//  GOK
//
//  Created by Daniel Rambo on 23/11/20.
//

import Foundation

enum RemoteMethod {
    case get
    case post
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}
