//
//  HomeRepositoryImplementation.swift
//  GOK
//
//  Created by Daniel Rambo on 23/11/20.
//

import Foundation

struct HomeRepositoryImplementation {
    
    // MARK: - Init
    
    init(service: RemoteService) {
        self.service = service
    }
    
    // MARK: - Properties
    
    private var service: RemoteService!
    
    // MARK: Methods
    
    func execute(onCompletion: @escaping (HomeModel?, Error?) -> Void) {
        service.execute(httpMethod: .get,
                        apiPath: "sandbox/products",
                        urlQueries: nil,
                        httpBody: nil) { response in
            if let error = response.error {
                onCompletion(nil, error)
                return
            }
             
            do {
                let decodeJSON = try JSONDecoder().decode(HomeModel.self, from: response.data!)
                onCompletion(decodeJSON, nil)
            } catch {
                onCompletion(nil, error)
            }
        }
    }
}
