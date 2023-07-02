//
//  PokemonListResponse.swift
//  Pokemon
//
//  Created by Josue German Hernandez Gonzalez on 01-07-23.
//

import Foundation

/**
 The `PokemonListResponse` struct represents the response from the Pokemon API,
 containing the count, next page URL, previous page URL, and an array of Pokemon objects.
 */
struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Pokemon]
}
