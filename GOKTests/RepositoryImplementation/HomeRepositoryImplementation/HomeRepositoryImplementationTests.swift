//
//  HomeRepositoryImplementationTests.swift
//  GOKTests
//
//  Created by Daniel Rambo on 23/11/20.
//

import XCTest
@testable import GOK

final class HomeRepositoryImplementationTests: XCTestCase {
    
    func testSuccess() {
        let expectation = XCTestExpectation(description: "testSuccess")
        let jsonSpotlight = HomeModelSpotlight(name: "Test",
                                               bannerURL: "http://google.com.br/image.jpg",
                                               description: "Test description")
        let jsonProduct = HomeModelProduct(name: "Test",
                                           imageURL: "http://google.com.br/image.jpg",
                                           description: "Test description")
        let jsonCash = HomeModelCash(title: "Test",
                                     bannerURL: "http://google.com.br/image.jpg",
                                     description: "Test description")
        
        let json = HomeModel(spotlight: [jsonSpotlight],
                             products: [jsonProduct],
                             cash: jsonCash)
        
        let data = try! JSONEncoder().encode(json)
        let service = MockRemoteService(mockResponseData: data)
        let repository = HomeRepositoryImplementation(service: service)
        repository.execute { result, error in
            if let result = result {
                XCTAssertTrue(result.products.isEmpty == false)
                XCTAssertTrue(result.spotlight.isEmpty == false)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFailDecoder() {
        let expectation = XCTestExpectation(description: "testSuccess")
        let json = HomeModelCash(title: "Test",
                                 bannerURL: "http://google.com.br/image.jpg",
                                 description: "Test description")
        
        let data = try! JSONEncoder().encode(json)
        let service = MockRemoteService(mockResponseData: data)
        let repository = HomeRepositoryImplementation(service: service)
        repository.execute { result, error in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testNetworkFail() {
        let expectation = XCTestExpectation(description: "testNetworkFail")
        let service = MockRemoteService(mockResponseData: nil)
        let repository = HomeRepositoryImplementation(service: service)
        repository.execute { result, error in
            if let error = error {
                XCTAssertEqual(error.localizedDescription, "mock")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
    // MARK: - All Tests
    
    static var allTests = [
        ("testSuccess", testSuccess),
        ("testFailDecoder", testFailDecoder),
        ("testNetworkFail", testNetworkFail)
    ]
}
