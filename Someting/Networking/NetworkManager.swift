//
//  NetworkManager.swift
//  Someting
//
//  Created by Михаил on 27.06.2023.
//

import Foundation

protocol NetworkProtocol: AnyObject {
    func makerequestForCities(coordinate: Coordinate) async throws -> [City]?
}

class Network: NetworkProtocol {
    func makerequestForCities(coordinate: Coordinate) async throws -> [City]? {
        do {            
            guard let newURL = URL(string: "https://en.wikipedia.org/w/api.php?action=query&format=json&list=geosearch&formatversion=2&gscoord=\(coordinate.latitude)%7C\(coordinate.longitude)&gsradius=10000") else { throw DummyError.dummyError }
        
            var request = URLRequest(url: newURL)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(decoding: data, as: UTF8.self))
            let decoder = JSONDecoder()
            let decodedCities = try decoder.decode(WikiResponse.self, from: data)
            print ("ffff", decodedCities)
            return decodedCities.query.geosearch
        } catch {
            print("Ошибка загрузки данных: \(error)")
            return nil
        }
    }
}

enum DummyError: Error {
    case dummyError
}
