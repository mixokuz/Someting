//
//  CityListView.swift
//  Someting
//
//  Created by Михаил on 27.06.2023.
//

import SwiftUI
import CoreLocation
import MapKit

protocol CityListViewProtocol: View {
    func setCities(cities: [City]) 
}

struct CityListView: CityListViewProtocol {
    @State var cities: [City]?
    @Binding var region: MKCoordinateRegion
    @StateObject private var viewModel = CityListViewModel()
    
    var body: some View {
        NavigationStack {
            List(cities ?? [City](), id: \.id) { city in
                NavigationLink(destination:  CityView(cityViewModel: CityViewModel(city: city))) { Label(city.name, systemImage: "globe")
                }
            }
        }
        .onChange(of: region.center) { value in
            viewModel.onChange()
        }
        .onAppear {
            Task {
                await viewModel.setup(view:self, coordinate: region.center)
            }
        }
    }
    
    func setCities(cities: [City]) {
        self.cities = cities
    }
}

struct CityListView_Previews: PreviewProvider {
    
    static var previews: some View {
        CityListView(region: .constant(MKCoordinateRegion(center: .init(latitude: 0, longitude: 0), span: .init(latitudeDelta: 0.5, longitudeDelta: 0.5))))
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        if lhs.latitude == rhs.latitude && lhs.longitude == rhs.latitude {
            return true
        }
        return false
    }
    
    
}
