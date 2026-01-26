//
//  ParkMapView.swift
//  NationalParks
//
//  Created by Martin Hrbáček on 20.01.2026.
//

import SwiftUI
import MapKit

struct ParkMapView: View {
    
    let park: ParkViewModel
    
    @State var position: MapCameraPosition
    
    @State private var selectedOption: MapOptions = .standard
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(position: $position) {
                Annotation(park.name, coordinate: park.location) {
                    Image(systemName: Strings.treeFill)
                }
                .annotationTitles(.hidden)
            }
            .mapStyle(selectedOption.mapStyle)
            
            Picker(Strings.mapOptions, selection: $selectedOption) {
                ForEach(MapOptions.allCases, id: \.self) { style in
                    Text(style.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 250)
            .glassEffect(.regular)
            .padding(.bottom, 40)
        }
    }
}

#Preview {
    ParkMapView(park: .sampleParkDetailView, position: .camera(MapCamera(centerCoordinate: ParkViewModel.sampleParkDetailView.location, distance: 200000)))
}
