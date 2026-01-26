//
//  FetchService.swift
//  NationalParks
//
//  Created by Martin Hrbáček on 19.01.2026.
//

import Foundation

struct FetchService: FetchServiceProtocol {
    
    func fetchParks() async throws -> [Park] {
        guard let url = Bundle.main.url(forResource: JSONResource.nationalParks, withExtension: JSONResource.json) else {
            print("Invalid URL")
            throw FileError.invalidURL
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Park].self, from: data)
        } catch {
            print("Decoding Error: \(error.localizedDescription)")
            throw FileError.decodingFail
        }
    }
}
