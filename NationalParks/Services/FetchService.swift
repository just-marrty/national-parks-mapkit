//
//  FetchService.swift
//  NationalParks
//
//  Created by Martin Hrbáček on 19.01.2026.
//

import Foundation
import OSLog

struct FetchService: FetchServiceProtocol {
    
    private let logger = Logger.fetchService
    
    func fetchParks() async throws -> [Park] {
        logger.info("Fetching JSON Started")
        guard let url = Bundle.main.url(forResource: JSONResource.nationalParks, withExtension: JSONResource.json) else {
            logger.error("Invalid JSON file")
            throw FileError.invalidURL
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let parks = try decoder.decode([Park].self, from: data)
            logger.info("Fetching JSON completed")
            return parks 
        } catch {
            logger.error("Decoding JSON Error: \(error.localizedDescription)")
            throw FileError.decodingFail
        }
    }
}
