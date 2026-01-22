//
//  ParksListViewModel.swift
//  NationalParks
//
//  Created by Martin Hrbáček on 19.01.2026.
//

import Foundation
import Observation
import MapKit

@Observable
@MainActor
class ParkListViewModel {
    var parks: [ParkViewModel] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let fetchService: FetchService
    
    init(fetchService: FetchService) {
        self.fetchService = fetchService
    }
    
    func loadParks() async {
        errorMessage = nil
        do {
            let parks = try await fetchService.fetchParks()
            self.parks = parks.map(ParkViewModel.init)
        } catch {
            errorMessage = "There seems to be a problem, we're sorry."
        }
    }
}

struct ParkViewModel: Identifiable, Hashable {
    
    private var park: Park
    
    init(park: Park) {
        self.park = park
    }
    
    var id: UUID {
        park.id
    }
    
    var name: String {
        park.name
    }
    var state: [String] {
        let state = park.state.joined(separator: ", ")
        return [state]
    }
    var parkAccess: String {
        park.parkAccess
    }
    var description: String {
        park.description
    }
    var weatherInfo: String {
        park.weatherInfo
    }
    var longitude: Double {
        park.longitude
    }
    var latitude: Double {
        park.latitude
    }
    var image: String {
        park.image
    }
    var location: CLLocationCoordinate2D {
        park.location
    }
    var officialWebsite: URL? {
        guard let urlString = park.officialWebsite else { return nil }
        return URL(string: urlString)
    }
}
