//
//  CityResponse.swift
//  Someting
//
//  Created by Михаил on 27.06.2023.
//

import Foundation

struct CityResponse: Decodable {
    let data: [City]
}

struct WikiResponse: Decodable {
    let query: Query
}

struct Query: Decodable {
    let geosearch: [City]
}
