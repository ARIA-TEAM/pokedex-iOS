//
//  Pokemon.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 01-07-23.
//

import Foundation

/**
 The `Pokemon` struct represents a Pokemon with its name and URL.
 */
struct Pokemon: Codable, Equatable {
    let name: String
    let url: String
    var isStarted: Bool?
}

