//
//  FetchServiceProtocol.swift
//  NationalParks
//
//  Created by Martin Hrbáček on 26.01.2026.
//

import Foundation

protocol FetchServiceProtocol: Sendable {
    func fetchParks() async throws -> [Park]
}
