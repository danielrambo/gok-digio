//
//  MockRemoteService.swift
//  GOKTests
//
//  Created by Daniel Rambo on 23/11/20.
//

import Foundation
@testable import GOK

struct MockRemoteService: RemoteService {

    // MARK: - Init

    init(mockResponseData: Data?) {
        self.mockResponseData = mockResponseData
    }

    // MARK: - Property

    private var mockResponseData: Data?
    private var error: Error?

    // MARK: - RemoteService

    let rootPath: String = "http://web.com/"
    func execute(httpMethod: RemoteMethod,
                 apiPath: String,
                 urlQueries: [String: String]?,
                 httpBody: Data?,
                 onCompletion: @escaping (RemoteServiceResponse) -> Void) {

        let response = RemoteServiceResponse(data: mockResponseData,
                                             error: mockResponseData == nil ? MockNetworkError.mock : nil)
        onCompletion(response)
    }
}
