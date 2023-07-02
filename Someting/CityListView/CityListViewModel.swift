//
//  CityListViewModel.swift
//  Someting
//
//  Created by Михаил on 27.06.2023.
//

import CoreLocation
import Foundation
import SwiftUI

protocol CityListViewModelProtocol: ObservableObject {
    var cities: CityListModel? { get set }
    
    func setup(view: CityListView?, coordinate: CLLocationCoordinate2D) async
    func onChange()
}

class CityListViewModel: CityListViewModelProtocol {
    var cities: CityListModel?
    let network: NetworkProtocol
    var view: CityListView?
    var timer: Timer?
    
    init() {
        network = Network()
    }
    
    func onChange() {
        if timer == nil {
            print("timer started")
            timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updateList), userInfo: nil, repeats: false)
        }
    }
    
    func setup(view: CityListView?, coordinate: CLLocationCoordinate2D) async {
        self.view = view
        do {
            let coord = Coordinate(latitude: Float(round(coordinate.latitude * 10000000)/10000000), longitude: Float(round(coordinate.longitude * 10000000)/10000000))
            print("cooord", coord)
            guard let newCities = try await network.makerequestForCities(coordinate: coord) else { return }
            cities = CityListModel(cities: newCities)
            await view?.setCities(cities: cities?.cities ?? [])
        } catch {
            print(error)
        }
    }
    
    @objc func updateList() {
        Task {
            await setup(view: view, coordinate: view?.region.center ?? CLLocationCoordinate2D())
            await view?.setCities(cities: cities?.cities ?? [])
            timer = nil
        }
       
    }
}
