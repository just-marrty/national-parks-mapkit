//
//  Logger+Extensions.swift
//  NationalParks
//
//  Created by Martin Hrbáček on 28.01.2026.
//

import Foundation
import OSLog

extension Logger {
    static let subsystem = Bundle.main.bundleIdentifier!
    static let app = Logger(subsystem: subsystem, category: "App")
    static let loadParks = Logger(subsystem: subsystem, category: "LoadParks")
    static let fetchService = Logger(subsystem: subsystem, category: "FetchService")
    static let parkMainView = Logger(subsystem: subsystem, category: "ParkMainView")
}
