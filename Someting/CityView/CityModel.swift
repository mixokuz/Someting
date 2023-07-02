//
//  CityModel.swift
//  Someting
//
//  Created by Михаил on 27.06.2023.
//

import Foundation

struct City : Decodable {
    let id: String
    let name: String
    let coordinate: Coordinate
    let population: Int
    let country: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "title"
        case id = "pageid"
//        case population
//        case country = "countryCode"
        case latitude = "lat"
        case longitude = "lon"
//        case coordinate = "geoCode"
//        case address = "address"
    }
    
    init(name: String, coordinate: Coordinate, population: Int, country: String) {
        id = UUID().uuidString
        self.name = name
        self.coordinate = coordinate
        self.population = population
        self.country = country
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = String(try container.decode(Int.self, forKey: .id))
        name = try container.decode(String.self, forKey: .name)
        population = 0
        coordinate = try {
            let latitude = try container.decode(Float.self, forKey: .latitude)
            let longitude = try container.decode(Float.self, forKey: .longitude)
            return Coordinate(latitude: latitude, longitude: longitude)
        }()
        country = ""
    }
}

struct Coordinate: Decodable {
    let latitude: Float
    let longitude: Float
}

struct Address: Decodable {
    let countryCode: String
    let stateCode: String
}
