//
//  ParkMainView.swift
//  NationalParks
//
//  Created by Martin Hrbáček on 19.01.2026.
//

import SwiftUI
import MapKit

struct ParkMainView: View {
    
    @State private var parkVM = ParkListViewModel(fetchService: FetchService())
    
    private let columns: [GridItem] = [GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            VStack {
                if let errorMessage = parkVM.errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundStyle(.orange)
                            .bold()
                            .font(.system(size: 28, design: .rounded))
                        Text("Oups")
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
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 20, design: .rounded))
                                .bold()
                                .padding(5)
                        }
                        
                    }
                    .multilineTextAlignment(.center)
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
                        ParkDetailView(park: park, position: .camera(MapCamera(centerCoordinate: park.location, distance: 100000)))
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                Task {
                                    withAnimation(.easeIn(duration: 0.5)) {
                                        parkVM.isLoading = true
                                    }
                                    await parkVM.loadParks()
                                    withAnimation(.easeInOut(duration: 0.8)) {
                                        parkVM.isLoading = false
                                    }
                                }
                            } label: {
                                Image(systemName: "arrow.clockwise")
                            }
                        }
                    }
                }
            }
            .navigationTitle("National Parks")
            .navigationSubtitle("Top 20 - USA")
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
