//
//  NationalParksApp.swift
//  NationalParks
//
//  Created by Martin Hrbáček on 19.01.2026.
//

import SwiftUI
import OSLog

@main
struct NationalParksApp: App {
    
    private let logger = Logger.app
    
    var body: some Scene {
        WindowGroup {
            ParkMainView()
                .onAppear {
                    logger.info("App started")
                }
        }
    }
}
