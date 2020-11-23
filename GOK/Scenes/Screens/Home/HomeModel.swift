//
//  HomeModel.swift
//  GOK
//
//  Created by Daniel Rambo on 23/11/20.
//

import Foundation

struct HomeModelSpotlight: Codable {
    let name: String
    let bannerURL: String
    let description: String
}

struct HomeModelProduct: Codable {
    let name: String
    let imageURL: String
    let description: String
}

struct HomeModelCash: Codable {
    let title: String
    let bannerURL: String
    let description: String
}

struct HomeModel: Codable {
    let spotlight: [HomeModelSpotlight]
    let products: [HomeModelProduct]
    let cash: HomeModelCash
}
