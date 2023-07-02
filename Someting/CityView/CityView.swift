//
//  CityView.swift
//  Someting
//
//  Created by Михаил on 27.06.2023.
//

import SwiftUI

struct CityView: View {
    var cityViewModel: CityViewModel
    var body: some View {
        VStack {
            Text(cityViewModel.city?.name ?? "")
            Text(String(cityViewModel.city?.population ?? 0))
        }
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView(cityViewModel: CityViewModel(city: City(name: "NAME", coordinate: Coordinate(latitude: 22, longitude: 22),  population: 122, country: "ff")))
    }
}
