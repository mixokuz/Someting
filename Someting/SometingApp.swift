//
//  SometingApp.swift
//  Someting
//
//  Created by Михаил on 27.06.2023.
//

import SwiftUI
import CoreLocation

@main
struct SometingApp: App {
    var cityListViewModel = CityListViewModel()
    
    var body: some Scene {
        WindowGroup {
            MapView()
        }
    }
}
