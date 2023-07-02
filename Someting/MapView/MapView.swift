//
//  MapView.swift
//  Someting
//
//  Created by Михаил on 29.06.2023.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.797409, longitude: 30.448130), span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0))
    @State var timer: Timer? = nil
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack {
                    Text(String(format: "%.6f", region.center.latitude))
                    Text(String(format: "%.6f", region.center.longitude))
                }
                .padding()
                .background() { Color.white}
                .cornerRadius(10)
                VStack {
                    CityListView(region: $region)
                        .frame(height: 400)
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
