//
//  Park.swift
//  NationalParks
//
//  Created by Martin Hrbáček on 19.01.2026.
//

import Foundation
import MapKit

struct Park: Decodable, Identifiable, Hashable {
    var id = UUID()
    
    let name: String
    let state: [String]
    let parkAccess: String
    let description: String
    let weatherInfo: String
    let longitude: Double
    let latitude: Double
    let officialWebsite: String?
    
    var image: String {
        name.lowercased()
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "ʻ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    enum CodingKeys: CodingKey {
        case name
        case state
        case parkAccess
        case description
        case weatherInfo
        case longitude
        case latitude
        case officialWebsite
    }
}
