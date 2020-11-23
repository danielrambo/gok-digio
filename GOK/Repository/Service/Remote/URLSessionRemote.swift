//
//  URLSessionRemote.swift
//  GOK
//
//  Created by Daniel Rambo on 23/11/20.
//

import Foundation

public struct URLSessionRemote: RemoteService {
    
    init(rootPath: String) {
        self.rootPath = rootPath
    }
    
    let rootPath: String
    let urlRegEx = "http[s]?://(([^/:.[:space:]]+(.[^/:.[:space:]]+)*)|([0-9](.[0-9]{3})))(:[0-9]+)?((/[^?#[:space:]]+)([^#[:space:]]+)?(#.+)?)?"
    
    func execute(httpMethod: RemoteMethod, apiPath: String, urlQueries: [String : String]?, httpBody: Data?, onCompletion: @escaping (RemoteServiceResponse) -> Void) {
        var urlComponents = URLComponents(string: rootPath + apiPath)
        if httpMethod == .get, let urlQueries = urlQueries, urlQueries.isEmpty == false {
            var queryItems: [URLQueryItem] = []

            for (key, value) in urlQueries {
                let queryItem = URLQueryItem(name: key, value: value)
                queryItems.append(queryItem)
            }

            urlComponents?.queryItems = queryItems
        }
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray: [urlRegEx])
        guard let url = urlComponents?.url, predicate.evaluate(with: url.absoluteString) else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.description
        urlRequest.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            let response = RemoteServiceResponse(data: data, error: error)
            onCompletion(response)
        }
        
        task.resume()
    }
    
}
