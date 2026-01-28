//
//  ParksListViewModel.swift
//  NationalParks
//
//  Created by Martin Hrbáček on 19.01.2026.
//

import Foundation
import Observation
import MapKit
import OSLog

@Observable
@MainActor
class ParkListViewModel {
    var parks: [ParkViewModel] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    private let logger = Logger.loadParks
    
    private let fetchService: FetchServiceProtocol
    
    init(fetchService: FetchServiceProtocol) {
        self.fetchService = fetchService
    }
    
    func loadParks() async {
        logger.info("Parks are loading")
        errorMessage = nil
        do {
            let parks = try await fetchService.fetchParks()
            logger.info("Parks loaded successfully")
            self.parks = parks.map(ParkViewModel.init)
        } catch {
            logger.error("Loading parks failed")
            errorMessage = Strings.errorMessage
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
