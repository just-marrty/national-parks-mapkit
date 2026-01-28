//
//  ParkMainView.swift
//  NationalParks
//
//  Created by Martin Hrbáček on 19.01.2026.
//

import SwiftUI
import MapKit
import OSLog

struct ParkMainView: View {
    
    @State private var parkVM: ParkListViewModel
    
    init(fetchService: FetchServiceProtocol = FetchService()) {
        _parkVM = State(wrappedValue: ParkListViewModel(fetchService: fetchService))
    }
    
    private let columns: [GridItem] = [GridItem(.flexible())]
    
    private let logger = Logger.parkMainView
    
    var body: some View {
        NavigationStack {
            VStack {
                if let errorMessage = parkVM.errorMessage {
                    VStack {
                        Image(systemName: Strings.exclamationMarkTriangle)
                            .foregroundStyle(.orange)
                            .bold()
                            .font(.system(size: 28, design: .rounded))
                        Text(Strings.oups)
                            .font(.system(size: 26, design: .rounded))
                            .bold()
                            .padding(5)
                        Text(errorMessage)
                            .font(.system(size: 22, design: .rounded))
                            .bold()
                            .padding(5)
                        Button {
                            Task {
                                await parkVM.loadParks()
                            }
                        } label: {
                            Image(systemName: Strings.arrowClockwise)
                                .font(.system(size: 20, design: .rounded))
                                .bold()
                                .padding(5)
                        }
                        
                    }
                    .multilineTextAlignment(.center)
                    .onAppear {
                        logger.error("Error block appeared")
                    }
                    .padding()
                } else if !parkVM.isLoading {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(parkVM.parks) { park in
                                NavigationLink(value: park) {
                                    ZStack(alignment: .bottom) {
                                        Image(park.image)
                                            .resizable()
                                            .scaledToFit()
                                        VStack {
                                            Text(park.name).foregroundStyle(.black)
                                                .font(.system(size: 22, design: .rounded))
                                            HStack {
                                                ForEach(park.state, id: \.self) { state in
                                                    HStack {
                                                        Text(state)
                                                            .font(.system(size: 16, design: .rounded))
                                                            .foregroundStyle(.black)
                                                    }
                                                }
                                            }
                                        }
                                        .padding(5)
                                        .frame(maxWidth: .infinity)
                                        .background(.white.opacity(0.7))
                                    }
                                    .cornerRadius(12)
                                    .frame(width: 360)
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .safeAreaPadding(10)
                    .padding(.horizontal, 5)
                    .navigationDestination(for: ParkViewModel.self) { park in
                        logger.info("Navigating to park detail: \(park.name)")
                        return ParkDetailView(park: park, position: .camera(MapCamera(centerCoordinate: park.location, distance: 100000)))
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                logger.debug("Reload button tapped")
                                Task {
                                    withAnimation(.easeIn(duration: 0.5)) {
                                        parkVM.isLoading = true
                                    }
                                    await parkVM.loadParks()
                                    withAnimation(.easeInOut(duration: 0.8)) {
                                        parkVM.isLoading = false
                                    }
                                    logger.info("Grid of parks reloaded")
                                }
                            } label: {
                                Image(systemName: Strings.arrowClockwise)
                            }
                        }
                    }
                }
            }
            .navigationTitle(Strings.nationalParks)
            .navigationSubtitle(Strings.top20USA)
        }
        .task {
            parkVM.isLoading = true
            await parkVM.loadParks()
            withAnimation(.easeIn(duration: 0.8)) {
                parkVM.isLoading = false
            }
        }
    }
}

#Preview {
    ParkMainView()}

#Preview("Decoding Fail Error") {
    struct ErrorService: FetchServiceProtocol {
        func fetchParks() async throws -> [Park] {
            throw FileError.decodingFail
        }
    }
    return ParkMainView(fetchService: ErrorService())
}

#Preview("Mock Data") {
    struct MockService: FetchServiceProtocol {
        func fetchParks() async throws -> [Park] {
            return [
                Park(
                    name: "Yellowstone National Park",
                    state: ["Wyoming", "Montana", "Idaho"],
                    parkAccess: "Always open",
                    description: "The world’s first national park and one of the most geologically active regions on Earth. Yellowstone is renowned for its extraordinary concentration of geysers, including Old Faithful, as well as vividly colored hot springs, fumaroles, and mud pots driven by volcanic heat below the surface. Beyond geothermal wonders, the park encompasses vast forests, sweeping valleys, rivers, waterfalls, and broad plateaus. Yellowstone also protects one of the largest intact temperate ecosystems, offering exceptional wildlife viewing with bison, elk, wolves, bears, and many other species roaming freely.",
                    weatherInfo: "Located at high elevation, Yellowstone experiences rapid and often unpredictable weather changes throughout the year. Winters are long and harsh, bringing heavy snowfall and prolonged cold that can persist into late spring. Summers are relatively short and mild, but sudden thunderstorms, sharp temperature drops, and even snowfall at higher elevations can occur. Visitors should be prepared for changing conditions in any season and plan for limited services during winter months.",
                    longitude: -110.5885,
                    latitude: 44.428,
                    officialWebsite: "https://www.nps.gov/yell"
                )
            ]
        }
    }
    return ParkMainView(fetchService: MockService())
}
