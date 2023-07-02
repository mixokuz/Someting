//
//  CityViewModel.swift
//  Someting
//
//  Created by Михаил on 27.06.2023.
//

import Foundation

protocol CityViewModelProtocol: ObservableObject {
    var city: City? { get set }
}

class CityViewModel: CityViewModelProtocol {
    @Published var city: City?
    
    init() {
        
    }
    
    init(city: City) {
        self.city = city
    }
}
