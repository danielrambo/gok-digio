//
//  HomeViewModel.swift
//  GOK
//
//  Created by Daniel Rambo on 23/11/20.
//

import Foundation
import UIKit

enum HomeEvent {
    case viewDidApper
}

enum HomeEventState {
    case isLoading
    case modalError(Error)
    case updateValues(Values)
    
    struct Values {
        var spotlight: [UIImage] = []
        var cash: UIImage?
        var products: [UIImage] = []
    }
}

final class HomeViewModel {
    
    // MARK: Init
    
    init() {
        let urlPath = "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/"
        self.repository = HomeRepositoryImplementation(service: URLSessionRemote(rootPath: urlPath))
    }
    
    // MARK: Properties
    
    private let repository: HomeRepositoryImplementation!
    private var stateValues = HomeEventState.Values()
    private var observable: ((HomeEventState) -> Void)?
}

// MARK: - Methods

extension HomeViewModel {
    func send(in event: HomeEvent) {
        switch event {
        case .viewDidApper:
            fetchList()
        }
    }
    
    func setObservable(observable: @escaping ((HomeEventState) -> Void)) {
        self.observable = observable
    }
}

// MARK: - Private Methods

private extension HomeViewModel {
    func fetchList() {
        guard let observable = self.observable else { return }
        observable(.isLoading)
        repository.execute { response, error in
            DispatchQueue.main.async {
                if let error = error {
                    guard let observable = self.observable else { return }
                    observable(.modalError(error))
                    return
                }
                
                guard let response = response else { return }
                var arraySpotlight: [UIImage] = []
                var arrayProducts: [UIImage] = []
                
                for item in response.spotlight {
                    if let imageSpotlight = self.getImageUrl(image: item.bannerURL) {
                        arraySpotlight.append(imageSpotlight)
                    }
                }
                
                for item in response.products {
                    if let imageProduct = self.getImageUrl(image: item.imageURL) {
                        arrayProducts.append(imageProduct)
                    }
                }
                
                self.stateValues.spotlight = arraySpotlight
                self.stateValues.cash = self.getImageUrl(image: response.cash.bannerURL)
                self.stateValues.products = arrayProducts
                observable(.updateValues(self.stateValues))
            }
        }
    }
    
    func getImageUrl(image: String) -> UIImage? {
        if let url = URL(string: image) {
            if let data = try? Data(contentsOf: url) {
                return UIImage(data: data)
            }
        }
        
        return nil
    }
}
