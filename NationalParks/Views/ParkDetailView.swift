//
//  ParkDetailView.swift
//  NationalParks
//
//  Created by Martin Hrbáček on 19.01.2026.
//

import SwiftUI
import MapKit

struct ParkDetailView: View {
    
    let park: ParkViewModel
    
    @State var position: MapCameraPosition
    @State private var symbolBounce: Bool = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(park.image)
                    .resizable()
                    .scaledToFit()
                    .overlay {
                        LinearGradient(
                            stops: [Gradient.Stop(
                                color: .clear,
                                location: 0.8
                            ),
                                    Gradient
                                .Stop(
                                    color: .black,
                                    location: 1
                                )],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    }
            }
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    VStack {
                        Text(park.name)
                            .font(.system(size: 24, weight: .heavy, design: .rounded))
                            .shadow(radius: 15)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 5)
                        ForEach(park.state, id: \.self) { state in
                            Text(state)
                                .font(.system(size: 18, design: .rounded))
                                .bold()
                                .shadow(radius: 15)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    NavigationLink {
                        ParkMapView(
                            park: park,
                            position: .camera(
                                MapCamera(
                                    centerCoordinate: park.location,
                                    distance: 200000
                                )
                            )
                        )
                    } label: {
                        Map(position: $position) {
                            Annotation(park.name, coordinate: park.location) {
                                Image(systemName: Strings.treeFill)
                                    .font(.system(size: 12))
                                    .symbolEffect(.bounce, options: .repeat(.periodic(delay: 1)), value: symbolBounce)
                                    .foregroundStyle(.black.opacity(0.5))
                                    .onAppear {
                                        symbolBounce = true
                                    }
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(width: 150, height: 130)
                        .clipShape(.rect(cornerRadius: 15))
                        .shadow(radius: 25)
                    }
                }
                .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(Strings.description)
                        .font(.system(size: 22, weight: .heavy, design: .rounded))
                        .shadow(radius: 15)
                    Text(park.description)
                        .font(.system(size: 18, design: .rounded))
                }
                .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(Strings.weatherInfo)
                        .font(.system(size: 22, weight: .heavy, design: .rounded))
                        .shadow(radius: 15)
                    Text(park.weatherInfo)
                        .font(.system(size: 18, design: .rounded))
                }
                .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(Strings.parkAccess)
                        .font(.system(size: 22, weight: .heavy, design: .rounded))
                        .shadow(radius: 15)
                    Text(park.parkAccess)
                        .font(.system(size: 18, design: .rounded))
                }
                .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(Strings.officialLink)
                        .font(.system(size: 22, weight: .heavy, design: .rounded))
                        .shadow(radius: 15)
                    
                    if let url = park.officialWebsite {
                        Link(url.absoluteString, destination: url)
                            .font(.system(size: 18, design: .rounded))
                    } else {
                        Text(Strings.notAvailable)
                            .font(.system(size: 18, design: .rounded))
                    }
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .padding(.bottom, 30)
        .ignoresSafeArea()
    }
}


#Preview {
    NavigationStack {
        ParkDetailView(park: .sampleParkDetailView, position: .camera(MapCamera(centerCoordinate: ParkViewModel.sampleParkDetailView.location, distance: 100000)))
    }
}
