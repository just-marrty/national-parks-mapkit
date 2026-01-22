//
//  FetchService.swift
//  NationalParks
//
//  Created by Martin Hrbáček on 19.01.2026.
//

import Foundation

enum FileError: Error {
    case invalidURL
    case decodingFail
}

struct FetchService {
    
    func fetchParks() async throws -> [Park] {
        guard let url = Bundle.main.url(forResource: "nationalparks", withExtension: "json") else {
            throw FileError.invalidURL
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Park].self, from: data)
        } catch {
            throw FileError.decodingFail
        }
    }
}
