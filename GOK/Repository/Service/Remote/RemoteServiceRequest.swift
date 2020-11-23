//
//  RemoteServiceRequest.swift
//  GOK
//
//  Created by Daniel Rambo on 23/11/20.
//

import Foundation

public struct RemoteServiceRequest: Equatable {
    let httpMethod: RemoteMethod
    let urlPath: String
    let urlQueries: [String: String]?
    let httpBody: Data?
}
