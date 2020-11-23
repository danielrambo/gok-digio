//
//  RemoveService.swift
//  GOK
//
//  Created by Daniel Rambo on 23/11/20.
//

import Foundation

protocol RemoteService {
    var rootPath: String { get }
    func execute(httpMethod: RemoteMethod,
                 apiPath: String,
                 urlQueries: [String: String]?,
                 httpBody: Data?,
                 onCompletion: @escaping (RemoteServiceResponse) -> Void)
}
