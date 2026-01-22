//
//  MapOptions.swift
//  NationalParks
//
//  Created by Martin Hrbáček on 21.01.2026.
//

import Foundation
import SwiftUI
import MapKit

enum MapOptions: String, CaseIterable {
    case standard
    case hybrid
    case imagery
    
    var mapStyle: MapStyle {
        switch self {
        case .standard:
            return .standard
        case .hybrid:
            return .hybrid
        case .imagery:
            return .imagery
        }
    }
}
